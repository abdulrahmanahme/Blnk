import 'package:blnk/core/component/widget/button_widget.dart';
import 'package:blnk/core/component/widget/text_form_field.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';

import '../core/component/app_constants/app_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLNK'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TextFormFieldWidget(
              // controller: controllerLastname,
              // labeText: 'First Name',
              hintText: ' First Name',
              validationText: 'Please enter the First Name',
            ),
            const TextFormFieldWidget(
              // controller: controllerLastname,
              hintText: 'Last Name',
              validationText: 'Please enter the Last Name',
            ),
            const TextFormFieldWidget(
              // controller: controllerLastname,
              hintText: ' Address',
              validationText: 'Please enter the Address',
            ),
            const TextFormFieldWidget(
              // controller: controllerLastname,
              hintText: 'Landline',
              validationText: 'Please enter the Landline',
            ),
            const TextFormFieldWidget(
              // controller: controllerLastname,
              hintText: 'Mobile',
              validationText: 'Please enter the Mobile',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 5, top: 10),
              child: Container(
                color: Colors.grey.shade300,
                child: DropDownField(
                  // controller: ,

                  hintStyle: const TextStyle(fontSize: 12),
                  labelStyle: const TextStyle(fontSize: 0),
                  hintText: 'Choose an Area',
                  items:AppConst.cities,

                  strict: true,
                  onValueChanged: (value) {
                    selectedValue = value;

                  },
                ),
              ),
            ),
         const   SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                name: 'Submit',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
