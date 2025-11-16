// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import '../utils/constants.dart';
// import 'storage_service.dart';
// import 'app_logger.dart';

// class HttpService {
//   static Map<String, String> _getHeaders({Map<String, String>? extraHeaders}) {
//     final token = StorageService.getToken();
//     final headers = {'Accept': 'application/json'};
//     if (token != null) headers['Authorization'] = 'Bearer $token';
//     if (extraHeaders != null) headers.addAll(extraHeaders);
//     return headers;
//   }

//   static Future<http.Response> get(String endpoint, {Map<String, String>? params}) async {
//     final uri = Uri.parse('${AppConstants.apiBaseUrl}$endpoint').replace(queryParameters: params);

//     // ✅ Auto-log GET request
//     AppLogger.request('GET', uri.toString(), headers: _getHeaders());

//     final res = await http.get(uri, headers: _getHeaders());

//     // ✅ Auto-log GET response
//     AppLogger.response(res.statusCode, uri.toString(), jsonDecode(res.body));
//     return res;
//   }

//   static Future<http.Response> post(String endpoint, {Map<String, dynamic>? data}) async {
//     final uri = Uri.parse('${AppConstants.apiBaseUrl}$endpoint');

//     // ✅ Auto-log POST request
//     AppLogger.request('POST', uri.toString(), headers: _getHeaders(), body: data);

//     final res = await http.post(uri,
//         headers: _getHeaders({'Content-Type': 'application/json'}),
//         body: jsonEncode(data ?? {}));

//     // ✅ Auto-log POST response
//     AppLogger.response(res.statusCode, uri.toString(), jsonDecode(res.body));
//     return res;
//   }

//   static Future<http.Response> patch(String endpoint, {Map<String, dynamic>? data}) async {
//     final uri = Uri.parse('${Constants.apiBaseUrl}$endpoint');

//     // ✅ Auto-log PATCH request
//     AppLogger.request('PATCH', uri.toString(), headers: _getHeaders(), body: data);

//     final res = await http.patch(uri,
//         headers: _getHeaders({'Content-Type': 'application/json'}),
//         body: jsonEncode(data ?? {}));

//     // ✅ Auto-log PATCH response
//     AppLogger.response(res.statusCode, uri.toString(), jsonDecode(res.body));
//     return res;
//   }
// }