// // auth_service.dart

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AuthService {
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();

//   String? accessToken;
//   String? refreshToken;

//   Future<void> logInAndGetTokens(String email, String password,
//       {bool isRefresh = false}) async {
//     if (!isRefresh) {
//       // If not refreshing, check if the user has an access token
//       await _getTokens();
//       if (accessToken != null) {
//         return;
//       }
//     }

//     final apiUrl = Uri.parse(
//         'https://ethenatx.pythonanywhere.com/management/obtain-token/');

//     try {
//       final response = await http.post(
//         apiUrl,
//         headers: {'Content-Type': 'application/json; charset=UTF-8'},
//         body: jsonEncode(
//           isRefresh
//               ? {'refresh': refreshToken}
//               : {'email': email, 'password': password},
//         ),
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
//         accessToken = jsonResponse['access'];
//         if (!isRefresh) {
//           refreshToken = jsonResponse['refresh'];
//         }
//         await _storeTokens();
//       } else if (response.statusCode == 401) {
//         // Token expired, try refreshing
//         if (await _refreshAccessToken()) {
//           // Retry login after refresh
//           await logInAndGetTokens(email, password);
//         }
//       } else {
//         accessToken = null;
//         refreshToken = null;
//       }
//     } catch (e) {
//       accessToken = null;
//       refreshToken = null;
//     }
//   }

//   Future<bool> _refreshAccessToken() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             'https://ethenatx.pythonanywhere.com/management/obtain-token/'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({'refresh': refreshToken}),
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
//         accessToken = jsonResponse['access'];
//         await _storeTokens();
//         return true;
//       } else {
//         accessToken = null;
//         refreshToken = null;
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<void> _storeTokens() async {
//     await secureStorage.write(key: 'access_token', value: accessToken!);
//     await secureStorage.write(key: 'refresh_token', value: refreshToken!);
//   }

//   Future<void> _getTokens() async {
//     accessToken = await secureStorage.read(key: 'access_token');
//     refreshToken = await secureStorage.read(key: 'refresh_token');
//   }
// }

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String? accessToken;
  String? refreshToken;

  Future<void> logInAndGetTokens(String email, String password,
      {bool isRefresh = false}) async {
    // Check if it's the first-time user
    if (!isRefresh) {
      // If it's the first time, check if there's a stored token
      accessToken = await secureStorage.read(key: 'access_token');
      refreshToken = await secureStorage.read(key: 'refresh_token');
    }

    final apiUrl = Uri.parse(
        'https://ethenatx.pythonanywhere.com/management/obtain-token/');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
          isRefresh
              ? {'refresh': refreshToken}
              : {'email': email, 'password': password},
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        accessToken = jsonResponse['access'];
        if (!isRefresh) {
          refreshToken = jsonResponse['refresh'];
        }
        await _storeTokens();
      } else if (response.statusCode == 401) {
        // Token expired, try refreshing
        if (await _refreshAccessToken()) {
          // Retry login after refresh
          await logInAndGetTokens(email, password);
        }
      } else {
        accessToken = null;
        refreshToken = null;
      }
    } catch (e) {
      accessToken = null;
      refreshToken = null;
    }
  }

  Future<bool> _refreshAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://ethenatx.pythonanywhere.com/management/obtain-token/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'refresh': refreshToken}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        accessToken = jsonResponse['access'];
        await _storeTokens();
        return true;
      } else {
        accessToken = null;
        refreshToken = null;
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _storeTokens() async {
    await secureStorage.write(key: 'access_token', value: accessToken!);
    await secureStorage.write(key: 'refresh_token', value: refreshToken!);
  }
}
