import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlReadMore extends StatefulWidget {
  final String htmlData;
  final int trimLines;

  HtmlReadMore({Key? key, required this.htmlData, required this.trimLines})
      : super(key: key);

  @override
  _HtmlReadMoreState createState() => _HtmlReadMoreState();
}

class _HtmlReadMoreState extends State<HtmlReadMore> {
  bool _isExpanded = false;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Html(
          key: _key,
          data: widget.htmlData,
          style: {
            "html": Style(
              maxLines: _isExpanded ? null : widget.trimLines,
              textOverflow: TextOverflow.clip,
            ),
            "*": Style(
              fontFamily: 'Lato',
              color: Colors.white, // Set your desired text color here
            ),
          },
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final RenderBox renderBox =
                _key.currentContext?.findRenderObject() as RenderBox;
            final size = renderBox.size;

            return InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Container(
                width:
                    size.width, // This will take the width of the Html widget
                padding: EdgeInsets.only(
                    left: size.width -
                        size.width *
                            0.33), // This is a rough estimate, adjust as necessary
                child: Text(
                  _isExpanded ? 'Read less...' : 'Read more...',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
