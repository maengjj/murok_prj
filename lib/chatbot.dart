import 'package:flutter/material.dart';
import 'package:murok_prj/swifty_chat.dart';
import 'package:swifty_chat_mocked_data/swifty_chat_mocked_data.dart';
import 'login.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'swifty_chat.dart';



class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}


enum MessageType {
  none,
  registration,
  consultation,
}


class CustomQuickReplyItem extends QuickReplyItem {
  const CustomQuickReplyItem({
    required String title,
    String? payload,
    String? url,
  }) : super(title: title, payload: payload, url: url);
}


class _ChatBotState extends State<ChatBot> {
  final TextEditingController _messageController = TextEditingController();
  final List<MockMessage> _messages = [];

  bool isWaitingForResponse = false;

  MessageType currentMessageType = MessageType.none;

  late Chat chatView;

  Timer? responseTimer; // responseTimer 변수 선언




  @override
  void initState() {
    super.initState();
    // 상대방의 초기 메시지를 추가합니다.
    final initialResponse = MockMessage(
      date: DateTime.now(),
      user: MockChatUser.incomingUser,
      id: DateTime.now().toString(),
      isMe: false,
      messageKind: MessageKind.text("새로운 작물 등록을 원한다면 등록을\n상담이 필요하면 상담을 포함해 말해주세요!!\n어떤 도움이 필요하신가요? 😊"),
    );
    _messages.add(initialResponse);
    final initialResponse2 = MockMessage(
      date: DateTime.now(),
      user: MockChatUser.incomingUser,
      id: DateTime.now().toString(),
      isMe: false,
      messageKind: MessageKind.text("안녕하세요! 저는 무럭이에요.\n오늘 뭐할지 저에게 알려주면 최대한 도와드릴게요."),
    );
    _messages.add(initialResponse2);


    List<QuickReplyItem> quickReplies = [
      CustomQuickReplyItem(title: "등록"),
      CustomQuickReplyItem(title: "상담"),
    ];

    final initialResponse3 = MockMessage(
      date: DateTime.now(),
      user: MockChatUser.incomingUser,
      id: DateTime.now().toString(),
      isMe: false,
      messageKind: MessageKind.quickReply(quickReplies),
    );
    setState(() {
      // isWaitingForResponse = true;
      _messages.insert(0, initialResponse3);
    });

  }





  Future<void> _sendMessageToServer(String userMessage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final headers = {'Content-type': 'application/json',
      'x-access-token': '$token'};
    final body = json.encode({'message': userMessage});



    // Add outgoingMessage
    final outgoingMessage = MockMessage(
      date: DateTime.now(),
      user: MockChatUser.outgoingUser,
      id: DateTime.now().toString(),
      isMe: true,
      messageKind: MessageKind.text(userMessage),
    );

    setState(() {
      isWaitingForResponse = true;
      _messages.insert(0, outgoingMessage);
    });

    // Add a timer to handle response timeout
    // Add a timer to handle response timeout
    if (isWaitingForResponse) {
      responseTimer = Timer(Duration(seconds: 10), () {
        if (isWaitingForResponse) {
          final timeoutErrorMessage = MockMessage(
            date: DateTime.now(),
            user: MockChatUser.incomingUser,
            id: DateTime.now().toString(),
            isMe: false,
            messageKind: MessageKind.text('무럭이가 다른 농부랑 대화 중인가봐요\n조금만 기다려주세요ㅠㅠ'),
          );
          setState(() {
            isWaitingForResponse = false;
            _messages.insert(0, timeoutErrorMessage);
            chatView.scrollToBottom();
          });
        }
      });
    }


    try {
      Uri url;

      // 상담일때 1>consult 으로 가고 등록일때 0>regist 감. 최초에는 3번으로 감
      if (userMessage.contains('등록')) {
        url = Uri.parse('http://15.164.103.233:3000/app/plants/GPT/0');
        currentMessageType = MessageType.registration;
        print(url);
        print('등록');
      } else if (userMessage.contains('상담')) {
        url = Uri.parse('http://15.164.103.233:3000/app/plants/GPT/1');
        currentMessageType = MessageType.consultation;
        print(url);
        print('상담');
      } else {
        url = currentMessageType == MessageType.registration
            ? Uri.parse('http://15.164.103.233:3000/app/plants/regist')
            : Uri.parse('http://15.164.103.233:3000/app/plants/consult');
        print(url);
      }


      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        // final responseData = json.decode(response.body);
        // print(responseData);
        // final botResponseMessage = responseData['message'];
        final botResponseMessage = response.body;

        // Add botResponse after receiving server response
        final botResponse = MockMessage(
          date: DateTime.now(),
          user: MockChatUser.incomingUser,
          id: DateTime.now().toString(),
          isMe: false,
          messageKind: MessageKind.text(botResponseMessage),
        );
        setState(() {
          isWaitingForResponse = false;
          _messages.insert(0, botResponse);
          chatView.scrollToBottom();
        });




      } else {
        print('Error sending message to server2: ${response.statusCode}');
        final botResponse = MockMessage(
          date: DateTime.now(),
          user: MockChatUser.incomingUser,
          id: DateTime.now().toString(),
          isMe: false,
          messageKind: MessageKind.text('무럭이가 다른 농부랑 대화 중인가봐요\n잠시후 다시 시도해주세요ㅠㅠ'),
        );
        setState(() {
          isWaitingForResponse = false;
          _messages.insert(0, botResponse);
          chatView.scrollToBottom();
        });
      }
    } catch (error) {
      print('Error sending message to server: $error');
      final botResponse = MockMessage(
        date: DateTime.now(),
        user: MockChatUser.incomingUser,
        id: DateTime.now().toString(),
        isMe: false,
        messageKind: MessageKind.text('무럭이가 다른 농부랑 대화 중인가봐요\n잠시후 다시 시도해주세요ㅠㅠ'),
      );
      setState(() {
        isWaitingForResponse = false;
        _messages.insert(0, botResponse);
        chatView.scrollToBottom();
      });
    } finally {
      // Cancel the timer when a response is received or an error occurs
      if (responseTimer != null && responseTimer!.isActive) {
        responseTimer!.cancel();
      }
    }
  }





  // QuickReplyItem 선택 시 호출되는 함수
  void handleQuickReplyItemPressed(QuickReplyItem item) {
    final userMessage = item.title;  // QuickReply의 title을 userMessage로 사용
    _sendMessageToServer(userMessage);  // 서버에 메시지 전송
    final message = MockMessage(
      date: DateTime.now(),
      user: MockChatUser.outgoingUser,
      id: DateTime.now().toString(),
      isMe: true,
      messageKind: MessageKind.text(userMessage),
    );
    chatView.scrollToBottom();
    setState(() {
      // _messages.insert(0, message);
    });
  }









  @override
  Widget build(BuildContext context) {
    chatView = _chatWidget(context);
    return Scaffold(
      body: Column(
        children: [
          // Visibility(
          //   visible: isWaitingForResponse,
          //   child: Container(
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     child: SizedBox(
          //       width: 20, // 원하는 너비 설정
          //       height: 20, // 원하는 높이 설정
          //       child: CircularProgressIndicator(
          //         color: Colors.black,
          //         strokeWidth: 3.0, // 원의 두께 설정
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Chat(
              theme: const DarkChatTheme(),
              messages: _messages,
              chatMessageInputField: MessageInputField(
                key: const Key('message_input_field'),
                sendButtonTapped: (msg) {
                  debugPrint(msg);
                  setState(
                        () {
                      final outgoingMessage = MockMessage(
                        date: DateTime.now(),
                        user: MockChatUser.outgoingUser,
                        id: DateTime.now().toString(),
                        isMe: true,
                        messageKind: MessageKind.text(msg),
                      );
                      _sendMessageToServer(msg);
                      chatView.scrollToBottom();
                    },
                  );
                },
              ),
            )
                .setOnQuickReplyItemPressed(handleQuickReplyItemPressed),
            //     .setOnQuickReplyItemPressed(
            //       (item) {
            //     debugPrint(item.title);
            //     final message = MockMessage(
            //       date: DateTime.now(),
            //       user: MockChatUser.outgoingUser,
            //       id: DateTime.now().toString(),
            //       isMe: true,
            //       messageKind: MessageKind.text(item.title),
            //     );
            //     // _messages.insert(0, message);
            //     chatView.scrollToBottom();
            //     setState(() {
            //       _messages.insert(0, message);
            //     });
            //   },
            // ).setOnMessagePressed(
            //       (message) {
            //     debugPrint(message.messageKind.toString());
            //   },
            // ),
          ),

        ],
      ),
    );
  }

  Chat _chatWidget(BuildContext context) => Chat(
    theme: const DarkChatTheme(),
    messages: _messages,
    chatMessageInputField: MessageInputField(
      key: const Key('message_input_field'),
      sendButtonTapped: (msg) {
        debugPrint(msg);
        setState(
              () {
            final outgoingMessage = MockMessage(
              date: DateTime.now(),
              user: MockChatUser.outgoingUser,
              id: DateTime.now().toString(),
              isMe: true,
              messageKind: MessageKind.text(msg),
            );
            _sendMessageToServer(msg);
            chatView.scrollToBottom();
          },
        );
      },
    ),
  )
      .setOnQuickReplyItemPressed(
        (item) {
      debugPrint(item.title);
      final message = MockMessage(
        date: DateTime.now(),
        user: MockChatUser.outgoingUser,
        id: DateTime.now().toString(),
        isMe: true,
        messageKind: MessageKind.text(item.title),
      );
      // _messages.insert(0, message);
      chatView.scrollToBottom();
      setState(() {
        _messages.insert(0, message);
      });
    },
  ).setOnMessagePressed(
        (message) {
      print(message.messageKind.toString());
    },
  );
}
