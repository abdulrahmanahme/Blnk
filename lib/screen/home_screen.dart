import 'dart:io';

import 'package:blnk/core/component/widget/button_widget.dart';
import 'package:blnk/core/component/widget/text_form_field.dart';
import 'package:blnk/server/google%20_drive_apis.dart';
import 'package:blnk/server/google_sheets_apis.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../core/component/app_constants/app_const.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  String? gitPathImage;
  Future<void> selectImage() async {
    XFile? selectImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    var croppedImage = await cropImage(imageFile: selectImage!);
    if (croppedImage != null) {
      imageFileList.add(croppedImage);
    }
    gitPathImage = selectImage.path;
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
        child: SingleChildScrollView(
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
               InkWell(
                      onTap: () {
                        selectImage().then((value) {
                          GoogleDriveApis.addImageToFolder(
                              gitPathImage!, GoogleDriveApis.getIdFile!);
                        });
                      },
                      child: Text(
                        'Tap to pick an  IMAGE',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: GridView.builder(
                    itemCount: imageFileList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        File(imageFileList[index].path),
                        fit: BoxFit.cover,
                      );
                    }),
              ),
              const SizedBox(
                height: 15,
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
                          area: areaController.text,
                          landline: landlineController.text,
                          mobile: mobileController.text,
                          nationalId: mobileController.text);
                      await UserSheetsApis.insert([user.toJson()]);
                      firstNameController.clear();
                      lastNameController.clear();
                      addressController.clear();
                      areaController.clear();
                      landlineController.clear();
                      mobileController.clear();
                      mobileController.clear();
                      imageFileList.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
