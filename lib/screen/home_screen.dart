import 'dart:io';

import 'package:blnk/core/component/widget/button_widget.dart';
import 'package:blnk/core/component/widget/text_form_field.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../core/component/app_constants/app_const.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  void selectImage() async {
     XFile? selectImage = await imagePicker.pickImage(source: ImageSource.camera);
  var croppedImage =await cropImage(imageFile:selectImage!);
    if (croppedImage !=null) {
      imageFileList.add(croppedImage);
    }
    setState(() {});
  }
  Future<XFile?>cropImage({required XFile imageFile})async{
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if(croppedImage ==null) return null;
    return XFile(croppedImage.path);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLNK'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TextFormFieldWidget(
            // controller: controllerLastname,

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
                items: AppConst.cities,

                strict: true,
                onValueChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: imageFileList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(imageFileList[index].path),
                      fit: BoxFit.cover,
                    );
                  })),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(
              name: 'Submit',
              onPressed: () {
                selectImage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
