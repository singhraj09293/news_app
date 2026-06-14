import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  signout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user.photoURL != null
                  ? NetworkImage(user.photoURL!)
                  : null,
              child: user.photoURL == null ? Text(user.displayName![0],style: TextStyle(
                fontSize: 35
              ),) : null,
            ),
            SizedBox(height: 20),
            Text(
              user.displayName!,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,
              fontSize: 30),
            ),
            SizedBox(height: 5),
            Text(user.email!, style: TextStyle(color: Colors.grey, fontSize: 22)),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            Row(
  
              children: [
                Icon(Icons.folder,size: 30,),
                SizedBox(width: 20),
                Text('Saved Article', style: TextStyle(color: Colors.black,fontSize: 22)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.settings, color: Colors.grey,size: 25,),
                SizedBox(width: 10),
                Text('Setting', style: TextStyle(color: Colors.black,fontSize: 22)),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.all(12),
                  fixedSize: Size(double.infinity, 55),
                ),
                onPressed: () {
                  signout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,color: Colors.white,size: 20,),
                    SizedBox(width: 10),
                    Text('Logout',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
