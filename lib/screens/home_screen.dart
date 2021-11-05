import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_customer/providers/talkshow_controller.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mobile_customer/values/app_fonts.dart';
import 'package:mobile_customer/values/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final controller1 = TextEditingController();
final controller2 = TextEditingController();
final controller3 = TextEditingController();
final controller4 = TextEditingController();
final controller5 = TextEditingController();
final controller6 = TextEditingController();
String _date = '';
String _time = '';

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = picked.toString().substring(0, 10);
      });
  }

  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 15);
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        _time = picked_s.toString().substring(10, 15);
        log(selectedDate.toString());
      });
  }

  String _tieuDe = '', _urlMeet = '', _url = '';
  int _gia, _chuyenNganh, _truongTuVan;

  // DateTime selectedDate = DateTime.now();

  // _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //     helpText: 'Select booking date',
  //     // Can be used as title
  //     cancelText: 'Not now',
  //     confirmText: 'Book',
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'CREATE TALKSHOW',
                  style: AppStyle.titleSearch
                      .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 388,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF).withOpacity(0.5),
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: controller1,
                  // cursorHeight: 25.h,
                  // focusNode: ,
                  onTap: () {
                    // setState(() {
                    //   _enabled = true;
                    // });
                  },
                  onChanged: (valueTieuDe) {
                    _tieuDe = valueTieuDe;
                    log(_tieuDe);
                  },
                  maxLines: 3,
                  style: AppStyle.bookDetail.copyWith(fontSize: 14),
                  cursorColor: Color(0xFFFFFFFF),
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    hintText: ' Nhập mô tả cho buổi tư vấn',
                    hintStyle: AppStyle.bookDetail.copyWith(fontSize: 14),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Chọn thời gian bắt đầu buổi tư vấn',
                        style: AppStyle.bookDetail.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: Color(0xFFFFFFFF).withOpacity(0.5),
                        color: Colors.black12,
                      ),
                      child: TextButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: (_time == '')
                            ? Text(
                                'Chọn giờ',
                                style:
                                    AppStyle.bookDetail.copyWith(fontSize: 14),
                              )
                            : Text(
                                '$_time',
                                style:
                                    AppStyle.bookDetail.copyWith(fontSize: 14),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Chọn ngày diễn ra buổi tư vấn',
                        style: AppStyle.bookDetail.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: Color(0xFFFFFFFF).withOpacity(0.5),
                        color: Colors.black12,
                      ),
                      child: TextButton(
                        onPressed: () {
                          _selectDate(context);
                          log('Ngày giờ nè ${selectedDate.toString().substring(8, 10)}-${selectedDate.toString().substring(5, 7)}-${selectedDate.toString().substring(0, 4)}');
                          _date = selectedDate.toString();
                          log('_date $_date');
                        },
                        child: (_date == '')
                            ? Text(
                                'Chọn ngày',
                                style:
                                    AppStyle.bookDetail.copyWith(fontSize: 14),
                              )
                            : Text(
                                '${selectedDate.toString().substring(8, 10)}-${selectedDate.toString().substring(5, 7)}-${selectedDate.toString().substring(0, 4)}',
                                style:
                                    AppStyle.bookDetail.copyWith(fontSize: 14),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: 388,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF).withOpacity(0.5),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: controller2,
                    // cursorHeight: 25.h,
                    // focusNode: ,
                    onTap: () {
                      // setState(() {
                      //   _enabled = true;
                      // });
                    },
                    onChanged: (valueChuyenNganh) {
                      _chuyenNganh = int.parse(valueChuyenNganh);
                      log(_tieuDe);
                    },
                    keyboardType: TextInputType.number,
                    style: AppStyle.bookDetail.copyWith(fontSize: 14),
                    cursorColor: Color(0xFFFFFFFF),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: ' Nhập mã nghành',
                      hintStyle: AppStyle.bookDetail.copyWith(fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 388,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF).withOpacity(0.5),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: controller3,

                    // cursorHeight: 25.h,
                    // focusNode: ,
                    onTap: () {
                      // setState(() {
                      //   _enabled = true;
                      // });
                    },
                    onChanged: (valueTruong) {
                      _truongTuVan = int.parse(valueTruong);
                      log(_tieuDe);
                    },
                    keyboardType: TextInputType.number,
                    style: AppStyle.bookDetail.copyWith(fontSize: 14),
                    cursorColor: Color(0xFFFFFFFF),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: ' Nhập mã trường',
                      hintStyle: AppStyle.bookDetail.copyWith(fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 388,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF).withOpacity(0.5),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: controller4,

                    // cursorHeight: 25.h,
                    // focusNode: ,
                    onTap: () {
                      // setState(() {
                      //   _enabled = true;
                      // });
                    },
                    onChanged: (valueGia) {
                      _gia = int.parse(valueGia);
                      log(_tieuDe);
                    },
                    keyboardType: TextInputType.number,
                    style: AppStyle.bookDetail.copyWith(fontSize: 14),
                    cursorColor: Color(0xFFFFFFFF),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: ' Nhập giá cho buổi tư vấn',
                      hintStyle: AppStyle.bookDetail.copyWith(fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 388,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF).withOpacity(0.5),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: controller5,

                    // cursorHeight: 25.h,
                    // focusNode: ,
                    onTap: () {
                      // setState(() {
                      //   _enabled = true;
                      // });
                    },
                    onChanged: (valueHinh) {
                      _url = valueHinh;
                      log(_tieuDe);
                    },
                    style: AppStyle.bookDetail.copyWith(fontSize: 14),
                    cursorColor: Color(0xFFFFFFFF),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: ' Nhập url hình ảnh cho buổi tư vấn',
                      hintStyle: AppStyle.bookDetail.copyWith(fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 388,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF).withOpacity(0.5),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: controller6,

                    // cursorHeight: 25.h,
                    // focusNode: ,
                    onTap: () {
                      // setState(() {
                      //   _enabled = true;
                      // });
                    },
                    onChanged: (valueHinh) {
                      _urlMeet = valueHinh;
                      log(_tieuDe);
                    },
                    style: AppStyle.bookDetail.copyWith(fontSize: 14),
                    cursorColor: Color(0xFFFFFFFF),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: ' Nhập url google meet',
                      hintStyle: AppStyle.bookDetail.copyWith(fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      log('$_tieuDe - $_time - $_date - $_chuyenNganh - $_truongTuVan - $_gia - $_url');
                      if (_tieuDe == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập tiêu đề cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_time == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập thời gian cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_date == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập ngày cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_chuyenNganh == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập chuyên nghành cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_truongTuVan == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập trường cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_gia == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập giá cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_url == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập url hình cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else if (_urlMeet == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Vui lòng nhập url google meet cho buổi tư vấn !",
                            style: AppStyle.bookDetail
                                .copyWith(fontSize: 14, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else {
                        TalkshowController()
                            .createTalkshow(_tieuDe, _url, _gia, _urlMeet,
                                _date, _chuyenNganh, _truongTuVan, _time)
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Tạo thành công !",
                                style: AppStyle.bookDetail.copyWith(
                                    fontSize: 14, color: Colors.green),
                                textAlign: TextAlign.center,
                              ),
                            ));
                            setState(() {
                              _tieuDe = '';
                              _time = '';
                              _date = '';
                              _chuyenNganh = 0;
                              _truongTuVan = 0;
                              _gia = 0;
                              _url = '';
                              controller1.clear();
                              controller2.clear();
                              controller3.clear();
                              controller4.clear();
                              controller5.clear();
                              controller6.clear();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Tạo thất bại !",
                                style: AppStyle.bookDetail
                                    .copyWith(fontSize: 14, color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ));
                          }
                        });
                      }
                    },
                    child: Text(
                      'Tạo',
                      style: AppStyle.button,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.yellow[300],
                    onPressed: () {
                      setState(() {
                        _tieuDe = '';
                        _time = '';
                        _date = '';
                        _chuyenNganh = 0;
                        _truongTuVan = 0;
                        _gia = 0;
                        _url = '';
                        controller1.clear();
                        controller2.clear();
                        controller3.clear();
                        controller4.clear();
                        controller5.clear();
                        controller6.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    child: Text(
                      'Hủy bỏ',
                      style: AppStyle.button.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
