import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/screens/leadings/setting.dart';
import 'package:news_app/screens/login/book_mark.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  signout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 80,
                    color: Colors.transparent,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Color(0xFFE63946)),
                      child: Center(
                        child: CircleAvatar(
                          radius: 53,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: user.photoURL != null
                                ? NetworkImage(user.photoURL!)
                                : null,
                            radius: 50,
                            child: user.photoURL == null
                                ? Text(
                                    user.displayName![0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                    ),
                                  )
                                : null,
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
                        color: Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              user.displayName!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              user.email!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(0xFF222222),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      title: Text('Saved Articles'),
                                      leading: Icon(
                                        Icons.bookmark,
                                        color: Color(0xFFE63946),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BookMark(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Divider(),
                                    SizedBox(height: 20),
                                    ListTile(
                                      title: Text('Setting'),
                                      leading: Icon(
                                        Icons.settings,
                                        color: Color(0xFFE63946),
                                      ),
                                      onTap: () {
                                        print('settinh');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Setting(),
                                          ),
                                        );
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE63946),
            padding: EdgeInsets.all(15),
            fixedSize: Size(350, 55),
          ),
          onPressed: () => signout(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Colors.white),
              SizedBox(width: 10),
              Text('SignOut', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
