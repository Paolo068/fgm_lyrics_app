import 'package:fgm_lyrics_app/app/data/payment_model.dart';
import 'package:fgm_lyrics_app/app/payment/payment_provider.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:fgm_lyrics_app/core/utils/payunit_config.dart';
import 'package:fgm_lyrics_app/core/utils/phone_validation.dart';
import 'package:fgm_lyrics_app/core/widgets/app_default_spacing.dart';
import 'package:fgm_lyrics_app/core/widgets/form_builder_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _phoneController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.CM, nsn: ""),
  );
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final paymentAsyncState = ref.watch(paymentProvider);

    return SliverToBoxAdapter(
      child: paymentAsyncState.when(
        data: (paymentState) => _buildPaymentForm(context, paymentState),
        loading: () => const AppDefaultSpacing(
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => AppDefaultSpacing(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red.shade400),
                const SizedBox(height: 16),
                Text(
                  'Erreur de chargement',
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(paymentProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentForm(BuildContext context, PaymentState paymentState) {
    return AppDefaultSpacing(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset('assets/logo_pay.png'),
              Text(
                "Remplissez les champs ci-dessous pour payer.",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.color?.withValues(alpha: .8),
                ),
              ),
              Text(
                "Juste quelques informations pour vous permettre de payer et de recevoir votre accès à vie.",
                style: context.textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).textTheme.labelLarge!.color,
                ),
                textAlign: TextAlign.center,
              ),

              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(hintText: 'Nom & Prénom'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: FormBuilderValidators.minLength(
                  3,
                  errorText:
                      'Le nom ou prénom doit contenir au moins 3 caractères',
                ),
                autovalidateMode: AutovalidateMode.onUnfocus,
              ),

              FormBuilderPhoneField(
                name: 'phone',
                hintText: 'Numéro de téléphone',
                phoneController: _phoneController,
                isCountrySelectionEnabled: false,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: _validatePhone,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Numéro de téléphone',
                ),
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  hintText: 'Adresse mail (optionnel)',
                ),
                validator: _formKey.currentState?.value['email'] == null
                    ? null
                    : FormBuilderValidators.email(
                        errorText: 'Veuillez entrer une adresse mail valide',
                      ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const GutterSmall(),

              // Show payment methods if payment is initialized
              // if (paymentState.initializeResponse != null) ...[
              //   Text(
              //     'Choisissez votre mode de paiement :',
              //     style: context.textTheme.titleMedium?.copyWith(
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   const Gutter(),
              //   ...paymentState.availableProviders.map(
              //     (provider) => Card(
              //       margin: const EdgeInsets.only(bottom: 8),
              //       child: ListTile(
              //         leading: CircleAvatar(
              //           backgroundImage: NetworkImage(provider.logo),
              //           backgroundColor: Colors.transparent,
              //         ),
              //         title: Text(provider.name),
              //         subtitle: Text(provider.country.countryName),
              //         trailing:
              //             paymentState.selectedGateway == provider.shortcode
              //             ? const Icon(Icons.check_circle, color: Colors.green)
              //             : null,
              //         onTap: () => _selectPaymentMethod(provider.shortcode),
              //       ),
              //     ),
              //   ),
              //   const Gutter(),
              // ],

              // Show payment status if available
              // if (paymentState.statusResponse != null) ...[
              //   Card(
              //     color: _getStatusColor(
              //       paymentState.statusResponse!.data.transactionStatus,
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(16),
              //       child: Column(
              //         children: [
              //           Icon(
              //             _getStatusIcon(
              //               paymentState.statusResponse!.data.transactionStatus,
              //             ),
              //             size: 48,
              //             color: Colors.white,
              //           ),
              //           const SizedBox(height: 8),
              //           Text(
              //             ref
              //                 .read(paymentProvider.notifier)
              //                 .getStatusMessage(
              //                   paymentState
              //                       .statusResponse!
              //                       .data
              //                       .transactionStatus,
              //                 ),
              //             style: context.textTheme.titleMedium?.copyWith(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             textAlign: TextAlign.center,
              //           ),
              //           if (paymentState.isPaymentPending) ...[
              //             const SizedBox(height: 8),
              //             const CircularProgressIndicator(color: Colors.white),
              //           ],
              //         ],
              //       ),
              //     ),
              //   ),
              //   const Gutter(),
              // ],

              // Show error if any
              // if (paymentState.error != null) ...[
              //   Card(
              //     color: Colors.red.shade100,
              //     child: Padding(
              //       padding: const EdgeInsets.all(16),
              //       child: Row(
              //         children: [
              //           Icon(Icons.error, color: Colors.red.shade700),
              //           const SizedBox(width: 8),
              //           Expanded(
              //             child: Text(
              //               paymentState.error!,
              //               style: TextStyle(color: Colors.red.shade700),
              //             ),
              //           ),
              //           IconButton(
              //             onPressed: () =>
              //                 ref.read(paymentProvider.notifier).clearError(),
              //             icon: const Icon(Icons.close),
              //             color: Colors.red.shade700,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   const Gutter(),
              // ],
              ElevatedButton(
                onPressed:
                    (paymentState.isLoading ||
                        _formKey.currentState?.saveAndValidate() != true)
                    ? null
                    : _processPayment,
                child: paymentState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Payer maintenant ${PayUnitConfig.appPrice} XAF',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePhone(PhoneNumber? value) {
    if (value == null || value.nsn.isEmpty) {
      return 'Le numéro de téléphone est requis';
    }

    // Validate that it's a valid Cameroon phone number
    if (value.isoCode != IsoCode.CM) {
      return 'Veuillez sélectionner un numéro Camerounais';
    }

    // Check if the phone number is valid for Cameroon
    if (!value.isValid()) {
      return 'Numéro de téléphone invalide';
    }
    if (!isMTN(value.nsn) || !isOrange(value.nsn)) {
      return 'Uniquement les numéros MTN ou Orange pour le moment';
    }

    return null;
  }

  void _processPayment() {
    final formState = _formKey.currentState;
    if (formState == null) return;

    final formData = formState.value;
    final phoneNumber = _phoneController.value;
    final paymentState = ref.read(paymentProvider).hasValue
        ? ref.read(paymentProvider).requireValue
        : const PaymentState();

    final selectedGateway = paymentState.selectedGateway;
    if (selectedGateway == null) {
      // Initialize payment first if no gateway is selected
      final payment = Payment(
        name: formData['name'] as String,
        email: formData['email'] as String? ?? '',
        phone: phoneNumber.international,
        amount: PayUnitConfig.appPrice,
        currency: PayUnitConfig.currency,
      );

      ref
          .read(paymentProvider.notifier)
          .initializePayment(
            payment: payment,
            returnUrl: PayUnitConfig.returnUrl,
            notifyUrl: PayUnitConfig.notifyUrl,
          );
      return;
    }

    final payment = Payment(
      name: formData['name'] ?? '',
      email: formData['email'] as String? ?? '',
      phone: phoneNumber.international,
      amount: PayUnitConfig.appPrice,
      currency: PayUnitConfig.currency,
    );

    ref
        .read(paymentProvider.notifier)
        .processPayment(
          payment: payment,
          gateway: selectedGateway,
          returnUrl: PayUnitConfig.returnUrl,
          notifyUrl: PayUnitConfig.notifyUrl,
        );
  }

  /// Get button text based on payment state
  // String _getButtonText(PaymentState state) {
  //   if (state.initializeResponse == null) {
  //     return 'Continuer';
  //   } else if (state.selectedGateway == null) {
  //     return 'Sélectionner un mode de paiement';
  //   } else if (state.isPaymentSuccessful) {
  //     return 'Paiement réussi !';
  //   } else if (state.isPaymentPending) {
  //     return 'Vérifier le statut';
  //   } else {
  //     return 'Payer maintenant';
  //   }
  // }

  // /// Get status color based on payment status
  // Color _getStatusColor(String status) {
  //   switch (status.toUpperCase()) {
  //     case 'SUCCESS':
  //       return Colors.green;
  //     case 'PENDING':
  //       return Colors.orange;
  //     case 'FAILED':
  //     case 'CANCELLED':
  //       return Colors.red;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  // /// Get status icon based on payment status
  // IconData _getStatusIcon(String status) {
  //   switch (status.toUpperCase()) {
  //     case 'SUCCESS':
  //       return Icons.check_circle;
  //     case 'PENDING':
  //       return Icons.access_time;
  //     case 'FAILED':
  //     case 'CANCELLED':
  //       return Icons.error;
  //     default:
  //       return Icons.info;
  //   }
  // }
}
