import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramit_das/screen/shapeCrop.dart';


// ignore: must_be_immutable
class home extends StatefulWidget {
  File? CroppedImg;
  home({super.key, required this.CroppedImg});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  File? _image;
  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        if (img != null) {
          showDialog(
              context: context, builder: (context) => ShapeCrop(img: _image));
        }
      });
    } on PlatformException{
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit Your Image',
          toolbarColor: const Color.fromARGB(255, 57, 56, 56),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ]);
    if (croppedImage == null) {
      if (!mounted) {
        return null;
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => home(
                    CroppedImg: null,
                  )));
      return null;
    }
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Image / Icon",
          style: GoogleFonts.bitter(
              fontStyle: FontStyle.italic, color: Colors.grey.shade600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 68, 67, 67),
            )),
        elevation: 3,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: w,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1.3)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Upload image",
                      style: GoogleFonts.bitter(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 14),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 26, 97, 86),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: _pickImage,
                        child: const Text("Choose from Device",
                            style: TextStyle(fontWeight: FontWeight.w200))),
                  ),
                ],
              ),
            ),
            if (widget.CroppedImg != null)
              SizedBox(
                width: w / 1.2,
                child: Image.file(
                  widget.CroppedImg!,
                  fit: BoxFit.fitWidth,
                ),
              )
          ],
        ),
      ),
    );
  }
}
