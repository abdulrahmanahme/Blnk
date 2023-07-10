import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Button extends StatelessWidget {
  const Button({Key? key, this.name, this.onPressed}) : super(key: key);
  final String? name;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0XFF0099FF),
          padding:
              EdgeInsets.only(top: 2.h, bottom: 1.h, left: 2.w, right: 2.w),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          name!,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Tajawal',
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
