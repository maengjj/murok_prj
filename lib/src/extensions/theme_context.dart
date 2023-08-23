import 'package:flutter/material.dart';

import 'package:murok_prj/src/inherited_chat_theme.dart';
import 'package:murok_prj/src/theme/chat_theme.dart';

extension ChatThemeContext on BuildContext {
  ChatTheme get theme => InheritedChatTheme.of(this).theme;
}
