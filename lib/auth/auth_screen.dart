import 'dart:io';
import 'dart:math';
import 'package:finall_shop/providers/auth_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //final transfromConfig = Matrix4.rotationZ(-8 * pi / 180);
    /// transfromConfig.translate(-10.0);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                //  gradient:
                ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade700,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.grey.shade500,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Text(
                      'Myshop',
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal),
                    ),
                  )),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  AnimationController _controller;
  Animation<Size> _heigthAnime;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _heigthAnime = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 400))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
    _heigthAnime.addListener(() {
      setState(() {});
    });
    @override
    // ignore: unused_element
    void dispose() {
      super.dispose();
      _controller.dispose();
    }
  }

  var _isLoading = false;
  final _passwordController = TextEditingController();
  void _showDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Something went wrong'),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  void submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth_data>(context, listen: false)
            .login(_authData['email'], _authData['password']);
        //
      } else {
        await Provider.of<Auth_data>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
        setState(() {
          _isLoading = false;
        });
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('EMAIL_EXITS')) {
        errorMessage = 'This email is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Please enter a valid Email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Please enter a strong password';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Email not found! Please enter a valid Email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
      }
      _showDialog(errorMessage);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      const errorMessage = 'Could not authenticat you now, Try later';
      _showDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 30.0,
      child: Container(
        height: _heigthAnime.value.height,
        //_authMode == AuthMode.Signup ? 400 : 260,
        constraints: BoxConstraints(
          minHeight: _heigthAnime.value.height,
        ),
        width: devSize.width * 0.75,
        padding: EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = new RegExp(pattern);
                    if (value.length == 0) {
                      return "Email is Required";
                    } else if (!regExp.hasMatch(value)) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) => _authData['email'] = newValue,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.length < 8) {
                      return 'Enter a valid Password';
                    } else
                      return null;
                  },
                  onSaved: (newValue) => _authData['password'] = newValue,
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Password do not match';
                              }
                              return null;
                            }
                          : null),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'Login' : 'SignUp'),
                    onPressed: () => submit(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.blue,
                    textColor: Colors.black38,
                  ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SignUp' : 'Login'} INSTEAD'),
                    onPressed: () => _switchAuthMode(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
