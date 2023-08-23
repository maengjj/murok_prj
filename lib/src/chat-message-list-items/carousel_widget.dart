import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:murok_prj/src/chat.dart';
import 'package:murok_prj/src/extensions/theme_context.dart';
import 'package:murok_prj/src/protocols/has_avatar.dart';
import 'package:swifty_chat_data/swifty_chat_data.dart';

final class CarouselWidget extends StatelessWidget with HasAvatar {
  const CarouselWidget(this.chatMessage);

  final Message chatMessage;

  List<CarouselItem> get items => message.messageKind.carouselItems;

  @override
  Message get message => chatMessage;

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: (_, index, __) => _CarouselItem(item: items[index]),
        options: CarouselOptions(
          height: _carouselItemHeight(context),
          disableCenter: true,
          enableInfiniteScroll: false,
        ),
      );

  double _carouselItemHeight(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final height = ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .carouselCellMaxHeightConfiguration(screenHeight);
    return height;
  }
}

final class _CarouselItem extends StatelessWidget {
  const _CarouselItem({required this.item});

  final CarouselItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.theme.carouselBoxDecoration,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (item.imageProvider != null)
            Flexible(
              child: Image(
                image: item.imageProvider!,
              ),
            ),
          Text(
            item.title,
            style: context.theme.carouselTitleTextStyle,
          ).padding(all: context.theme.textMessagePadding),
          Text(
            item.subtitle,
            style: context.theme.carouselSubtitleTextStyle,
            textAlign: TextAlign.center,
          ).padding(all: context.theme.textMessagePadding),
          Wrap(
            children: item.buttons
                .map(
                  (button) => ElevatedButton(
                onPressed: () => ChatStateContainer.of(context)
                    .onCarouselButtonItemPressed
                    ?.call(button),
                style: context.theme.carouselButtonStyle,
                child: Text(button.title),
              ),
            )
                .toList(),
          ).padding(all: 8),
        ],
      ),
    );
  }
}
