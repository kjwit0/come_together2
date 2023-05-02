import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _pwTextController = TextEditingController();
  final _form_key = GlobalKey<FormState>();
  String user_id = '';
  String user_password = '';

  void _tryValidation() {
    final isValid = _form_key.currentState!.validate();
    if (isValid) {
      _form_key.currentState!.save();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _idTextController.dispose();
    _pwTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 320,
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
        child: Form(
          key: _form_key,
          child: Column(children: [
            Row(
              children: [
                const Text(
                  'ID   :  ',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: TextFormField(
                    key: const ValueKey(1),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return '4글자 이상 입력해주세요!!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user_id = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'ID를 입력하세요',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              const Text(
                'PW : ',
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: TextFormField(
                  key: const ValueKey(2),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return '4글자 이상 입력해주세요!!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user_password = value!;
                  },
                  controller: _pwTextController,
                  decoration: const InputDecoration(
                    hintText: 'PW를 입력하세요',
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              OutlinedButton(
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
              ),
              OutlinedButton(
                child: const Text('로그인', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  _tryValidation();
                },
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
