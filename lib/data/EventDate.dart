// import 'dart:convert';

// import 'package:hk_acg_event_information/data/apiClient.dart';
// import 'package:hk_acg_event_information/model/EventModel.dart';
// import 'package:http/http.dart' as http;

// class ProvideData {
//   static Future<List<Event>> getEventList() async {
//     // var url = Uri.http(Apiclient.api, 'events'); // 確保路徑正確
//     // print(url);

//     try {
//       var url = Uri.http(Apiclient.api, 'events'); // 確保路徑正確

//       var response = await http.get(url);

//       if (response.statusCode == 200) {
//         if (response.statusCode == 200) {
//           List<dynamic> jsonList = jsonDecode(response.body);

//           List<Event> returnList = [];
//           for (int i = 0; i < jsonList.length; i++) {
//             final EvenCategory evenCategory = EvenCategory.values.firstWhere(
//               (cat) => cat.name == jsonList[i]['evenCategory'],
//               orElse: () => EvenCategory.acg,
//             );

//             List<String> imageList = [];
//             for (int j = 0; j < jsonList[i]['eventImages'].length; j++) {
//               imageList.add(jsonList[i]['eventImages'][j]['imageUrl']);
//             }
//             print(jsonList[i]['officialURL'] ?? '');
//             final Event getEvent = Event(
//               id: jsonList[i]['eventId'] ?? -1,
//               image: imageList, // jsonList[i]['eventImages'] ?? '',
//               title: jsonList[i]['title'] ?? 'N/A',
//               eventTimes: [DateTime.now()],
//               ticket: (jsonList[i]['ticket'] as int).toDouble(),
//               amount: ['amount'],
//               evenCategory: evenCategory,
//               organizer: jsonList[i]['organizer'] ?? 'N/A',
//               officialURL: jsonList[i]['officialURL'] ?? 'N/A',
//               location: jsonList[i]['location'] ?? 'N/A',
//               eventDetail: jsonList[i]['eventDetail'] ?? '沒有資訊',
//             );

//             returnList.add(getEvent);
//           }
//           // return [];
//           return returnList;
//         } else {
//           throw Exception('API 錯誤，狀態碼：${response.statusCode}');
//         }
//       }
//     } catch (e) {
//       throw Exception('獲取活動列表時發生錯誤: $e');
//     }

//     // print('Response status: ${response.statusCode}');
//     // print('Response body: ${response.body}');
//     return [];
//   }
// }
