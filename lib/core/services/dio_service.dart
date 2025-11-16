// import 'dart:io';
// import 'package:dio/dio.dart';
// import '../utils/constants.dart';
// import 'storage_service.dart';
// import 'app_logger.dart';

// class DioService {
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: AppConstants.apiBaseUrl,
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {'Accept': 'application/json'},
//     ),
//   );

//   static void init() {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           final token = StorageService.getToken();
//           if (token != null) options.headers['Authorization'] = 'Bearer $token';

//           // ✅ Auto-log request
//           AppLogger.request(options.method, options.uri.toString(),
//               headers: options.headers, body: options.data);

//           handler.next(options);
//         },
//         onResponse: (response, handler) {
//           // ✅ Auto-log response
//           AppLogger.response(response.statusCode ?? 0,
//               response.requestOptions.uri.toString(), response.data);

//           handler.next(response);
//         },
//         onError: (e, handler) {
//           // ✅ Auto-log errors
//           AppLogger.error(
//               e.requestOptions.uri.toString(), e.message,
//               stackTrace: e.stackTrace);
//           handler.next(e);
//         },
//       ),
//     );
//   }

//   static Future<Response> get(String endpoint, {Map<String, dynamic>? params}) =>
//       _dio.get(endpoint, queryParameters: params);

//   static Future<Response> post(String endpoint, {dynamic data, bool isFormData = false}) {
//     final payload = isFormData ? FormData.fromMap(data) : data;
//     return _dio.post(endpoint, data: payload);
//   }

//   static Future<Response> patch(String endpoint, {dynamic data, bool isFormData = false}) {
//     final payload = isFormData ? FormData.fromMap(data) : data;
//     return _dio.patch(endpoint, data: payload);
//   }

//   static Future<Response> uploadImages(String endpoint, Map<String, dynamic> data,
//       {List<File>? images, String imageField = 'image', bool useMediaBaseUrl = false}) async {
//     final base = useMediaBaseUrl ? Constants.mediaBaseUrl : Constants.apiBaseUrl;
//     final dio = Dio(BaseOptions(baseUrl: base));

//     final formData = FormData.fromMap(data);
//     if (images != null && images.isNotEmpty) {
//       for (int i = 0; i < images.length; i++) {
//         formData.files.add(MapEntry(
//           images.length > 1 ? '$imageField[$i]' : imageField,
//           await MultipartFile.fromFile(images[i].path, filename: images[i].path.split('/').last),
//         ));
//       }
//     }

//     // ✅ Auto-log upload request
//     AppLogger.request('POST', '$base$endpoint', body: data, headers: {'Content-Type': 'multipart/form-data'});

//     final res = await dio.post(endpoint, data: formData);

//     // ✅ Auto-log upload response
//     AppLogger.response(res.statusCode ?? 0, '$base$endpoint', res.data);
//     return res;
//   }
// }