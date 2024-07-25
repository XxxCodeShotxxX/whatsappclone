import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/index_controller.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';
import 'package:whatsappclone/screens/home.dart'; // Import the controller


class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tokenController = TextEditingController();

    return  Scaffold(
      body:

      Column(
        children: [
          Center(
            child:  TextField(
            controller:tokenController ,
              
            ),
          ),
          TextButton(onPressed: ()async{
              await   SharedprefHandler().writeString(SharedPrefKeys.authToken,tokenController.text);
          Get.to(()=>HomeScreen());
          }, child: Text("Login")),
        ],
      ));
        
       
      
    
  }
}
