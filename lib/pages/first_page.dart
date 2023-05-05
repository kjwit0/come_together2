import 'package:come_together2/components/come_together_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[300],
          appBar: AppBar(
            leading: const CloseButton(),
          ),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(color: Colors.green[300]),
                  child: Column(children: [
                    Center(
                      child: Text(
                        'Come Together',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text('Login with'),
                    TextButton.icon(
                      onPressed: () async {
                        await signInWithGoogle();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: CometogetherColors.textPrimaryColor,
                        minimumSize: const Size(155, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.blueGrey[600],
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Google'),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
