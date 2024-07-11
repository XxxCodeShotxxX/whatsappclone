import 'package:flutter/material.dart';
import 'package:whatsappclone/handlers/network_handler.dart';
import 'package:whatsappclone/models/user_model.dart';
import 'package:whatsappclone/screens/home.dart';
import 'package:whatsappclone/widgets/contact_tile.dart';
  late Future<List<User>> futureUsers;
  late List<User> userxs;
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  void initState() {
    super.initState();
        NetworkHandler networkHandler = NetworkHandler();
  futureUsers = networkHandler.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder:(BuildContext context, AsyncSnapshot<List<User>> snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
         userxs = snapshot.data!;
          return ListView.builder(
            itemCount: userxs.length,
            itemBuilder: (BuildContext context, int index) {
              return ContactTile(
                user: userxs[index],
                selectable: false,
                onTap: () {
                  User currentUser = userxs.removeAt(index);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> HomeScreen(
                    users : userxs,
                    currentUser : currentUser,
                  )));
                },
              );
            });}}
      ),
    );
  }
}
