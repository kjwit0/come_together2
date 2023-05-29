import 'package:come_together2/components/come_together_colors.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
                    await UserController.to.signInWithGoogle();
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
    );
  }
}
