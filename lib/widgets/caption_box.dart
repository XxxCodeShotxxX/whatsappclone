import 'package:flutter/material.dart';

class CaptionBox extends StatelessWidget {
  const CaptionBox({
    super.key, this.onTap, required this.controller,
  });
  final Function()? onTap;
  final TextEditingController controller ;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.black38,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          maxLines: 6,
          textAlignVertical: TextAlignVertical.center,
          minLines: 1,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Add Caption....",
              prefixIcon: const Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 27,
              ),
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.tealAccent[700],
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
