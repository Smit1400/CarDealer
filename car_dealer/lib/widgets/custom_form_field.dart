import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomFormField extends StatelessWidget {
  final TextInputType keyBoardType;
  final Function onChanged;
  final String labelText;
  final MultiValidator validator;

  CustomFormField({
    this.keyBoardType,
    @required this.onChanged,
    @required this.labelText,
    @required this.validator,
  })  : assert(labelText != null),
        assert(onChanged != null),
        assert(validator != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        validator: validator,
        keyboardType: keyBoardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.indigoAccent),
          ),
          labelStyle: new TextStyle(color: Colors.indigo),
          labelText: labelText,
        ),

      ),
    );
  }
}
