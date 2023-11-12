import 'package:flutter/material.dart';

import '../../../dominio/home_param.model.dart';
import '../../../pages/basics_example.dart';
import '../../../pages/complex_example.dart';
import '../../../pages/events_example.dart';
import '../../../pages/multi_example.dart';
import '../../../pages/range_example.dart';

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
  static const String name = 'cards_screen';
  HomeParamModel homeParamModel;
  HomeScreen({super.key, required this.homeParamModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hola ${homeParamModel.email}'),
        ),
        body: StartPage(key: super.key));
  }
}

// ignore: must_be_immutable
class _CardsView extends StatelessWidget {
  HomeParamModel home;
  _CardsView({required this.home});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...cards.map(
            (card) => _CardType1(elevation: card['elevation'], label: home.password),
          ),
          ...cards.map(
            (card) => _CardType2(elevation: card['elevation'], label: card['label']),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _CardType1 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType1({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}

class _CardType2 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType2({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)), side: BorderSide(color: colors.outline)),
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('$label - outline'),
            )
          ],
        ),
      ),
    );
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
    return const Scaffold(body: TableEventsExample());
  }
}
