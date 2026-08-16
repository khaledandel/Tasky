import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgts/custam_svg_widget.dart';
import 'package:tasky/core/widgts/custam_text_form_filed.dart';
import 'package:tasky/Screens/main_screen.dart';

class Welcome_Screen extends StatelessWidget {
  Welcome_Screen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: .center,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    CustamSvgWidget.WithoutColorFilter(
                      path: 'assets/images/logo.svg',
                    ),
                    SizedBox(width: 16, height: 9),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: .center,
                    ),
                  ],
                ),
                SizedBox(height: 160),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 16),
                    CustamSvgWidget.WithoutColorFilter(
                      path: 'assets/images/wavingHand.svg',
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Your productivity journey starts here.",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 24),
                CustamSvgWidget.WithoutColorFilter(
                  path: 'assets/images/pana.svg',
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustamTextFormFiled(
                    controllar: controller,
                    hintText: 'e.g. Sarah Khalid',
                    title: 'Full Name',
                    validator: (String? value) {
                      if (value?.isEmpty ?? false) {
                        return "Please Enter Your Full Name";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        await PreferanceManager().setString(
                          'username',
                          controller.text,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainScreen();
                            },
                          ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF15B86C),
                      foregroundColor: Color(0xFFFFFCFC),
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    child: Text("Let’s Get Started"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
