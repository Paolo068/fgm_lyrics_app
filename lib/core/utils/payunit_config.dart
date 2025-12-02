/// PayUnit API Configuration
///
/// Replace these values with your actual PayUnit credentials
class PayUnitConfig {
  // Sandbox Configuration
  static const String sandboxApiKey = 'sand_LoLzSQ7xkYsHJJhhlL4QbgeB5KxpAw';
  static const String sandboxApiUser = 'b387d5e1-4033-4701-a7fe-f60b688f53e5';
  static const String sandboxApiPassword =
      'e707d421-b8ed-4e7a-b4bd-3cb65968e186';

  // Production Configuration (use only when ready for production)
  static const String productionApiKey = 'your_production_api_key_here';
  static const String productionApiUser = 'your_production_api_user_here';
  static const String productionApiPassword =
      'your_production_api_password_here';

  // Environment Configuration
  static const bool isProduction = false; // Set to true for production

  // Current Configuration (based on environment)
  static String get apiKey => isProduction ? productionApiKey : sandboxApiKey;
  static String get apiUser =>
      isProduction ? productionApiUser : sandboxApiUser;
  static String get apiPassword =>
      isProduction ? productionApiPassword : sandboxApiPassword;
  static String get mode => isProduction ? 'live' : 'test';

  // API URLs
  static const String baseUrl = 'https://gateway.payunit.net/api/gateway';

  // App Configuration
  static const String appPrice = '3000'; // 5000 XAF
  static const String currency = 'XAF';
  static const String paymentCountry = 'CM'; // Cameroon

  // Callback URLs - Replace with your actual URLs
  static const String returnUrl = 'https://yourapp.com/payment/return';
  static const String notifyUrl = 'https://yourapp.com/payment/notify';

  /// Instructions for getting PayUnit credentials:
  ///
  /// 1. Visit https://payunit.net/
  /// 2. Create an account or log in
  /// 3. Go to your dashboard
  /// 4. Navigate to API section
  /// 5. Generate your API credentials:
  ///    - API Key
  ///    - API User
  ///    - API Password
  /// 6. Replace the placeholder values above with your actual credentials
  ///
  /// For sandbox testing:
  /// - Use the sandbox credentials provided by PayUnit
  /// - Set isProduction = false
  ///
  /// For production:
  /// - Use your live credentials
  /// - Set isProduction = true
  /// - Ensure your callback URLs are HTTPS and accessible
}
