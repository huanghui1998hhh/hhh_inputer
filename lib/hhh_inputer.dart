import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/input_item.dart';

class HHHInputer extends StatefulWidget {
  HHHInputer({Key key, this.labelList, this.unUsedLabelList}) : super(key: key);
  final List<String> labelList;
  final List<String> unUsedLabelList;

  @override
  _HHHInputerState createState() => _HHHInputerState();
}

class _HHHInputerState extends State<HHHInputer>
    with SingleTickerProviderStateMixin {
  final duration = Duration(milliseconds: 300);
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  Color backgroundColor = Colors.grey[100];
  Color borderColor = Colors.grey[400];
  AnimationController animationController;

  String onPutString = "";

  Size size;
  Offset offset;

  OverlayEntry overlayEntry;
  OverlayState overlayState;

  void setPosition() {
    RenderBox renderBox = context.findRenderObject();
    size = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);
  }

  OverlayEntry overlay() {
    setPosition();
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        child: SizeTransition(
          sizeFactor: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animationController, curve: Curves.easeInOut),
          ),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.easeInOut),
            ),
            child: Material(
              child: Container(
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onPutString != null && onPutString.trim() != "")
                      OverlayItem(
                        overlayItemLabel: onPutString,
                        isReview: true,
                      ),
                    for (var i = 0; i < widget.unUsedLabelList.length; i++)
                      OverlayItem(
                        overlayItemLabel: widget.unUsedLabelList[i],
                        onTap: () {
                          setState(() {
                            widget.labelList
                                .add(widget.unUsedLabelList.removeAt(i));
                          });
                          Future.delayed(Duration(milliseconds: 50), () {
                            overlayState.setState(setPosition);
                          });
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(duration: duration, vsync: this);
    overlayState = Overlay.of(context);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        overlayEntry = overlay();
        overlayState.insert(overlayEntry);
        animationController.forward();
        setState(() {
          backgroundColor = Colors.white;
          borderColor = Colors.grey[800];
        });
      } else {
        setState(() {
          backgroundColor = Colors.grey[100];
          borderColor = Colors.grey[400];
          textEditingController.clear();
        });
        animationController.reverse().then((value) => overlayEntry.remove());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.all(6),
        constraints: BoxConstraints(minHeight: 38),
        width: 300,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (var i = 0; i < widget.labelList.length; i++)
              InputItem(
                itemLabel: widget.labelList[i],
                onTap: () {
                  setState(() {
                    widget.unUsedLabelList.add(widget.labelList.removeAt(i));
                  });
                  Future.delayed(Duration(milliseconds: 50), () {
                    overlayState.setState(setPosition);
                  });
                },
              ),
            Container(
              height: 24,
              width: 50,
              child: TextField(
                scrollPadding: EdgeInsets.all(0),
                focusNode: focusNode,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: textEditingController,
                onEditingComplete: () {
                  setState(() {
                    widget.labelList.add(textEditingController.text);
                    textEditingController.clear();
                  });
                  Future.delayed(Duration(milliseconds: 50), () {
                    onPutString = "";
                    overlayState.setState(setPosition);
                  });
                },
                onChanged: (value) {
                  onPutString = value;
                  overlayState.setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
