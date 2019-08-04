import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'auth.dart';
import 'college_list_page.dart';
class RootPage extends StatefulWidget {
  @override
  RootPage({this.auth});
  final BaseAuth auth;
  State<StatefulWidget> createState() => new _RootPageState();

}
enum AuthStatus {
  notSignedIn,
  signedIn
}
class _RootPageState extends State<RootPage> {
  @override
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  Widget build(BuildContext context) {
    // TODO: implement build
    switch(_authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,);
      case AuthStatus.signedIn:
        return new CollegeListPage();
    }
  }
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }
  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }
}
