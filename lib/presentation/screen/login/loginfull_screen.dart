import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../dominio/home_param.model.dart';

class LoginFullScreen extends StatefulWidget {
  static const String name = 'home_screen';
  const LoginFullScreen({super.key});

  @override
  State<LoginFullScreen> createState() => _LoginFullScreenState();
}

class _LoginFullScreenState extends State<LoginFullScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar App'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Ingresa tu usuario',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un valor';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: passController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Ingresa tu password',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un valor';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.save();
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Procesando información')),
                      );
                      // final HomeParamModel homeParamModel = HomeParamModel(name: formData?._fields['name'], age: formData?.fields['name']);
                      if (emailController.text != 'domingo') {
                       return showSnackBar(context,'Credenciales incorrectas');
                      }
                      if (passController.text != 'domingo12345') {
                       return showSnackBar(context,'Credenciales incorrectas');
                      }
                      context.push('/home',
                          extra: HomeParamModel(password: passController.text, email: emailController.text));
                    }
                  },
                  child: const Text('Ingresar'),
                ),
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          ),
        ));
  }
}
