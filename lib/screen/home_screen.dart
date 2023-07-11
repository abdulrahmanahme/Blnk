import 'dart:io';

import 'package:blnk/core/component/widget/button_widget.dart';
import 'package:blnk/core/component/widget/text_form_field.dart';
import 'package:blnk/model/user_model.dart';
import 'package:blnk/server/google_sheets_apis.dart';
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
    XFile? selectImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    var croppedImage = await cropImage(imageFile: selectImage!);
    if (croppedImage != null) {
      imageFileList.add(croppedImage);
    }
    setState(() {});
  }

  Future<XFile?> cropImage({required XFile imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return XFile(croppedImage.path);
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landlineController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLNK'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              controller: firstNameController,
              hintText: ' First Name',
              validationText: 'Please enter the First Name',
            ),
            TextFormFieldWidget(
              controller: lastNameController,
              hintText: 'Last Name',
              validationText: 'Please enter the Last Name',
            ),
            TextFormFieldWidget(
              controller: addressController,
              hintText: ' Address',
              validationText: 'Please enter the Address',
            ),
            TextFormFieldWidget(
              controller: landlineController,
              hintText: 'Landline',
              validationText: 'Please enter the Landline',
            ),
            TextFormFieldWidget(
              controller: mobileController,
              hintText: 'Mobile',
              validationText: 'Please enter the Mobile',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 5, top: 10),
              child: Container(
                color: Colors.grey.shade300,
                child: DropDownField(
                  controller: areaController,
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
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
final user = User(
                      id: 1,
                      fristName: firstNameController.text,
                      lastName: lastNameController.text,
                      address: addressController.text,
                      area:areaController.text,
                      landline: landlineController.text,
                      mobile: mobileController.text,
                      nationalId: mobileController.text);
                  await  UserSheetsApis.insert([user.toJson()]);
                  // formKey.currentState!.reset();
                     firstNameController.clear();
                  lastNameController.clear();
                  addressController.clear();
                  areaController.clear();
                  landlineController.clear();
                  mobileController.clear();
                  mobileController.clear();
                  }
                  // selectImage();
                  // final user ={
                  //   UserModel.id:1,
                  //   UserModel.firstName:'Abdelrahman',
                  //   UserModel.lastName:'Ahmed',
                  //   UserModel.address:'Cairo',
                  //   UserModel.area:'Giza',
                  //   UserModel.landline:'2584045',
                  //   UserModel.mobile:'01010973536',
                  //   UserModel.nationalId:'25266975',
                  // };
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
