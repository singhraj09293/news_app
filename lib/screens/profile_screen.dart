import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/screens/leadings/saved_article.dart';
import 'package:news_app/screens/leadings/setting.dart';
import 'package:news_app/screens/login/book_mark.dart';

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
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Center(
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    child: Text(
                      user.displayName![0],
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: MediaQuery.of(context).size.height - 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.displayName!,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    SizedBox(height: 8),
                    Text(
                      user.email!,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Saved Articles'),
                            leading: Icon(
                              Icons.bookmark,
                              color: Colors.blueAccent,
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookMark(),
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Setting'),
                            leading: Icon(
                              Icons.settings,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              print('settinh');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Setting()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 200),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.all(15),
                        fixedSize: Size(350, 55),
                      ),
                      onPressed: () => signout(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'SignOut',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
