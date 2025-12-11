import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news/provider/authProvider.dart';
import 'package:news/provider/nfaProvider.dart';
import 'package:news/provider/sign_provider.dart';
import 'package:news/screens/SetMfaScreen.dart';
import 'package:news/screens/bookmarks_screen.dart';
import 'package:news/screens/nfaVerifyScreen.dart';
import 'package:news/widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static ProfileScreen builder(BuildContext context, GoRouterState state) =>
      ProfileScreen();
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool state = ref.watch(signProvider);
    void stateChange() {
      ref.read(signProvider.notifier).state = !state;
    }

    final auth = ref.watch(authProviderNotifier);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 238, 242),
      bottomNavigationBar: CustomBottomNavBar(),
      body: auth.when(
        data: (data) {
          if (data.isLogged == true) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text('Profile', style: TextStyle(fontSize: 22)),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setmfascreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 12),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Set MFA', style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 12),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change Password',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookmarksScreen(),
                        ),
                      ),
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 12),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bookmarks', style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        ref.read(authProviderNotifier.notifier).logout();
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 12),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Log out', style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return state == true
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Welcome back!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Form(
                              key: _loginFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 84, 84),
                                    ),
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter username';
                                      }
                                      return null;
                                    },
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 84, 84),
                                    ),
                                    controller: passController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_loginFormKey.currentState!
                                            .validate()) {
                                          final x = await ref
                                              .read(nfaProvider.notifier)
                                              .fetchNfa(
                                                ref,
                                                usernameController.text,
                                              );

                                          if (x == true) {
                                            if (context.mounted) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Nfaverifyscreen(
                                                        username:
                                                            usernameController
                                                                .text,
                                                        password:
                                                            passController.text,
                                                      ),
                                                ),
                                              );
                                            }
                                          } else {
                                            ref
                                                .read(
                                                  authProviderNotifier.notifier,
                                                )
                                                .login(
                                                  ref,
                                                  usernameController.text,
                                                  passController.text,
                                                );
                                            usernameController.text = "";
                                            passController.text = "";
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(500, 34),
                                      ),
                                      child: const Text(
                                        "Sign In",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextButton(
                              onPressed: () {
                                stateChange();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              child: const Text(
                                "Don't have an account? Sign Up",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Sign up to create account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Form(
                              key: _signupFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 84, 84),
                                    ),
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a username';
                                      }

                                      return null;
                                    },
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 84, 84),
                                    ),
                                    controller: passController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      } else if (value.length < 8) {
                                        return 'Minimum length is 8';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_signupFormKey.currentState!
                                            .validate()) {
                                          ref
                                              .read(
                                                authProviderNotifier.notifier,
                                              )
                                              .register(
                                                ref,
                                                usernameController.text,
                                                passController.text,
                                              );
                                          usernameController.text = "";
                                          passController.text = "";
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(500, 34),
                                      ),
                                      child: const Text(
                                        "Create account",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextButton(
                              onPressed: () {
                                stateChange();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              child: const Text(
                                "Already have an account? Sign in",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }
        },
        error: (error, stack) => Center(child: Text('Error: $error 21')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
