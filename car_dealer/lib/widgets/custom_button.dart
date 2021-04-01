import 'package:car_dealer/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  CustomBtn({this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 34.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double sizeW;
  final bool isLoading;
  SubmitBtn({this.text, this.onPressed, this.sizeW, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ?? false;
    double _sizeW = sizeW ?? 40;

    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: RaisedButton(
                  onPressed: onPressed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Constants.secColor,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: _sizeW * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Constants.mainColor),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      text ?? "Text",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
