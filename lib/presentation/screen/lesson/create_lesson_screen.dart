import 'package:calendar_app/dominio/share/util_event.dart';
import 'package:calendar_app/infrastructure/model/lesson_model.dart';
import 'package:calendar_app/infrastructure/model/signature_model.dart';
import 'package:calendar_app/infrastructure/repositories/signature_repository_impl.dart';
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
  final signatureRepo = SignatureRepositoryImpl();
  final _formKey = GlobalKey<FormState>();
  final dateStartController = TextEditingController();

  List<SignatureModel> signatures = [];
  SignatureModel dropdownValue = SignatureModel(name: '', teacherId: 1);
  @override
  void initState() {
    super.initState();
    signatureRepo.getAll().then((value) {
      setState(() {
        signatures = value;
        if (value.isNotEmpty) {
          dropdownValue = value.first;
        }
      });
    });
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
              icon: const Icon(Icons.time_to_leave_outlined)),
          DropdownButton<SignatureModel>(
            isExpanded: true,
            value: dropdownValue,
            items: signatures.map<DropdownMenuItem<SignatureModel>>((e) {
              return DropdownMenuItem(value: e, child: Text(e.name));
            }).toList(),
            onChanged: (SignatureModel? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              _formKey.currentState?.save();
              // Validate returns true if the form is valid, or false otherwise.
              if (signatures.isEmpty) {
                showSnackBar(context, 'Primero crea asignatura para poder asignar un evento');
                return;
              }
              if (_formKey.currentState!.validate()) {
                LessonModel lesson = LessonModel(
                    dateStart: dateToUnix(dateStart!),
                    dateFinish: dateToUnix(dateFinish!),
                    signatureId: dropdownValue.id);
                await lessonRepo.insert(lesson);

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clase creada correctamente.')),
                );
                setState(() {
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
