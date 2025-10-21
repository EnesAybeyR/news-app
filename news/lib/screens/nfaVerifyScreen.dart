// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/provider/authProvider.dart';
import 'package:news/screens/profile_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Nfaverifyscreen extends ConsumerStatefulWidget {
  const Nfaverifyscreen({
    required this.username,
    required this.password,
    super.key,
  });
  final String username;
  final String password;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NfaverifyscreenState();
}

class _NfaverifyscreenState extends ConsumerState<Nfaverifyscreen> {
  final TextEditingController verifyController = TextEditingController();
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 238, 242),
      appBar: AppBar(title: Text("Verify"), centerTitle: true),
      body: Container(
        child: Column(
          children: [
            const Text(
              "Enter the 6 digit code sent to your email address",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 5) {
                    return "Please fill in the code";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.purple,
                  selectedColor: Colors.blueGrey,
                  selectedFillColor: Colors.white,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: verifyController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
                onCompleted: (v) async {
                  try {
                    final x = await ref
                        .read(authProviderNotifier.notifier)
                        .nfaLogin(
                          ref,
                          widget.username,
                          widget.password,
                          currentText,
                        );
                    if (x == true) {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    throw Exception(e);
                  }
                },
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
            ),
            Row(
              children: [
                const Text("Didn’t get any email?"),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend code",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
