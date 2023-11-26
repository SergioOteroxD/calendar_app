import 'package:calendar_app/dominio/share/util_event.dart';
import 'package:calendar_app/infrastructure/model/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../dominio/share/get_datetime.dart';
import '../../../infrastructure/repositories/lesson_repository_impl.dart';

class CreateLessonScreen extends StatelessWidget {
  static const name = "create_lesson";
  const CreateLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adñadir clase'),
      ),
      body: const _FormSinatureScreen(),
    );
  }
}

class _FormSinatureScreen extends StatefulWidget {
  const _FormSinatureScreen();

  @override
  State<_FormSinatureScreen> createState() => _FormLessonScreenState();
}

class _FormLessonScreenState extends State<_FormSinatureScreen> {
  final lessonRepo = LessonRepositoryImpl();
  final _formKey = GlobalKey<FormState>();
  final nametController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  late DateTime? dateStart;
  late DateTime? dateFinish;

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: nametController,
            maxLength: 200,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Clase',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa un valor';
              }
              return null;
            },
          ),
          ElevatedButton.icon(
            onPressed: () async {
              dateStart = await showDateTimePicker(context: context);
              if (dateStart == null) {
                // ignore: use_build_context_synchronously
                showSnackBar(context, 'Fecha incorrecta');
                return;
              }
            },
            label: const Text('Fecha inicial'),
            icon: const Icon(Icons.calendar_month),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                dateFinish = await showDateTimePicker(context: context, selectedDate: dateStart);
                if (dateFinish == null) {
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, 'Hora incorrecta');
                  return;
                }
              },
              label: const Text('Hora final'),
              icon: const Icon(Icons.calendar_month)),
          ElevatedButton(
            onPressed: () async {
              _formKey.currentState?.save();
              // Validate returns true if the form is valid, or false otherwise.

              if (_formKey.currentState!.validate()) {
                int dateStartInt = dateToUnix(dateStart!);
                int dateFinishInt = dateToUnix(dateFinish!);
                LessonModel lesson =
                    LessonModel(dateStart: dateStartInt, dateFinish: dateFinishInt, name: nametController.text);
                await lessonRepo.insert(lesson);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clase creada correctamente.')),
                );

                setState(() {
                  // ignore: use_build_context_synchronously
                  context.pop();
                });
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}
