import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

import '../../widgets/caption_box.dart';


 


class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.image,required this.onSendImage, required this.pop});
  final XFile image;
final Function? onSendImage;
final int pop;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.title,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.edit,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: Stack(children: [
        Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.file(
            File(image.path),
            fit: BoxFit.contain,
          ),
        ),
        CaptionBox(
          onTap: (){

            try {

              log(image.name);

              onSendImage!(context,image,pop);
            } catch (e) {
              log(e.toString());
            }

           
          },
        )
      ]),
    );
  }




}
