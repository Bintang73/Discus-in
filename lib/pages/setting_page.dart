// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stalkin/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  bool isSnackbarShown = false;
  bool _isLoading = false;

  // user data
  final currentUser = FirebaseAuth.instance.currentUser!;

  final ImagePicker _imagePicker = ImagePicker();
  late String _selectedImagePath = "nothing";

  // edit user
  Future<void> editField(String field, String newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .update({field: newValue});

      if (!isSnackbarShown) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // Cek apakah Snackbar sudah ditampilkan sebelumnya
        isSnackbarShown = true; // Set flag menjadi true
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil Diubah',
              style: semiPoppins,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: semiPoppins,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _openImagePicker() async {
    bool storagePermissionGranted = await requestStoragePermission();

    if (storagePermissionGranted) {
      // Permission granted, proceed with opening the image picker
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });
      }
    } else {
      // Permission not granted, handle accordingly (show message, navigate to settings, etc.)
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Storage Permission Required'),
            content:
                Text('Please grant storage permission to select an image.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String?> _uploadImageToFirebase(String imagePath) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('discusin-image/$imageName');
      UploadTask uploadTask = ref.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // Handle any errors that occur during the upload.
      return null;
    }
  }

  Future<void> _uploadImage() async {
    // ignore: unnecessary_null_comparison
    try {
      if (_selectedImagePath == "nothing") {
        // No image selected. Handle this scenario.
        return;
      } else {
        setState(() {
          _isLoading = true;
        });
        String? imageUrl = await _uploadImageToFirebase(_selectedImagePath);
        if (imageUrl != null) {
          // Image uploaded successfully. Handle the URL as needed.
          editField('urlProfile', imageUrl);
          // ignore: avoid_print
          print('Image URL: $imageUrl');
          setState(() {
            _isLoading = false;
          });
        } else {
          // Error occurred during image upload. Handle the error.
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            elevation: 2,
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            toolbarHeight: 70,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Setting',
                        style: semiPoppins.copyWith(
                          fontSize: 24,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>? ?? {};
                      _name.text = userData['name'] ?? '';
                      _bio.text = userData['bio'] ?? '';
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        padding: const EdgeInsets.only(top: 46),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 26),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: _selectedImagePath != "nothing"
                                        ? Image.file(
                                            File(_selectedImagePath),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            userData['urlProfile'] ?? '',
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  if (_isLoading)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ), // Adjust the opacity as needed
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    top: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: whiteColor,
                                      onPressed: _openImagePicker,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _name,
                                style: regularPoppins.copyWith(fontSize: 14),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: secondaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Name',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              height: 200,
                              width: double.infinity,
                              child: TextField(
                                controller: _bio,
                                textAlignVertical: TextAlignVertical.top,
                                expands: true,
                                maxLines: null,
                                style: regularPoppins.copyWith(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'Bio',
                                  filled: true,
                                  fillColor: whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: secondaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _uploadImage();
                                  editField('name', _name.text);
                                  editField('bio', _bio.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Ubah',
                                  style: semiPoppins.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error ${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
