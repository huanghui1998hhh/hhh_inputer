import 'dart:math';

import 'package:flutter/material.dart';

class InputItem extends StatelessWidget {
  const InputItem({Key key, this.itemLabel, this.onTap}) : super(key: key);
  final String itemLabel;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 24,
        padding: EdgeInsets.only(left: 6, right: 6),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(itemLabel),
            SizedBox(width: 4),
            InkWell(
              onTap: onTap,
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OverlayItem extends StatelessWidget {
  const OverlayItem(
      {Key key, this.overlayItemLabel, this.onTap, this.isReview = false})
      : super(key: key);
  final String overlayItemLabel;
  final void Function() onTap;
  final bool isReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: isReview ? Colors.grey[400] : Colors.grey[500],
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              overlayItemLabel,
              style: TextStyle(color: isReview ? Colors.grey[900] : null),
            ),
          ],
        ),
      ),
    );
  }
}
