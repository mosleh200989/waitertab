
import 'package:flutter/material.dart';

class LabelAndText extends StatelessWidget {
  LabelAndText({
    Key key,
    this.salesInfoText,
    this.title,
    this.textColor,
    this.fontWeight,
  }) : super(key: key);
  final String salesInfoText;
  final String title;
  final Color textColor;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left:5,
          right:5,
          top:3),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: fontWeight, color: textColor),
          ),
          Text(
            salesInfoText ?? '',
            style: Theme
                .of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: fontWeight, fontSize: 12.00),
          )
        ],
      ),
    );
  }
}

