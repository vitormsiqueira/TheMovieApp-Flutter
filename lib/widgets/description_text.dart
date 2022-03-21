import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf = '';
  String secondHalf = '';

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    height: 1.5,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.justify,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "ver mais" : "ver menos",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
