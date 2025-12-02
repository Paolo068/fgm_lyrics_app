import 'package:fgm_lyrics_app/app/data/payment_model.dart';
import 'package:fgm_lyrics_app/app/payment/payment_provider.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:fgm_lyrics_app/core/utils/payunit_config.dart';
import 'package:fgm_lyrics_app/core/widgets/app_default_spacing.dart';
import 'package:fgm_lyrics_app/core/widgets/app_headline_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayWallScreen extends ConsumerStatefulWidget {
  final VoidCallback onTap;
  const PayWallScreen({super.key, required this.onTap});

  @override
  ConsumerState<PayWallScreen> createState() => _PayWallScreenState();
}

class _PayWallScreenState extends ConsumerState<PayWallScreen> {
  bool isLoading = false;
  Future<void> _initializePayment() async {
    setState(() => isLoading = true);
    const payment = Payment(
      amount: PayUnitConfig.appPrice,
      currency: PayUnitConfig.currency,
    );

    await ref
        .read(paymentProvider.notifier)
        .initializePayment(
          payment: payment,
          returnUrl: PayUnitConfig.returnUrl,
          notifyUrl: PayUnitConfig.notifyUrl,
        );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppDefaultSpacing(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo_pay.png', height: 300),
              const AppHeadlineText(text: "Acheter l'application !"),
              const GutterTiny(),
              Text(
                "Il semble que vous n'ayez pas encore acheté l'application. Veuillez suivre les étapes pour bénéficier d'un accès à vie.",
                style: context.textTheme.labelLarge?.copyWith(
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const GutterLarge(),

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
              ElevatedButton.icon(
                // onPressed: paymentState.isLoading ? null : _handlePayment,
                // child: paymentState.isLoading
                //     ? const SizedBox(
                //         height: 20,
                //         width: 20,
                //         child: CircularProgressIndicator(strokeWidth: 2),
                //       )
                //     : Text(_getButtonText(paymentState)),
                onPressed: () async {
                  await _initializePayment();
                  widget.onTap();
                },
                label: isLoading
                    ? const Text('Chargement...')
                    : const Text('Continuer'),
                icon: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: context.theme.primaryColor,
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.white,
                          ),
                        ),
                      )
                    : null,
              ),
              const Gutter(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous aviez déjà acheté ?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Cliquez ici !',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Show payment methods if payment is initialized - Step 2
// if (paymentState.initializeResponse != null)