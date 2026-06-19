import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController newName = TextEditingController();
  ImagePicker picker = ImagePicker();
  updateName() async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(newName.text);
    setState(() {});
  }

  pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final dio = Dio();
      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/dcvhz97f6/image/upload',
        data: FormData.fromMap({
          'upload_preset': 'tt9oy8gt',
          'file': await MultipartFile.fromFile(image.path),
        }),
      );
      final url = response.data['secure_url'];
      print('URL: $url');
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFF222222),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Update Name'),
                          content: TextField(controller: newName),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                updateName();
                                Navigator.pop(context);
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                    title: Text(
                      'Update Name',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(Icons.person, color: Color(0xFFE63946)),
                  ),

                  Divider(color: Color(0xFF333333)),
                  ListTile(
                    onTap: () {
                      pickImage();
                    },
                    title: Text(
                      'Update Photo',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(Icons.camera_alt, color: Color(0xFFE63946)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'About',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFF222222),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'App version',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(Icons.info, color: Color(0xFFE63946)),
                    trailing: Text(
                      '1.0.0',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Divider(color: Color(0xFF333333)),
                  ListTile(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Coming Soon!',
                            style: TextStyle(color: Color(0xFFE63946)),
                          ),
                          backgroundColor: Color(0xFF222222),
                        ),
                      );
                    },
                    title: Text(
                      'Privacy',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(Icons.privacy_tip, color: Color(0xFFE63946)),
                  ),
                  Divider(color: Color(0xFF333333)),
                  ListTile(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Coming Soon!',
                            style: TextStyle(color: Color(0xFFE63946)),
                          ),
                          backgroundColor: Color(0xFF222222),
                        ),
                      );
                    },
                    title: Text('Help', style: TextStyle(color: Colors.white)),
                    leading: Icon(Icons.help, color: Color(0xFFE63946)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
