import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}
enum FormType {
  login,
  register
}
class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  final _formKey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    else {
      print('Form is invalid');
      return false;
    }
  }
  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: ${userId}');
        }
        else {
         String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered User: ${userId}');
        }
        widget.onSignedIn();
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }
  void moveToRegister() {
    clearForm();
    setState(() {
      _formType = FormType.register;
    });

  }
  void moveToLogin() {
    clearForm();
    setState(() {
      _formType = FormType.login;
    });
  }
  void clearForm() {
    _formKey.currentState.reset();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('Flutter login demo')
        ),
        body: new Container(
            child: new Form(
              key: _formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons()
              )
            )
        )
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.toString().trim(),
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
      )
    ];
  }
  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize:20.0)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        )
      ];
    }
    else {
      return [
        new RaisedButton(
          child: new Text('Create an Account', style: new TextStyle(fontSize:20.0)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Have an account? Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        )
      ];
    }

  }
}
