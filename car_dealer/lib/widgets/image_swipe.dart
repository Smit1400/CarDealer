import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;
  ImageSwipe({this.imageList});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedImg = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedImg = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                      child: Image.network("${widget.imageList[i]}",
                          fit: BoxFit.cover))
              ],
            ),
            Positioned(
                bottom: 20,
                left:30,
                right: 0.0,
                child: Row(
                  children: [
                    for (var i = 0; i < widget.imageList.length; i++)
                      AnimatedContainer(
                        duration:Duration(
                          milliseconds: 300
                        ),
                        curve:Curves.easeInOutCubic,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: _selectedImg==i?25:12,
                        height: 12,
                        // color: Colors.blue,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:Colors.black.withOpacity(0.5) 
                        ),
                      )
                  ],
                ))
          ],
        ));
  }
}
