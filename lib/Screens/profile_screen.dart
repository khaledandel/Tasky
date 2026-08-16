import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/Screens/user_details_screen.dart';
import 'package:tasky/Screens/welcome_screen.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/themes/theme_controlar.dart';
import 'package:tasky/core/widgts/custam_svg_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? motivationQuote;
  String? userImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadMotivationQuote();
    _laodUserImage();
  }

  void _loadUserName() async {
    setState(() {
      username = PreferanceManager().getString('username');
    });
  }

  void _loadMotivationQuote() async {
    setState(() {
      motivationQuote = PreferanceManager().getString('motivation_quote');
    });
  }

  void _laodUserImage() {
    setState(() {
      userImagePath = PreferanceManager().getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('My Profile', style: Theme.of(context).textTheme.labelSmall),
            SizedBox(height: 18),

            Column(
              children: [
                Center(
                  child: Stack(
                    alignment: .bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/images/Avatar.png')
                            : FileImage(File(userImagePath!)),

                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),

                      GestureDetector(
                        onTap: () async {
                          showImageSourceDaialog(context, (XFile file) {
                            _saveImagePath(file);
                            setState(() {
                              userImagePath = file.path;
                            });
                          });
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),

                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),
                Text(
                  '$username',
                  style: Theme.of(context).textTheme.labelSmall,
                ),

                Text(
                  motivationQuote == null
                      ? 'One task at a time. One step closer.'
                      : '$motivationQuote',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                SizedBox(height: 24),
              ],
            ),

            Text('Profile Info', style: Theme.of(context).textTheme.labelSmall),

            ListTile(
              onTap: () async {
                bool? resualt = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UserDetailsScreen(
                        UserName: '$username',
                        motivationQuote: motivationQuote == null
                            ? 'One task at a time. One step closer.'
                            : '$motivationQuote',
                      );
                    },
                  ),
                );
                if (resualt != null && resualt) {
                  _loadUserName();
                  _loadMotivationQuote();
                }
              },
              leading: CustamSvgWidget(path: 'assets/images/profile.svg'),
              title: Text('User Details'),
              trailing: Icon(Icons.arrow_forward),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16),
              child: Divider(),
            ),

            ListTile(
              leading: CustamSvgWidget(path: 'assets/images/light.svg'),
              title: Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              trailing: ValueListenableBuilder(
                valueListenable: ThemeControlar.themeNotifier,
                builder: (BuildContext context, value, Widget? child) {
                  return Switch(
                    value: ThemeControlar.themeNotifier.value == .dark,
                    onChanged: (bool value) {
                      ThemeControlar.toggleTheme();
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16),
              child: Divider(),
            ),

            ListTile(
              onTap: () async {
                PreferanceManager().remove('username');
                // PreferanceManager().remove('tasks');
                PreferanceManager().remove('motivation_quote');

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Welcome_Screen();
                    },
                  ),
                  (Route route) => false,
                );
              },

              title: Text(
                'Log Out',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              leading: CustamSvgWidget(path: 'assets/images/logOutIcon.svg'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  void showImageSourceDaialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Chosse Image Source',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);

                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 12),
                  Text('Camera'),
                ],
              ),
            ),

            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);

                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 12),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImagePath(XFile file) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    print(file.name);
    final newFile = await File(
      file.path,
    ).copy('${appDirectory.path}/${file.name}');
    PreferanceManager().setString('user_image', newFile.path);
  }
}
