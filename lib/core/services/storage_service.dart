// import 'package:get_storage/get_storage.dart';
// import '../utils/storage_keys.dart';

// class StorageService {
//   static final GetStorage _box = GetStorage();

//   // Initialize storage
//   static Future<void> init() async {
//     await GetStorage.init();
//   }

//   // Save any data
//   static Future<void> saveData(String key, dynamic value) async {
//     await _box.write(key, value);
//   }

//   // Read data
//   static dynamic readData(String key) {
//     return _box.read(key);
//   }

//   // Remove data
//   static Future<void> removeData(String key) async {
//     await _box.remove(key);
//   }

//   // Clear all data
//   static Future<void> clearAll() async {
//     await _box.erase();
//   }

//   // Token management
//   static Future<void> saveToken(String token) async {
//     await saveData(StorageKeys.token, token);
//   }

//   static String? getToken() {
//     return readData(StorageKeys.token);
//   }

//   static Future<void> saveRefreshToken(String refreshToken) async {
//     await saveData(StorageKeys.refreshToken, refreshToken);
//   }

//   static String? getRefreshToken() {
//     return readData(StorageKeys.refreshToken);
//   }

//   static Future<void> clearTokens() async {
//     await _box.remove(StorageKeys.token);
//     await _box.remove(StorageKeys.refreshToken);
//   }
// }
