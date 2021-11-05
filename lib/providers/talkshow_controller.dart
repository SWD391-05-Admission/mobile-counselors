import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mobile_customer/models/counselor.dart';
import 'package:mobile_customer/models/major.dart';
import 'package:mobile_customer/models/university.dart';
import '../models/talkshow.dart';
import '../values/app_value.dart';
import 'package:http/http.dart' as http;

class TalkshowController extends ChangeNotifier {
  List<Talkshow> _list;
  int _numberPage = 0;

  int get getNumberPage {
    int result = _numberPage;
    return result;
  }

  List<Talkshow> get list => _list;

  Future<Map<String, List<Talkshow>>> getListTalkshow(
    String email,
    String fullName,
    String phone,
    int page,
    int limit,
  ) async {
    try {
      // log('PAGEGGGGGG NÈ  -=================: $page');
      // log('PAGEGGGGGG NÈ-=================: $limit');
      Map<String, List<Talkshow>> map;
      List<Talkshow> list = [];
      String token = await AppValue.getToken();
      log('TOKEN IN LOCAL : $token');

      Uri uri = Uri.parse(
        'https://40.81.193.10/api/talkshowManagement/getTalkshows?Page=1&Limit=10',
      );
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        uri,
        headers: headers,
      );
      log('status code get talkshow create : ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log(data.toString());
      // log('NUMBER PAGE : ${data['numPage']}');
      if (response.statusCode < 400) {
        list = (data['talkshows'] as List).map((newData) {
          // log('newData talkshow : ${newData.toString()}');
          Counselor counselor = Counselor(
            ID: newData['counselor']['id'],
            email: newData['counselor']['email'],
            fullName: newData['counselor']['fullName'],
            image: newData['counselor']['avatar'],
            phone: newData['counselor']['phone'],
            description: newData['counselor']['description'],
            address: 'Lê Văn Toản, HCM',
            birthday: '03-07-1985',
            gender: 'Nam',
          );
          // log('1111111111111111');
          Major major = Major(
            id: newData['major']['id'],
            name: newData['major']['name'],
            description: newData['major']['description'],
          );
          University university = University(
            ID: newData['university']['id'],
            code: newData['university']['code'],
            name: newData['university']['name'],
            email: newData['university']['email'],
            facebook: newData['university']['facebook'],
            website: newData['university']['website'],
            description: newData['university']['description'],
            lastYearBenchMark: newData['university']['lastYearBenchmark'],
            minFee: newData['university']['minFee'],
            maxFee: newData['university']['maxFee'],
          );
          // log('dddddddddddddddddddddddddđ ${newData['createdDate']}');
          // log('HINHHHHHHH ${newData['image'][1]['src']}');
          String dateTmp = newData['createdDate'].toString().substring(0, 10);
          // log('dddddddddddddddddddddddddđ $dateTmp');
          String tmpTime = newData['startDate'].toString().substring(11, 16);
          log('TALKSHOW ID IN CONTROLLER ${newData['ID']}');
          Talkshow talkshow = Talkshow(
            ID: newData['id'],
            // ID: 1,
            counselor: counselor,
            date: dateTmp ?? '',
            description: newData['description'] ?? '',
            image: newData['image'] ?? '',
            // image: 'zdfv',
            price: newData['price'] ?? 0,
            timeFinish: newData['timeFinish'] ?? '',
            timeStart: tmpTime ?? '',
            major: major,
            university: university,
            isCancle: newData['isCancel'],
            isFinish: newData['isFinish'],
          );
          log('TALKSHOW IS CANCLE    ${talkshow.isCancle} TALKSHOW IS FINISH    ${talkshow.isFinish}');
          return talkshow;
        }).toList();
        map = {'${data['numPage']}': list};
      } else {
        map = {'': []};
      }
      _numberPage = data['numPage'];
      _list = list;

      notifyListeners();
      return map;
    } catch (error) {
      log('SOMETHING WRONG in get lisst talkshow! ${error.toString()}');
      // throw (error);
      return null;
    }
  }

  Future<Map<String, List<Talkshow>>> getListTalkshowHistory(
    String email,
    String fullName,
    String phone,
    int page,
    int limit,
  ) async {
    try {
      log('PAGEGGGGGG NÈ  -=================: $page');
      log('PAGEGGGGGG NÈ-=================: $limit');
      Map<String, List<Talkshow>> map;
      List<Talkshow> list = [];
      String token = await AppValue.getToken();
      log('TOKEN IN LOCAL : $token');

      Uri uri = Uri.parse(
        'https://40.81.193.10/api/talkshow/getTalkshowsHistory?Page=1&Limit=2',
      );
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        uri,
        headers: headers,
      );
      log('status code get talkshow : ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log(data.toString());
      log('NUMBER PAGE : ${data['numPage']}');
      list = (data['talkshows'] as List).map((newData) {
        log('newData talkshow : ${newData.toString()}');
        Counselor counselor = Counselor(
          ID: newData['counselor']['id'],
          email: newData['counselor']['email'],
          fullName: newData['counselor']['fullName'],
          image: newData['counselor']['avatar'],
          phone: newData['counselor']['phone'],
          description: newData['counselor']['description'],
          address: 'Lê Văn Toản, HCM',
          birthday: '03-07-1985',
          gender: 'Nam',
        );
        log('1111111111111111');
        Major major = Major(
          id: newData['major']['id'],
          name: newData['major']['name'],
          description: newData['major']['description'],
        );
        log('2222222222222222');
        log('ID ${newData['university']['id']}');
        log('code ${newData['university']['code']}');
        log('name ${newData['university']['name']}');
        log('email ${newData['university']['email']}');
        log('website ${newData['university']['website']}');
        log('description ${newData['university']['description']}');
        University university = University(
          ID: newData['university']['id'],
          code: newData['university']['code'],
          name: newData['university']['name'],
          email: newData['university']['email'],
          facebook: newData['university']['facebook'],
          website: newData['university']['website'],
          description: newData['university']['description'],
          lastYearBenchMark: newData['university']['lastYearBenchmark'],
          minFee: newData['university']['minFee'],
          maxFee: newData['university']['maxFee'],
        );
        log('dddddddddddddddddddddddddđ ${newData['createdDate']}');
        // log('HINHHHHHHH ${newData['image'][1]['src']}');
        String dateTmp = newData['createdDate'].toString().substring(0, 10);
        log('dddddddddddddddddddddddddđ $dateTmp');
        String tmpTime = newData['startDate'].toString().substring(11, 16);
        log('dddddddddddddddddddddddddđ $tmpTime');
        Talkshow talkshow = Talkshow(
          ID: newData['ID'],
          // ID: 1,
          counselor: counselor,
          date: dateTmp ?? '',
          description: newData['description'] ?? '',
          image: newData['image'] ?? '',
          // image: 'zdfv',
          price: newData['price'] ?? 0,
          timeFinish: newData['timeFinish'] ?? '',
          timeStart: tmpTime ?? '',
          major: major,
          university: university,
        );
        log('TALKSHOW    ${talkshow.date}');
        return talkshow;
      }).toList();
      log('NUMBER PAGE : ${data['numPage']}');
      for (Talkshow i in list) {
        log('TEN : ${i.date}');
      }

      map = {'${data['numPage']}': list};
      // log('MAP ${map.entries.first.key}');
      // log('MAP ${map.entries.first.value.toString()}');
      _numberPage = data['numPage'];
      _list = list;
      log(_list.length.toString());

      notifyListeners();
      return map;
    } catch (error) {
      log('SOMETHING WRONG in get lisst talkshow! ${error.toString()}');
      // throw (error);
      return null;
    }
  }

  Future<bool> createTalkshow(
    String description,
    String image,
    int price,
    String urlMeet,
    String date,
    int majorID,
    int univerID,
    String time,
  ) async {
    try {
      log('DATEEEEEEEEEEE : $date');
      String dateTime = date + 'T' + time;
      // log('IDDDDDDDĐ  -=================: $ID');
      String token = await AppValue.getToken();
      log('TOKEN IN LOCAL : $token');

      Uri uri = Uri.parse(
        'https://40.81.193.10/api/talkshowManagement/createTalkshow',
      );
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode({
          "description": description,
          "image": image,
          "price": price,
          "urlMeet": urlMeet,
          "startDate": dateTime,
          "majorId": majorID,
          "universityId": univerID,
        }),
      );
      log('status code create talkshow : ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log(data.toString());
      notifyListeners();
      return true;
    } catch (error) {
      log('SOMETHING WRONG in create talkshow! ${error.toString()}');
      // throw (error);
      return false;
    }
  }

  Future<bool> cancleTalkshow(int ID) async {
    try {
      log('IDDDDDDDĐ cancale  -=================: $ID');
      String token = await AppValue.getToken();
      log('TOKEN IN LOCAL : $token');

      Uri uri = Uri.parse(
        'https://40.81.193.10/api/talkshowManagement/cancelTalkshow',
      );
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode({"id": ID}),
      );
      log('status code cancle talkshow fail : ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log(data.toString());
      notifyListeners();
      if (response.statusCode < 400) {
        return true;
      } else {
        if (data['message'] == 'Talkshow has been canceled')
          return true;
        else
          return false;
      }
    } catch (error) {
      log('SOMETHING WRONG in cancle talkshow! ${error.toString()}');
      return false;
    }
  }
}
