// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/Repository/auth_repository.dart';

import 'package:news/provider/nfaProvider.dart';
import 'package:news/screens/profile_screen.dart';

class Setmfascreen extends ConsumerStatefulWidget {
  const Setmfascreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetmfascreenState();
}

class _SetmfascreenState extends ConsumerState<Setmfascreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nfaProvider.notifier).fetchNfaWithId(ref);
    });
  }

  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nfa = ref.watch(nfaProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Set MFA"), centerTitle: true),
      body: Container(
        child: nfa.when(
          data: (data) {
            if (data == true) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You already have mfa but if you want to you can change your e-mail address down below.',
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 193, 41, 41),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 36),
                        child: Text(
                          "New E-mail",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 85, 84, 84),
                          ),
                          controller: newEmailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains("@") ||
                                !value.contains(".")) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 36),
                        child: Text("Password", style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 85, 84, 84),
                          ),
                          controller: passController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),

                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 100,
                          right: 100,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final val = await AuthRepository(ref).changeEmail(
                                context,
                                newEmailController.text,
                                passController.text,
                              );
                              if (val == true) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Email has changed."),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileScreen(),
                                    ),
                                  );
                                }
                              } else if (val == false) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Password is wrong or email has user already.",
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("error"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(500, 34),
                          ),
                          child: const Text(
                            "Change Email",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 36),
                        child: Text("E-mail", style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 85, 84, 84),
                          ),
                          controller: newEmailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains("@") ||
                                !value.contains(".")) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 36),
                        child: Text("Password", style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 85, 84, 84),
                          ),
                          controller: passController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),

                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 100,
                          right: 100,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final val = await AuthRepository(ref).changeEmail(
                                context,
                                newEmailController.text,
                                passController.text,
                              );
                              if (val == true) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Mfa set"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileScreen(),
                                    ),
                                  );
                                }
                              } else if (val == false) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Password is wrong or email has user already.",
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("error"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(500, 34),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          error: (error, stack) => Center(child: Text('Error: $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
