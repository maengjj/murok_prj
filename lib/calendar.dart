import 'package:flutter/material.dart';
// import 'package:flutter_clean_calendar2/flutter_clean_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import 'package:murok_prj/calendar/flutter_clean_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}



class _CalendarScreenState extends State<CalendarScreen> {

  final Map<DateTime, List<CleanCalendarEvent>> _events = {};





  DateTime _date = DateTime.now();


  List data = [];

  Future<void> getData() async {
    // http.Response response = await http.get(
    //   Uri.parse('http://15.164.103.233:3000/app/plants'),
    // );
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      var url = Uri.parse('http://15.164.103.233:3000/app/plants/calendar');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'x-access-token': '$token'
      };

      var response = await http.get(url, headers: headers);

      print(response);

      print(response.body);

      Map<String, dynamic> responseJson = json.decode(response.body);

      responseJson.keys.forEach((key) {
        List<DateTime> dateList = List<DateTime>.from(responseJson[key].map((dateString) => DateTime.parse(dateString)));
        print("$key 날짜 리스트: $dateList");

        _date = dateList[0];

        print(_date);

        print(_date.year);
        print(_date.month);

        // _events.addAll({
        //   for (var date in dateList)
        //     DateTime(date.year, date.month, date.day): [
        //       CleanCalendarEvent(key,
        //         startTime: DateTime(date.year, date.month, date.day),
        //         description: 'A special event',
        //         color: Colors.blue.shade700,
        //         // 이벤트의 다른 속성 설정...
        //       ),
        //     ]
        // });

        for (var date in dateList) {
          List<CleanCalendarEvent> eventsForDate = [];

          for (var key in responseJson.keys) {
            if (responseJson[key].contains(date.toIso8601String())) {
              eventsForDate.add(
                CleanCalendarEvent(key,
                  startTime: date,
                  description: '물 주기',
                  color: Colors.blue.shade700,
                  // 이벤트의 다른 속성 설정...
                ),
              );
            }
          }

          _events[DateTime(date.year, date.month, date.day)] = eventsForDate;
        }

      });

    }

    // return "success";
  }


  // final Map<DateTime, List<CleanCalendarEvent>> _events = {
  //   DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
  //     CleanCalendarEvent('Event A',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day),
  //         // endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //         //     DateTime.now().day + 2),
  //         description: 'A special event',
  //         color: Colors.blue.shade700),
  //   ],
  //   DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
  //   [
  //     CleanCalendarEvent('Event B',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 10, 0),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 12, 0),
  //         color: Colors.orange),
  //     CleanCalendarEvent('Event C',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.pink),
  //   ],
  //   DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3):
  //   [
  //     CleanCalendarEvent('Event B',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 10, 0),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 12, 0),
  //         color: Colors.orange),
  //     CleanCalendarEvent('Event C',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.pink),
  //     CleanCalendarEvent('Event D',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.amber),
  //     CleanCalendarEvent('Event E',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.deepOrange),
  //     CleanCalendarEvent('Event F',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.green),
  //     CleanCalendarEvent('Event G',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.indigo),
  //     CleanCalendarEvent('Event H',
  //         startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 14, 30),
  //         endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 2, 17, 0),
  //         color: Colors.brown),
  //   ],
  // };


  @override
  void initState() {
    super.initState();
    _handleNewDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    fetchDataAndInitializeEvents();
  }


  Future<void> fetchDataAndInitializeEvents() async {
    await getData(); // 데이터 가져오기를 기다림
    setState(() {
      // _events를 변경하고 페이지를 다시 빌드
    });
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // 현재 페이지를 닫고 이전 페이지로 돌아가기
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "캘린더",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              IconButton(
                onPressed: () {
                  //
                  // DateTime today = DateTime.now();
                  // _handleNewDate(today);
                  //
                  // setState(() {
                  //   _events[today] = [
                  //
                  //   ];
                  // });

                },
                icon: Icon(
                  Icons.today,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xff06C09F), toolbarHeight: 80),
      body: SafeArea(
    child: Padding(
    padding: const EdgeInsets.only(top: 24.0),
        child: Calendar(
          startOnMonday: true,
          weekDays: const ['월', '화', '수', '목', '금', '토', '일'],
          events: _events,
          isExpandable: true,
          eventDoneColor: Colors.green,
          selectedColor: Colors.pink,
          todayColor: Colors.blue,
          eventColor: Colors.grey,
          locale: 'ko_KR',
          todayButtonText: '오늘로 가기',
          isExpanded: true,
          expandableDateFormat: 'yyyy MMMM dd. EEEE',
          dayOfWeekStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 11,
          ),
        ),
      ),
      ),
    );
  }




  void _handleNewDate(DateTime date) {
    print('Date selected: $date');
  }
}
