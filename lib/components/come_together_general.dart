import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

// ignore: must_be_immutable
class UserInfoInputForm extends StatefulWidget {
  UserInfoInputForm({
    super.key,
    required this.columText,
    this.obscureText,
    required this.validatorText,
    required this.textHint,
    required this.dataValue,
    required this.keyIndex,
    this.minLength,
    this.maxLength,
  });

  String columText;
  String validatorText;
  String textHint;
  bool? obscureText;
  int keyIndex;
  int? minLength;
  int? maxLength;

  final ValueSetter<String> dataValue;

  @override
  State<UserInfoInputForm> createState() => _UserInfoInputFormState();
}

class _UserInfoInputFormState extends State<UserInfoInputForm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.columText,
          style: const TextStyle(fontSize: 20),
        ),
        Expanded(
          child: TextFormField(
            key: ValueKey(widget.keyIndex),
            obscureText: widget.obscureText ?? false,
            maxLength: widget.maxLength ?? 20,
            validator: (value) {
              if (value!.isEmpty || value.length < (widget.minLength ?? 1)) {
                return widget.validatorText;
              }
              return null;
            },
            onSaved: (value) {
              widget.dataValue(value!);
            },
            decoration: InputDecoration(
              hintText: widget.textHint,
            ),
          ),
        ),
      ],
    );
  }
}
