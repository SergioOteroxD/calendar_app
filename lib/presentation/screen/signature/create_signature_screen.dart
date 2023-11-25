import 'package:calendar_app/infrastructure/model/signature_model.dart';
import 'package:calendar_app/infrastructure/repositories/signature_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/model/teacher_model.dart';
import '../../../infrastructure/repositories/teacher_repository_impl.dart';

class CreateSignatureScreen extends StatelessWidget {
  static const name = "create_signature";
  const CreateSignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adñadir materia'),
      ),
      body: const _FormSinatureScreen(),
    );
  }
}

class _FormSinatureScreen extends StatefulWidget {
  const _FormSinatureScreen();

  @override
  State<_FormSinatureScreen> createState() => _FormSinatureScreenState();
}

class _FormSinatureScreenState extends State<_FormSinatureScreen> {
  final teacherRepo = TeacherRepositoryImpl();
  final signatureRepo = SignatureRepositoryImpl();
  final _formKey = GlobalKey<FormState>();
  final nameSignatureController = TextEditingController();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<TeacherModel> teachers = [];
  List<SignatureModel> sigantures = [];
  TeacherModel dropdownValue  = TeacherModel(name: "name");
  @override
  void initState() {
    super.initState();
    signatureRepo.getAll().then((value) {
      setState(() {
        sigantures = value;
      });
    });
    teacherRepo.getAll().then((value) {
      setState(() {
        teachers = value;
        dropdownValue = value.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: nameSignatureController,
            maxLength: 100,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nombre',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa un valor';
              }
              return null;
            },
          ),
          DropdownButton<TeacherModel>(
            value: dropdownValue,
            items: teachers.map<DropdownMenuItem<TeacherModel>>((e) {
              return DropdownMenuItem(value: e, child: Text(e.name));
            }).toList(),
            onChanged: (TeacherModel? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              _formKey.currentState?.save();
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                if(teachers.isEmpty){
                showSnackBar(context, 'Primero adñade profesores...');
                return;

                }
                final name = nameSignatureController.text;
                nameSignatureController.clear();

                SignatureModel siganture = SignatureModel(name: name, teacherId: dropdownValue.id);
                final id = await signatureRepo.insert(siganture);
                siganture = siganture.copyWith(id: id);

                setState(() {
                  sigantures.add(siganture);
                });

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Materia creada correctamente.')),
                );
              }
            },
            child: const Text('Crear'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: sigantures.length,
            itemBuilder: (context, index) {
              final signature = sigantures[index];
              return ListTile(
                leading: Text('${signature.id}'),
                title: Text(signature.name),
              );
            },
          )
        ],
      ),
    );
  }
}
