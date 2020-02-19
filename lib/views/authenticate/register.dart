import 'package:flutter/material.dart';
import 'package:zzeater/services/auth.dart';
import 'package:zzeater/services/style/style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String passwordConfirm = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[500],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[500],
        elevation: 0.0,
        title: Center(child: Text('CADASTRO', style: ThemeText.headerStyle)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Digite seu nome' : null,
                  decoration: InputDecoration(
                      errorStyle: ThemeText.errorStyle,
                      //labelStyle: ThemeText.defaultStyle,
                      labelText: 'Nome',
                      contentPadding: const EdgeInsets.only(bottom: 4.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[800]),
                      ),
                      focusColor: Colors.green),
                  style: ThemeText.defaultStyle,
                  cursorColor: Colors.red[800],
                  onChanged: (val) {
                    setState(() => firstName = val);
                  },
                ),
                SizedBox(height: 9.0),
                TextFormField(
                  decoration: InputDecoration(
                      errorStyle: ThemeText.errorStyle,
                      //labelStyle: ThemeText.defaultStyle,
                      labelText: 'Sobrenome',
                      contentPadding: const EdgeInsets.only(bottom: 4.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[800]),
                      )),
                  cursorColor: Colors.red[800],
                  style: ThemeText.defaultStyle,
                  onChanged: (val) {
                    setState(() => lastName = val);
                  },
                ),
                SizedBox(height: 9.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Digite seu email' : null,
                  style: ThemeText.defaultStyle,
                  decoration: InputDecoration(
                      errorStyle: ThemeText.errorStyle,
                      //labelStyle: ThemeText.defaultStyle,
                      labelText: 'Email',
                      contentPadding: const EdgeInsets.only(bottom: 4.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[800]),
                      )),
                  cursorColor: Colors.red[800],
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 9.0),
                TextFormField(
                  validator: (val) => val.length < 6
                      ? 'Sua senha deve possuir mais de 6 caracteres'
                      : null,
                  obscureText: true,
                  decoration: InputDecoration(
                      errorStyle: ThemeText.errorStyle,
                      labelText: 'Senha',
                      contentPadding: const EdgeInsets.only(bottom: 4.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[800]),
                      )),
                  style: ThemeText.defaultStyle,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 9.0),
                TextFormField(
                  obscureText: true,
                  validator: (val) => val != password
                      ? "As senhas fornecidas não coincidem."
                      : null,
                  decoration: InputDecoration(
                      errorStyle: ThemeText.errorStyle,
                      //labelStyle: ThemeText.defaultStyle,
                      labelText: 'Confirme sua senha',
                      contentPadding: const EdgeInsets.only(bottom: 3.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[800]),
                      )),
                  style: ThemeText.defaultStyle,
                  onChanged: (val) {
                    setState(() => passwordConfirm = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.lightBlue[400],
                    child: Text(
                      'Registrar',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          fontFamily: 'NotoSansHK',
                          fontWeight: FontWeight.w800),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                firstName, lastName, email, password);

                        if (result == null) {
                          print('Error.');
                        }
                      }
                    }),
                SizedBox(height: 12.0),
                Text(error,
                    style: (TextStyle(color: Colors.red, fontSize: 14.0)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
