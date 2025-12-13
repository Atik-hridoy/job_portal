import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../services/dio_service.dart';

class AuthRepository {
  
  // Sign In Function
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final response = await DioService.post(
        ApiConfig.authSignin,
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data;
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? e.message ?? 'Login failed',
        'statusCode': e.response?.statusCode
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}'
      };
    }
  }

  // Sign Up Function
  Future<Map<String, dynamic>> signUp(String email, String password, String role, String phone) async {
    try {
      final response = await DioService.post(
        ApiConfig.authSignup,
        data: {
          'email': email,
          'password': password,
          'role': role,
          'phone': phone,
        },
      );

      return response.data;
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? e.message ?? 'Registration failed',
        'statusCode': e.response?.statusCode
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}'
      };
    }
  }

  // Verify OTP Function
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      final response = await DioService.post(
        ApiConfig.authVerifyOtp,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      return {
        'success': true,
        'data': response.data,
        'message': 'OTP verified successfully'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? e.message ?? 'OTP verification failed',
        'statusCode': e.response?.statusCode
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}'
      };
    }
  }

  // Resend OTP Function
  Future<Map<String, dynamic>> resendOtp(String email) async {
    try {
      final response = await DioService.post(
        ApiConfig.authResendOtp,
        data: {
          'email': email,
        },
      );

      return {
        'success': true,
        'data': response.data,
        'message': 'OTP sent successfully'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? e.message ?? 'Failed to resend OTP',
        'statusCode': e.response?.statusCode
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}'
      };
    }
  }

  // Get Profile Function
  Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final dio = Dio(BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ));

      final response = await dio.get(ApiConfig.authProfile);

      return {
        'success': true,
        'data': response.data,
        'message': 'Profile fetched successfully'
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['message'] ?? e.message ?? 'Failed to fetch profile',
        'statusCode': e.response?.statusCode
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}'
      };
    }
  }
}
