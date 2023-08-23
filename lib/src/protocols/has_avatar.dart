import 'package:flutter/material.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

mixin HasAvatar {
  Message get message;

  UserAvatar? get userAvatar => message.user.avatar;

  AvatarPosition get avatarPosition =>
      userAvatar?.position ?? AvatarPosition.center;

  // ImageProvider? get avatarImageProvider => userAvatar?.imageProvider;

  ImageProvider? get avatarImageProvider {
    if (userAvatar != null) {
      return AssetImage('assets/murokee_circle.png');
    } else {
      return null;
    }
  }


  double get _radius => (userAvatar?.size ?? 36) ;

  List<Widget> avatarWithPadding([double padding = 8]) => [
        SizedBox(width: padding),
        if (avatarImageProvider != null)
          CircleAvatar(
            radius: _radius,
            backgroundColor: Colors.transparent,
            backgroundImage: avatarImageProvider,
          ),
        SizedBox(width: padding),
      ].toList();
}
