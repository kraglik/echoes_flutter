import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {

  AuthButton({
    Key key,
    this.loading,
    this.error,
    this.onTap,
    this.text
  }): super(key: key);

  final bool loading;
  final bool error;

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 60
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
              child: FlatButton(
                onPressed: loading ? null : onTap,
                child: new Text(
                  text,
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.black)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
