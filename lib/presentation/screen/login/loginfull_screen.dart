import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../dominio/entities/home_param.model.dart';

class LoginFullScreen extends StatefulWidget {
  static const String name = 'login';
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
          title: const Text('Calendario'),
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
                    labelText: 'Usuario',
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
                    labelText: 'Contraseña',
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
                      // final HomeParamModel homeParamModel = HomeParamModel(name: formData?._fields['name'], age: formData?.fields['name']);
                      if (emailController.text != 'domingo') {
                       return showSnackBar(context,'Tu correo es incorrecto!');
                      }
                      if (passController.text != 'domingo12345') {
                       return showSnackBar(context,'tu contraseña es incorrecta!');
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Iniciando sesion.')),
                      );
                      context.push('/home',
                          extra: HomeParamModel(password: passController.text, email: emailController.text));
                    }
                  },
                  child: const Text('Entrar'),
                ),
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          ),
        ));
  }
}
