import 'package:flutter/material.dart';


class AuthInputField extends StatelessWidget {

  AuthInputField({

    Key key,
    this.label,
    this.fieldKey,
    this.onChanged,
    this.obscure,
    this.autocorrect

  }): super(key: key);

  final String label;
  final String fieldKey;
  final Function onChanged;
  final bool obscure;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
      child: TextFormField(
          obscureText: obscure,
          maxLines: 1,
          cursorColor: Colors.black,
          cursorWidth: 1,
          autocorrect: autocorrect,
          onChanged: onChanged,
          key: Key(fieldKey),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5.0),
            fillColor: Colors.grey[200],
            labelText: label,
          )
      ),
    );
  }

}
