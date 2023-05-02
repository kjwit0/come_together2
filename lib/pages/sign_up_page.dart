import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var _idTextController;
    var _pwTextController;
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 200,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: const Color.fromARGB(117, 0, 0, 0),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0) // POINT
                ),
          ),
          child: GestureDetector(
            //onTap: FocusScope.of(context).unfocus(),
            child: Stack(children: [
              Positioned(
                child: TextFormField(
                  controller: _idTextController,
                  decoration: const InputDecoration(
                    hintText: 'ID를 입력하세요',
                  ),
                ),
              ),
              Positioned(
                child: TextFormField(
                  controller: _pwTextController,
                  decoration: const InputDecoration(
                    hintText: 'PW를 입력하세요',
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
