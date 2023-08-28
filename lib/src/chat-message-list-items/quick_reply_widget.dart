import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:murok_prj/src/chat.dart';
import 'package:murok_prj/src/extensions/theme_context.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

final class QuickReplyWidget extends StatelessWidget {
  const QuickReplyWidget(this.chatMessage);

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: -50,
      // alignment: WrapAlignment.spaceEvenly,
      children: _buttons(context),
    ).padding(
      left: 16,
      right: 16,
      top: 0,
      bottom: 8,);
  }

  List<Widget> _buttons(BuildContext context) {
    return chatMessage.messageKind.quickReplies
        .map(
          (qr) => Padding(
            padding: EdgeInsets.only(left: 104),  // 왼쪽에 8의 padding 추가
            child : OutlinedButton(
            style: context.theme.quickReplyButtonStyle,
            onPressed: () => ChatStateContainer.of(context)
                .onQuickReplyItemPressed
                ?.call(qr),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  bottom: 8,
                  top: 8,),  // 텍스트 주변에 패딩 추가
                child: Text(qr.title),
              ),
          ),
        ),
    )
        .toList();
  }
}
