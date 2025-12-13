class ApiConfig {
  // Environment-based base URLs
  static const String _developmentBaseUrl = 'http://192.168.1.103:8080';
  static const String _stagingBaseUrl = 'https://staging-api.yourapp.com';
  static const String _productionBaseUrl = 'https://api.yourapp.com';
  
  // API version prefix
  static const String apiVersion = '/api/v1';
  
  // Current environment (change this based on your build configuration)
  static const Environment _currentEnvironment = Environment.development;
  
  // Get current base URL
  static String get baseUrl {
    switch (_currentEnvironment) {
      case Environment.development:
        return _developmentBaseUrl;
      case Environment.staging:
        return _stagingBaseUrl;
      case Environment.production:
        return _productionBaseUrl;
    }
  }
  
  // ============= AUTH ENDPOINTS =============
  static const String authSignup = '$apiVersion/auth/signup';
  static const String authVerifyOtp = '$apiVersion/auth/verify-otp';
  static const String authResendOtp = '$apiVersion/auth/resend-otp';
  static const String authSignin = '$apiVersion/auth/signin';
  static const String authProfile = '$apiVersion/profile';
  
  // ============= ROLE-BASED ENDPOINTS =============
  static const String employerOnly = '$apiVersion/employer-only';
  static const String jobSeekerOnly = '$apiVersion/job-seeker-only';
  static const String adminOnly = '$apiVersion/admin-only';
  
  // ============= USER ENDPOINTS =============
  static const String users = '/users';
  static const String userDetail = '/users/{id}';
  static const String userUpdate = '/users/{id}';
  static const String userDelete = '/users/{id}';
  
  // ============= JOB ENDPOINTS =============
  static const String jobs = '/jobs';
  static const String jobDetail = '/jobs/{id}';
  static const String jobCreate = '/jobs';
  static const String jobUpdate = '/jobs/{id}';
  static const String jobDelete = '/jobs/{id}';
  static const String jobMy = '/jobs/my';
  static const String jobApply = '/jobs/{id}/apply';
  static const String jobSaved = '/jobs/saved';
  
  // ============= COMPANY ENDPOINTS =============
  static const String companies = '/companies';
  static const String companyDetail = '/companies/{id}';
  static const String companyCreate = '/companies';
  static const String companyUpdate = '/companies/{id}';
  static const String companyDelete = '/companies/{id}';
  
  // ============= COMMON ENDPOINTS =============
  static const String upload = '/upload';
  static const String notifications = '/notifications';
  static const String search = '/search';
  
  // ============= CONFIGURATION =============
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // ============= HELPER METHODS =============
  static String buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
  
  static String replacePathParams(String endpoint, Map<String, String> params) {
    String result = endpoint;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
  
  static String getEndpointWithParams(String endpointTemplate, Map<String, String> params) {
    return replacePathParams(endpointTemplate, params);
  }
}

enum Environment {
  development,
  staging,
  production,
}

// Extension for helper methods
extension ApiConfigExtension on ApiConfig {
  // Build full URL for endpoints
  static String buildUrl(String endpoint) {
    return '${ApiConfig.baseUrl}$endpoint';
  }
  
  // Replace path parameters in endpoints
  static String replacePathParams(String endpoint, Map<String, String> params) {
    String result = endpoint;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
  
  // Get endpoint with path parameters
  static String getEndpointWithParams(String endpointTemplate, Map<String, String> params) {
    return replacePathParams(endpointTemplate, params);
  }
}
