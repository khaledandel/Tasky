import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgts/custam_text_form_filed.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({
    super.key,
    required this.UserName,
    required this.motivationQuote,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController motivationQuoteController =
      TextEditingController();
  final String UserName;
  final String? motivationQuote;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: .circular(20)),
            child: Text('Save Changes', style: TextStyle(fontSize: 20)),
            onPressed: () async {
              if (_key.currentState!.validate()) {
                await PreferanceManager().setString(
                  'username',
                  nameController.text,
                );
                await PreferanceManager().setString(
                  'motivation_quote',
                  motivationQuoteController.text,
                );
                Navigator.of(context).pop(true);
              }
            },
          ),
        ),
      ),
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustamTextFormFiled(
                controllar: nameController,
                hintText: '$UserName',
                title: 'User Name',
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "Enter USer Name";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              CustamTextFormFiled(
                controllar: motivationQuoteController,
                hintText: '$motivationQuote',
                maxLines: 5,
                title: 'Motivation Quote',
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "Enter Motivation Quote";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
