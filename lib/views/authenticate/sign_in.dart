import 'package:flutter/material.dart';
import 'package:zzeater/services/auth.dart';
import 'package:zzeater/services/style/style.dart';
import 'package:zzeater/shared/loading.dart';
import 'package:zzeater/views/authenticate/register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 90.0,
                      ),
                      Text("ZZEater", style: TextStyle(fontSize: 23.0)),
                      SizedBox(height: 100.0),
                      Text(error,
                          style:
                              (TextStyle(color: Colors.red, fontSize: 14.0))),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Digite seu email' : null,
                        decoration: InputDecoration(
                            errorStyle: ThemeText.errorStyle,
                            labelText: 'Email',
                            contentPadding: const EdgeInsets.only(bottom: 4.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[800]),
                            ),
                            focusColor: Colors.green),
                        style: ThemeText.defaultStyle,
                        cursorColor: Colors.red[800],
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 9.0),
                      TextFormField(
                        obscureText: true,
                        validator: (val) =>
                            val.isEmpty ? 'Digite sua senha' : null,
                        decoration: InputDecoration(
                            errorStyle: ThemeText.errorStyle,
                            labelText: 'Senha',
                            contentPadding: const EdgeInsets.only(bottom: 4.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[800]),
                            )),
                        cursorColor: Colors.red[800],
                        style: ThemeText.defaultStyle,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() {
                                  error = 'Email ou senha incorretos.';
                                  loading = false;
                                });
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: ThemeText.myGradient,
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 150.0, maxHeight: 36),
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: ThemeText.buttonStyle1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return new Register();
                          }));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 150.0, maxHeight: 36),
                          alignment: Alignment.center,
                          child: Text(
                            "Registrar",
                            textAlign: TextAlign.center,
                            style: ThemeText.buttonStyle2,
                          ),
                        ),
                        color: Colors.white,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
