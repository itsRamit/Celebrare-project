
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramit_das/Utils/Utils.dart';
import 'package:ramit_das/screen/home.dart';

// ignore: must_be_immutable
class ShapeCrop extends StatefulWidget {
  File? img;
  ShapeCrop({super.key, required this.img});

  @override
  State<ShapeCrop> createState() => _ShapeCropState();
}

class _ShapeCropState extends State<ShapeCrop> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    List<Widget> buttons = List.generate(paths.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 3),
        child: InkWell(
          onTap: () {
            setState(() {
              idx = index;
            });
          },
          child: Container(
              width: w / 9,
              height: w / 9,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: index != 0
                  ? Center(
                      child: Image.asset(
                        paths[index],
                        fit: BoxFit.contain,
                      ),
                    )
                  : Center(
                      child: Text(
                        paths[index],
                        style: TextStyle(color: Colors.grey, fontSize: w / 40),
                      ),
                    )),
        ),
      );
    });

    return Center(
        child: AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      content: SizedBox(
        width: w / 2,
        height: h / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.grey), // Set background color here
                    ),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
            Text(
              "Upload image",
              style: GoogleFonts.bitter(
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(
              height: h / 40,
            ),
            Container(
                height: h / 4,
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      widget.img!,
                      fit: BoxFit.fitWidth,
                    ),
                    if (idx != 0)
                      Image.asset(
                        paths[idx],
                        fit: BoxFit.fitWidth,
                        height: h / 4,
                        // width: h / 2.2,
                        // colorBlendMode: BlendMode.overlay,
                        color: Colors.white,
                      )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => home(
                              CroppedImg: widget
                                  .img))); // returning the same image file because resorces are not available
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 26, 97, 86),
                  minimumSize: Size(w / 1.2, 45),
                ),
                child: const Text(
                  "Use this image",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    ));
  }
}
