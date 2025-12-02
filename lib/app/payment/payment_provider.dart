import 'dart:developer' as developer;

import 'package:fgm_lyrics_app/app/data/payment_model.dart';
import 'package:fgm_lyrics_app/app/data/payment_repository.dart';
import 'package:fgm_lyrics_app/app/data/payunit_api_service.dart';
import 'package:fgm_lyrics_app/app/data/payunit_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Payment state for managing payment flow
class PaymentState {
  final bool isLoading;
  final String? error;
  final PayUnitInitializeResponse? initializeResponse;
  final PayUnitMakePaymentResponse? paymentResponse;
  final PayUnitPaymentStatusResponse? statusResponse;
  final String? selectedGateway;
  final String? currentTransactionId;

  const PaymentState({
    this.isLoading = false,
    this.error,
    this.initializeResponse,
    this.paymentResponse,
    this.statusResponse,
    this.selectedGateway,
    this.currentTransactionId,
  });

  PaymentState copyWith({
    bool? isLoading,
    String? error,
    PayUnitInitializeResponse? initializeResponse,
    PayUnitMakePaymentResponse? paymentResponse,
    PayUnitPaymentStatusResponse? statusResponse,
    String? selectedGateway,
    String? currentTransactionId,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      initializeResponse: initializeResponse ?? this.initializeResponse,
      paymentResponse: paymentResponse ?? this.paymentResponse,
      statusResponse: statusResponse ?? this.statusResponse,
      selectedGateway: selectedGateway ?? this.selectedGateway,
      currentTransactionId: currentTransactionId ?? this.currentTransactionId,
    );
  }

  /// Check if payment is successful
  bool get isPaymentSuccessful {
    return statusResponse?.data.transactionStatus.toUpperCase() == 'SUCCESS';
  }

  /// Check if payment is pending
  bool get isPaymentPending {
    return statusResponse?.data.transactionStatus.toUpperCase() == 'PENDING';
  }

  /// Check if payment failed
  bool get isPaymentFailed {
    final status = statusResponse?.data.transactionStatus.toUpperCase();
    return status == 'FAILED' || status == 'CANCELLED';
  }

  /// Get available payment providers
  List<PayUnitProvider> get availableProviders {
    return initializeResponse?.data.providers.where((payunitProvider) {
          return payunitProvider.country.countryCode == 'CM';
        }).toList() ??
        [];
  }
}

/// Payment provider for managing payment state and operations
class PaymentNotifier extends AsyncNotifier<PaymentState> {
  PaymentRepository get _repository => ref.read(paymentRepositoryProvider);

  @override
  Future<PaymentState> build() async {
    return const PaymentState();
  }

  /// Initialize payment with PayUnit
  Future<void> initializePayment({
    required Payment payment,
    required String returnUrl,
    required String notifyUrl,
  }) async {
    final currentState = state.hasValue
        ? state.requireValue
        : const PaymentState();
    state = AsyncValue.data(
      currentState.copyWith(isLoading: true, error: null),
    );

    try {
      developer.log(
        'Initializing payment for ${payment.email}',
        name: 'PaymentNotifier',
      );

      final response = await _repository.initializePayment(
        payment: payment,
        returnUrl: returnUrl,
        notifyUrl: notifyUrl,
      );

      state = AsyncValue.data(
        currentState.copyWith(
          isLoading: false,
          initializeResponse: response,
          currentTransactionId: response.data.transactionId,
        ),
      );

      developer.log(
        'Payment initialized: ${response.data.transactionId}',
        name: 'PaymentNotifier',
      );
    } catch (e) {
      developer.log(
        'Failed to initialize payment: $e',
        name: 'PaymentNotifier',
        level: 1000,
      );

      state = AsyncValue.data(
        currentState.copyWith(isLoading: false, error: _getErrorMessage(e)),
      );
    }
  }

  /// Process payment with selected gateway
  Future<void> processPayment({
    required Payment payment,
    required String gateway,
    required String returnUrl,
    required String notifyUrl,
  }) async {
    final currentState = state.hasValue
        ? state.requireValue
        : const PaymentState();

    if (currentState.currentTransactionId == null) {
      state = AsyncValue.data(
        currentState.copyWith(
          error: 'Aucune transaction initialisée. Veuillez réessayer.',
        ),
      );
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        isLoading: true,
        error: null,
        selectedGateway: gateway,
      ),
    );

    try {
      developer.log(
        'Processing payment with gateway: $gateway',
        name: 'PaymentNotifier',
      );

      final response = await _repository.processPayment(
        payment: payment,
        gateway: gateway,
        transactionId: currentState.currentTransactionId!,
        returnUrl: returnUrl,
        notifyUrl: notifyUrl,
      );

      state = AsyncValue.data(
        currentState.copyWith(
          isLoading: false,
          paymentResponse: response,
          selectedGateway: gateway,
        ),
      );

      developer.log(
        'Payment processed: ${response.data.paymentStatus}',
        name: 'PaymentNotifier',
      );

      // Automatically check status after processing
      await checkPaymentStatus();
    } catch (e) {
      developer.log(
        'Failed to process payment: $e',
        name: 'PaymentNotifier',
        level: 1000,
      );

      state = AsyncValue.data(
        currentState.copyWith(
          isLoading: false,
          error: _getErrorMessage(e),
          selectedGateway: gateway,
        ),
      );
    }
  }

  /// Check payment status
  Future<void> checkPaymentStatus() async {
    final currentState = state.hasValue
        ? state.requireValue
        : const PaymentState();

    if (currentState.currentTransactionId == null) {
      state = AsyncValue.data(
        currentState.copyWith(error: 'Aucune transaction à vérifier.'),
      );
      return;
    }

    try {
      developer.log(
        'Checking payment status: ${currentState.currentTransactionId}',
        name: 'PaymentNotifier',
      );

      final response = await _repository.checkPaymentStatus(
        transactionId: currentState.currentTransactionId!,
      );

      state = AsyncValue.data(currentState.copyWith(statusResponse: response));

      developer.log(
        'Payment status: ${response.data.transactionStatus}',
        name: 'PaymentNotifier',
      );
    } catch (e) {
      developer.log(
        'Failed to check payment status: $e',
        name: 'PaymentNotifier',
        level: 1000,
      );

      state = AsyncValue.data(
        currentState.copyWith(error: _getErrorMessage(e)),
      );
    }
  }

  /// Select payment gateway
  void selectGateway(String gateway) {
    final currentState = state.hasValue
        ? state.requireValue
        : const PaymentState();
    state = AsyncValue.data(currentState.copyWith(selectedGateway: gateway));
  }

  /// Get recommended gateway for phone number
  String? getRecommendedGateway(String phoneNumber) {
    return _repository.getRecommendedGateway(phoneNumber);
  }

  /// Validate phone number for gateway
  bool isValidPhoneForGateway(String phoneNumber, String gateway) {
    return _repository.isValidPhoneForGateway(phoneNumber, gateway);
  }

  /// Get available payment gateways
  List<PayUnitGateway> getAvailableGateways() {
    return _repository.getAvailableGateways();
  }

  /// Get status message
  String getStatusMessage(String status) {
    return _repository.getStatusMessage(status);
  }

  /// Clear error
  void clearError() {
    final currentState = state.hasValue
        ? state.requireValue
        : const PaymentState();
    state = AsyncValue.data(currentState.copyWith(error: null));
  }

  /// Reset payment state
  void reset() {
    state = const AsyncValue.data(PaymentState());
  }

  /// Extract user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error is PayUnitApiException) {
      return error.message;
    }
    return 'Une erreur est survenue. Veuillez réessayer.';
  }
}

/// Provider for payment repository
final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository();
});

/// Provider for payment notifier
final paymentProvider = AsyncNotifierProvider<PaymentNotifier, PaymentState>(
  () {
    return PaymentNotifier();
  },
);

/// Provider for recommended gateway based on phone number
final recommendedGatewayProvider = Provider.family<String?, String>((
  ref,
  phoneNumber,
) {
  final repository = ref.watch(paymentRepositoryProvider);
  return repository.getRecommendedGateway(phoneNumber);
});

/// Provider for available payment gateways
final availableGatewaysProvider = Provider<List<PayUnitGateway>>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return repository.getAvailableGateways();
});
