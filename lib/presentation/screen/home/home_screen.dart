import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../dominio/entities/home_param.model.dart';
import '../../pages/calendar_page.dart';
import '../signature/create_signature_screen.dart';
import '../teacher/create_teacher_screen.dart';

const cards = <Map<String, dynamic>>[
  {'elevation': 0.0, 'label': 'Elevation 0'},
  {'elevation': 1.0, 'label': 'Elevation 1'},
  {'elevation': 2.0, 'label': 'Elevation 2'},
  {'elevation': 3.0, 'label': 'Elevation 3'},
  {'elevation': 4.0, 'label': 'Elevation 4'},
  {'elevation': 5.0, 'label': 'Elevation 5'},
];

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  HomeParamModel homeParamModel;
  HomeScreen({super.key, required this.homeParamModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido ${homeParamModel.email}'),
        ),
        body: StartPage(key: super.key));
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 8.0),
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: [
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(CalendarPages.name);
                },
                child: const Text('Calendario')),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(CreateTeacherScreen.name);
                },
                child: const Text('Crear Profesor')),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(CreateSignatureScreen.name);
                },
                child: const Text('Crear Materia'))
          ],
        )
      ],
    ));
  }
}
