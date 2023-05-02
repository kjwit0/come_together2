import 'package:come_together2/components/come_together_colors.dart';
import 'package:flutter/material.dart';
import '../components/come_together_general.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[300],
          appBar: AppBar(
            leading: const CloseButton(),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(color: Colors.green[300]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Come Together',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 40),
                      const LoginForm(),
                      const SizedBox(height: 40),
                      Positioned(
                        top: MediaQuery.of(context).size.height - 125,
                        child: Column(children: [
                          const Text('Sign up with'),
                          TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  CometogetherColors.textPrimaryColor,
                              minimumSize: const Size(155, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.blue,
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text('Google'),
                          ),
                        ]),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
