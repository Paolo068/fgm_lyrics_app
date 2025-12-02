# PayUnit Payment Integration Guide

This guide explains how to integrate PayUnit payments in your Flutter app for processing payments in Cameroon.

## Overview

The PayUnit integration includes:
- Complete API service for all PayUnit endpoints
- Phone number validation for Cameroon mobile money providers
- Riverpod state management for payment flow
- Form validation with visual feedback
- Support for Orange Money, MTN Mobile Money, and Express Union

## Setup Instructions

### 1. Get PayUnit Credentials

1. Visit [PayUnit.net](https://payunit.net/)
2. Create an account or log in
3. Go to your dashboard
4. Navigate to the API section
5. Generate your API credentials:
   - API Key
   - API User
   - API Password

### 2. Configure Credentials

Update the credentials in `lib/core/utils/payunit_config.dart`:

```dart
class PayUnitConfig {
  // Sandbox Configuration
  static const String sandboxApiKey = 'your_actual_sandbox_api_key';
  static const String sandboxApiUser = 'your_actual_sandbox_api_user';
  static const String sandboxApiPassword = 'your_actual_sandbox_api_password';
  
  // Set to false for sandbox testing
  static const bool isProduction = false;
  
  // Update your callback URLs
  static const String returnUrl = 'https://yourapp.com/payment/return';
  static const String notifyUrl = 'https://yourapp.com/payment/notify';
}
```

### 3. Dependencies

The following dependencies have been added to `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.2.2
  json_annotation: ^4.9.0
  
dev_dependencies:
  json_serializable: ^6.8.0
  build_runner: ^2.4.13
```

## Payment Flow

### 1. Initialize Payment

```dart
// Create payment object
final payment = Payment(
  name: 'John Doe',
  email: 'john@example.com',
  phone: '+237691234567',
  amount: '5000',
  currency: 'XAF',
  status: 'pending',
);

// Initialize payment
await ref.read(paymentProvider.notifier).initializePayment(
  payment: payment,
  returnUrl: PayUnitConfig.returnUrl,
  notifyUrl: PayUnitConfig.notifyUrl,
);
```

### 2. Select Payment Method

After initialization, available payment providers are displayed:
- Orange Money (CM_ORANGE)
- MTN Mobile Money (CM_MTN)
- Express Union (CM_EXPRESS_UNION)

### 3. Process Payment

```dart
// Process payment with selected gateway
await ref.read(paymentProvider.notifier).processPayment(
  payment: payment,
  gateway: 'CM_ORANGE', // or CM_MTN, CM_EXPRESS_UNION
  returnUrl: PayUnitConfig.returnUrl,
  notifyUrl: PayUnitConfig.notifyUrl,
);
```

### 4. Check Payment Status

```dart
// Check payment status
await ref.read(paymentProvider.notifier).checkPaymentStatus();
```

## API Endpoints

### 1. Initialize Payment
- **Endpoint**: `POST /api/gateway/initialize`
- **Purpose**: Create a new transaction and get available payment providers

### 2. Make Payment
- **Endpoint**: `POST /api/gateway/makepayment`
- **Purpose**: Process payment with selected gateway

### 3. Payment Status
- **Endpoint**: `GET /api/gateway/paymentstatus/{transactionId}`
- **Purpose**: Check the current status of a payment

## Phone Number Validation

The system automatically validates phone numbers for each payment gateway:

### Orange Money (CM_ORANGE)
- Accepts numbers starting with: 69, 65, 66, 67
- Format: 9 digits (without country code)

### MTN Mobile Money (CM_MTN)
- Accepts numbers starting with: 67, 68, 65, 66
- Format: 9 digits (without country code)

### Express Union (CM_EXPRESS_UNION)
- Accepts most Cameroon numbers starting with 6
- Format: 9 digits (without country code)

## Payment States

The payment system manages the following states:

- **PENDING**: Payment is being processed
- **SUCCESS**: Payment completed successfully
- **FAILED**: Payment failed
- **CANCELLED**: Payment was cancelled by user

## Error Handling

The system handles various error scenarios:

1. **Network Errors**: Connection issues, timeouts
2. **API Errors**: Invalid credentials, malformed requests
3. **Validation Errors**: Invalid phone numbers, missing fields
4. **Payment Errors**: Insufficient funds, gateway issues

## Testing in Sandbox Mode

1. Set `isProduction = false` in `PayUnitConfig`
2. Use sandbox credentials from PayUnit
3. Test with valid Cameroon phone numbers
4. Monitor logs for API responses

## Security Considerations

1. **Never commit real credentials** to version control
2. Use environment variables for production credentials
3. Implement proper SSL/TLS for callback URLs
4. Validate all webhook notifications
5. Store sensitive data securely

## Troubleshooting

### Common Issues

1. **Invalid Credentials**
   - Verify API key, user, and password
   - Check if credentials are for correct environment (sandbox/production)

2. **Phone Number Validation Fails**
   - Ensure phone number is in correct format (9 digits)
   - Check if number is compatible with selected gateway

3. **Payment Initialization Fails**
   - Verify callback URLs are accessible
   - Check network connectivity
   - Review API logs for error details

4. **Payment Status Not Updating**
   - Implement webhook handling for real-time updates
   - Use polling for status checks if needed

### Debug Logs

The system provides comprehensive logging:

```dart
// Enable debug logging
import 'dart:developer' as developer;

developer.log('Payment initialized', name: 'PaymentFlow');
```

## Production Deployment

Before going live:

1. Update `isProduction = true` in `PayUnitConfig`
2. Replace sandbox credentials with production credentials
3. Ensure callback URLs use HTTPS
4. Test thoroughly with small amounts
5. Implement proper error monitoring
6. Set up webhook handling for payment notifications

## Support

For PayUnit-specific issues:
- Visit [PayUnit Documentation](https://developer.payunit.net/)
- Contact PayUnit support

For integration issues:
- Check the implementation in `lib/app/data/payunit_api_service.dart`
- Review payment flow in `lib/app/payment/payment_provider.dart`
- Test with the payment screen in `lib/app/payment/payment_screen.dart`
