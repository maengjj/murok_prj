import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'layout.dart';


class Note {
  String title;
  bool isDone;
  DateTime dateTime; // 추가: 날짜 및 시간 정보 저장

  Note(this.title, {this.isDone = false, required this.dateTime});
}

class AlarmNote extends StatefulWidget {
  @override
  _AlarmNoteState createState() => _AlarmNoteState();

  // 정적 변수와 메서드를 추가합니다.
  static String? messageBody;

  static void printMessage() {
    if (messageBody != null) {
      _AlarmNoteState()._loadNotes(); // 메시지 수신시 화면 갱신
      print("Received message: $messageBody");
      // _AlarmNoteState()._loadNotes(); // 메시지 수신시 화면 갱신
    }
  }

}

class _AlarmNoteState extends State<AlarmNote> {

  final _itemList = <Note>[];
  var _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes(); //0818 추가!!!
    AlarmNote.printMessage(); // 수신된 메시지 출력
  }


  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Get.offAll(() => LayoutPage());
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Color(0xFF06C09F),
        centerTitle: true,
        title: Text(
          '알림',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            height: 1.2,
            fontFamily: 'sans-serif-light',
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextField(
            //         controller: _noteController,
            //       ),
            //     ),
            //     ElevatedButton(
            //       child: Text('추가'),
            //       onPressed: () => _addNote(Note(_noteController.text)),
            //     ),
            //   ],
            // ),
            Expanded(
              child: ListView(
                children: _itemList.map((note) => _buildItem(note)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Note note) {
    return ListTile(
      title: Text(
        note.title,
        style: TextStyle(
          fontSize: 20.0, // 원하는 크기로 수정
          decoration: note.isDone
              ? TextDecoration.lineThrough
              : null,
          fontStyle: note.isDone ? FontStyle.italic : FontStyle.normal,
        ),
      ),
      subtitle: Text(
        DateFormat('yyyy-MM-dd HH:mm').format(note.dateTime), // 날짜 및 시간 표시
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever, size: 30,),
        onPressed: () => _deleteNote(note),
      ),
      onTap: () => _toggleNote(note),
    );
  }


  void _addNote(Note note) {
    setState(() {
      note.dateTime = DateTime.now(); // 현재 날짜 및 시간 추가
      _itemList.add(note);
      _noteController.text = "";
      _saveNotes(); // 노트를 추가한 후 저장합니다.
    });
  }

  void _deleteNote(Note note) {
    setState(() {
      _itemList.remove(note);
      _saveNotes(); // 노트를 추가한 후 저장합니다.
    });
  }

  void _toggleNote(Note note) {
    setState(() {
      note.isDone = !note.isDone;
      _saveNotes(); // 노트를 추가한 후 저장합니다.
    });
  }


  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = _itemList.map((note) => noteToJson(note)).toList();
    await prefs.setStringList('notes', notesJson);
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList('notes') ?? [];
    setState(() {
      _itemList.clear();
      _itemList.addAll(notesJson.map((json) => noteFromJson(json)));

      if (AlarmNote.messageBody != null && !_itemList.any((note) => note.title == AlarmNote.messageBody)) {
        _itemList.add(Note(AlarmNote.messageBody!, dateTime: DateTime.now())); // 현재 시간 추가
        // _itemList.add(Note(AlarmNote.messageBody!));
        _saveNotes(); // 변경된 내용 저장
      }

    });
  }

  String noteToJson(Note note) {
    return '{"title": "${note.title}", "isDone": ${note.isDone}}';
  }

  Note noteFromJson(String json) {
    Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(json));
    return Note(data['title'], isDone: data['isDone'],
    dateTime: DateTime.parse(data['dateTime']),
    );
  }

}