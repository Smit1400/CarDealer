import 'package:flutter/material.dart';
import 'package:car_dealer/components/constants.dart';


class ImageSwipe extends StatefulWidget {
  final List imageList;
  final String price;
  ImageSwipe({this.imageList,this.price});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedImg = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
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
                bottom: 40,
                left: 140,
                right: 50.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var i = 0; i < widget.imageList.length; i++)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: _selectedImg == i ? 25 : 12,
                        height: 12,
                        // color: Colors.blue,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Constants.secColor.withOpacity(0.9)),
                      )
                  ],
                )),
            Positioned(
              right: 15.0,
              bottom: 0,
              child: Chip(
                elevation: 0,
                labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                backgroundColor: Constants.backgroundColor,
                label: Text("Rs."+this.widget.price,
                style: TextStyle(
                  color:Colors.black
                ),),
              ),
            )
          ],
        ));
  }
}
