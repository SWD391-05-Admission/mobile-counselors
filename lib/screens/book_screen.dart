import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_customer/models/talkshow.dart';
import 'package:mobile_customer/providers/talkshow_controller.dart';
import 'package:mobile_customer/values/app_styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen();
  static const routesName = '/setting';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Talkshow> listTalkshow = [];
  Future future;
  @override
  void initState() {
    future = TalkshowController().getListTalkshow('', '', '', 1, 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final double _sizeWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_sizeHeight * 0.07),
          child: Column(
            children: [
              SizedBox(
                height: 36,
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Sắp diễn ra",
                        style: AppStyle.barStyle,
                        // style: AppStyle.titleSearch,
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Đã kết thúc",
                        style: AppStyle.barStyle,
                        // style: AppStyle.titleSearch,
                      ),
                    ),
                  ),
                ],
                unselectedLabelColor: Colors.white54,
                indicatorColor: Colors.white70,
                indicatorWeight: 0.9,
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, List<Talkshow>> mapTalkshow = snapshot.data;
                  String numberOfPage = mapTalkshow.keys.elementAt(0);
                  List<Talkshow> list = mapTalkshow.entries.first.value;
                  if (list.length != 0) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 4, left: 15, right: 15),
                      child: ListView(
                        children: [
                          for (int i = 0; i < list.length; i++) ...{
                            (list[i].isCancle)
                                ? SizedBox()
                                : Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 90,
                                          width: 140,
                                          child: Image.network(
                                            list[i].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              '/talkshow-detail-history-screen',
                                              arguments: list[i]);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                list[i].description,
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Vào lúc ${list[i].timeStart} ngày ${list[i].date}',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Tên trường : ${list[i].university.name}',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Tên chuyên ngành : ${list[i].major.name}',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Giá : ${list[i].price} miếng dưa hấu',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: 28,
                                          color: Colors.white70,
                                        ),
                                        onTap: () async {
                                          return showDialog(
                                            context: context,
                                            builder: (context) {
                                              // String areaDropdow;
                                              return SimpleDialog(
                                                // key: _formKey,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      'Bạn có muốn đóng buổi tư vấn này không ?',
                                                      style:
                                                          AppStyle.titleSearch,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          _sizeHeight * 0.02),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          log('TALKSHOW ID ${list[i].ID}');
                                                          TalkshowController()
                                                              .cancleTalkshow(
                                                                  list[i].ID)
                                                              .then((value) {
                                                            if (value) {
                                                              setState(() {
                                                                future =
                                                                    TalkshowController()
                                                                        .getListTalkshow(
                                                                            '',
                                                                            '',
                                                                            '',
                                                                            1,
                                                                            2);
                                                              });

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                  "Đã đóng buổi tư vấn !",
                                                                  style: AppStyle
                                                                      .bookDetail
                                                                      .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ));
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                  "Đóng thất bại !",
                                                                  style: AppStyle
                                                                      .bookDetail
                                                                      .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ));
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          'Có',
                                                          style: AppStyle
                                                              .titleSearch,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            _sizeWidth * 0.03,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'Không',
                                                          style: AppStyle
                                                              .titleSearch,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            _sizeWidth * 0.06,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                            (i < list.length - 1 && !list[i].isCancle)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Divider(
                                        height: 1, color: Colors.black26),
                                  )
                                : SizedBox(),
                          }
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Bạn chưa tạo buổi tư vấn nào !',
                        style: AppStyle.barStyle.copyWith(color: Colors.white),
                      ),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white60,
                    ),
                  );
                } else {
                  return Center();
                }
              },
            ),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, List<Talkshow>> mapTalkshow = snapshot.data;
                  String numberOfPage = mapTalkshow.keys.elementAt(0);
                  List<Talkshow> list = mapTalkshow.entries.first.value;
                  if (list.length != 0) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 4, left: 15, right: 15),
                      child: ListView(
                        children: [
                          for (int i = 0; i < list.length; i++) ...{
                            (!list[i].isCancle && !list[i].isFinish)
                                ? SizedBox()
                                : Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 90,
                                          width: 140,
                                          child: Image.network(
                                            list[i].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              '/talkshow-detail-history-screen',
                                              arguments: list[i]);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                list[i].description,
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Vào lúc ${list[i].timeStart} ngày ${list[i].date}',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Tên trường : ${list[i].university.name}',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Tên chuyên ngành : ${list[i].major.name}',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Giá : ${list[i].price} miếng dưa hấu',
                                                style: AppStyle.bookDetail,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                            (i < list.length - 1)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Divider(
                                        height: 1, color: Colors.black26),
                                  )
                                : SizedBox(),
                          },
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Bạn chưa tạo buổi tư vấn nào !',
                        style: AppStyle.barStyle,
                      ),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white60,
                    ),
                  );
                } else {
                  return Center();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
