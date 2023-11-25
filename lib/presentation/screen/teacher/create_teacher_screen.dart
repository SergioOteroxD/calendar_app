import 'package:calendar_app/infrastructure/model/teacher_model.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/repositories/teacher_repository_impl.dart';

class CreateTeacherScreen extends StatelessWidget {
  static const name = "create_teach";
  const CreateTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adñadir Profe'),
      ),
      body: const FormCreateTeacher(),
    );
  }
}

class FormCreateTeacher extends StatefulWidget {
  const FormCreateTeacher({super.key});

  @override
  State<FormCreateTeacher> createState() => _FormCreateTeacherState();
}

class _FormCreateTeacherState extends State<FormCreateTeacher> {
  final teacherRepo = TeacherRepositoryImpl();
  final _formKey = GlobalKey<FormState>();
  final nameTeacherController = TextEditingController();
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<TeacherModel> teachers = [];

  @override
  void initState() {
    super.initState();
    teacherRepo.getAll().then((value) {
      setState(() {
        teachers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: nameTeacherController,
              maxLength: 100,
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
            ElevatedButton(
              onPressed: () async {
                _formKey.currentState?.save();
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  final name = nameTeacherController.text;
                  TeacherModel teacher = TeacherModel(name: name);
                  final id = await teacherRepo.insert(teacher);
                  teacher = teacher.copyWith(id: id);
                  nameTeacherController.clear();
                  setState(() {
                    teachers.add(teacher);
                  });

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profesor creado correctamente.')),
                  );
                }
              },
              child: const Text('Crear'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final teacher = teachers[index];
                return ListTile(
                  leading: Text('${teacher.id}'),
                  title: Text(teacher.name),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
