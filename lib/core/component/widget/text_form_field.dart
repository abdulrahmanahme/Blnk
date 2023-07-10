import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {this.validationText,
      this.labeText,
      this.hintText,
      this.suffixIcon,
      this.controller,
      super.key});
  final TextEditingController? controller;
  final String? validationText;
  final String? hintText;
  final Widget? suffixIcon;
  final String? labeText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(right: 5.w, top: 2.h, bottom: 1.h, left: 8.w),
          child: Row(
            children: const [],
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: defaultFormField(
            hintText: hintText,
            suffixIcon: suffixIcon,
            labelStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal',
            ),
            controller: controller,
            validate: (value) {
              if (value!.isEmpty) {
                return validationText;
              }
              return null;
            },
            type: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  String? label,
  TextStyle? labelStyle,
  String? hintText,
  IconData? prefix,
  TextStyle? style,
  IconData? suffix,
  Function? suffixpress,
  Widget? suffixIcon,
  int? maxLines,
}) =>
    Padding(
      padding: EdgeInsets.only(left: 6.w, right: 6.w),
      child: Container(
        // height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          validator: validate,
          maxLines: maxLines,
          style: style,
          decoration: InputDecoration(
            // errorStyle: TextStyle(height: 1),
// constraints: BoxConstraints(maxHeight: 58, minHeight: 50),
            labelText: label,
            labelStyle: labelStyle,
            hintText: hintText,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),

            contentPadding: EdgeInsets.symmetric(vertical: 5),
            prefixIcon: Icon(
              prefix,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              // borderSide: BorderSide.none,

              borderSide: BorderSide(
                color: Color(0xffC2C2C2),
                width: 1.0,
              ),
            ),

            suffixIcon: suffixIcon,

            // suffixIcon: IconButton(
            //     icon: Icon(
            //       suffix,
            //     ),
            //     onPressed: () {
            //       suffixpress!;
            //     }),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
