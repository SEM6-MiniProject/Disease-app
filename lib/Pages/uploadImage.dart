import 'dart:io';

import 'package:diseaseapp/Pages/confirmPage.dart';
import 'package:diseaseapp/Pages/prediction.dart';
import 'package:diseaseapp/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadReport extends StatefulWidget {
  const UploadReport({Key? key}) : super(key: key);

  @override
  State<UploadReport> createState() => _UploadReportState();
}

class _UploadReportState extends State<UploadReport> {
  // PlatformFile? selectedFile;
  // final ImagePicker picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);
    print(pickedFile!.name);
    if (pickedFile != null) {
      File _imageFile = File(pickedFile.path);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ConfirmImagePage(imageFile: _imageFile)));
    } else {
      Fluttertoast.showToast(msg: "No file selected");
    }
  }

  Future<void> _pickImageFromGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  Future<void> _takePhoto() async {
    await _pickImage(ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _customBtns(_pickImageFromGallery, Icons.image, "Open Gallery"),
            _customBtns(_takePhoto, Icons.camera, "Take Photo"),
          ],
        ),
      ),
    );
  }

  Widget _customBtns(Function() onPressed, IconData icon, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          shape: const CircleBorder(),
          elevation: 2,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: MyColors.primaryColor,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // void selectFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'jpg', 'png'],
  //   );

  //   if (result != null) {
  //     setState(() {
  //       selectedFile = result.files.single;
  //     });
  //   } else {
  //     Fluttertoast.showToast(msg: "No file selected");
  //   }
  // }
}
