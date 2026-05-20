// import 'dart:convert';
// import 'dart:developer';
// import 'package:digitalads/routes/screen_routes_endpoint.dart';
// import 'package:digitalads/services/api_end_point.dart';
// import 'package:digitalads/views/screens/widgets/dialogs.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:shared_preferences/shared_preferences.dart';

// import '../../routes/navigation_service.dart';

// class APICall {
//   static String userTokeKey = "digital_ads_user";

//   ///server Url
//   static bool isLoading = false;
//   static Future<dynamic> getRequest({
//     required String endPoint,
//     needToShowLoading = true,
//   }) async {
//     BuildContext context =
//         NavigationService.instance.navigationKey.currentContext!;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final userToken = prefs.getString(userTokeKey);

//     var apiUrl = Uri.parse("${APIEndPoint.serverURL}$endPoint");
//     print("User token... $userToken");
//     print(apiUrl);
//     try {
//       if (isLoading == false && needToShowLoading) {
//         isLoading = true;
//         Dialogs.showLoader();
//       }

//       final apiResponse = await http.get(
//         apiUrl,
//         headers: {
//           'Content-type': 'application/json',
//           if (userToken != null) 'Authorization': "Bearer $userToken",
//         },
//       );
//       log("res ${apiResponse.body}");
//       if (apiResponse.statusCode == 200) {
//         if (isLoading && needToShowLoading) {
//           isLoading = false;
//           Navigator.pop(context);
//         }
//         log(apiResponse.body);
//         final finalResponse = json.decode(apiResponse.body);
//         return finalResponse;
//       } else {
//         if (isLoading && needToShowLoading) {
//           isLoading = false;
//           Navigator.pop(context);
//         }
//         if (apiResponse.statusCode == 400) {
//           final finalResponse = json.decode(apiResponse.body);
//           return finalResponse;
//         } else if (apiResponse.statusCode == 401) {
//           // NavigationService.instance.pushAndRemove(Routes.splashScreen);
//           return;
//         } else {
//           return {"status": 400, "message": "Something went wrong"};
//         }
//       }
//     } catch (error) {
//       if (isLoading && needToShowLoading) {
//         isLoading = false;
//         Navigator.pop(context);
//       }
//       rethrow;
//     }
//   }

//   static Future<dynamic> postRequest({
//     required String endPoint,
//     required dynamic requestData,
//     bool needToShowLoading = true,
//   }) async {
//     BuildContext context =
//         NavigationService.instance.navigationKey.currentContext!;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final userToken = prefs.getString(userTokeKey);
//     print("User token... $userToken");
//     var apiUrl = Uri.parse("${APIEndPoint.serverURL}$endPoint");
//     print("$apiUrl $requestData");
//     try {
//       if (isLoading == false && needToShowLoading) {
//         isLoading = true;
//         Dialogs.showLoader();
//       }
//       final apiResponse = await http.post(
//         apiUrl,
//         headers: {
//           'Content-type': 'application/json',
//           if (userToken != null) 'Authorization': "Bearer $userToken",
//         },
//         body: json.encode(requestData),
//       );
//       log("res123 ${apiResponse.body}");
//       if (apiResponse.statusCode == 200) {
//         if (isLoading && needToShowLoading) {
//           isLoading = false;
//           Navigator.pop(context);
//         }
//         final finalResponse = json.decode(apiResponse.body);
//         return finalResponse;
//       } else {
//         if (isLoading && needToShowLoading) {
//           isLoading = false;
//           Navigator.pop(context);
//         }
//         if (apiResponse.statusCode == 400) {
//           final finalResponse = json.decode(apiResponse.body);
//           return finalResponse;
//         } else if (apiResponse.statusCode == 401) {
//           final SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.remove(userTokeKey);
//           // NavigationService.instance.pushAndRemove(Routes.splashScreen);
//           return;
//         } else {
//           return {"status": 400, "message": "Something went wrong"};
//         }
//       }
//     } catch (error) {
//       print("Error catch");
//       if (isLoading && needToShowLoading) {
//         isLoading = false;
//         Navigator.pop(context);
//       }
//       rethrow;
//     }
//   }
// }
