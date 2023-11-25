import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../dominio/share/util_event.dart';
import '../../infrastructure/model/lesson_join_model.dart';
import '../../infrastructure/repositories/lesson_repository_impl.dart';
// import '../../utils.dart';

class CalendarPages extends StatelessWidget {
  static const name = "calendar";
  const CalendarPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: TableEventsExample(key: super.key));
  }
}

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  final lessonRepo = LessonRepositoryImpl();
  List<LessonJoinModel> clases = [];
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode =
      RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final LinkedHashMap<DateTime, List<Event>> reslver = LinkedHashMap();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;

    lessonRepo
        .queryRaw('''SELECT lessons.dateStart,lessons.dateFinish, teachers.name AS profesor, signatures.name AS materia
FROM lessons
JOIN signatures ON lessons.signatureId = signatures.id
JOIN teachers ON signatures.teacherId = teachers.id;''').then((value) {
      setState(() {
        clases = value;
        final clasesT = clases;
        for (var element in clasesT) {
          if (!reslver.containsKey(element.dateStart)) {
            reslver[element.dateStart] = [];
          }
          final obj = clasesT.where((objeto) => objeto.dateStart == element.dateStart).toList();
          reslver.addAll({element.dateStart: obj.map((e) => Event('${element.materia} ${element.profesor}')).toList()});
        }
      });
    });
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    print({'reslver': reslver});
    var dayUnix = dateToUnix(day);
    if (reslver.containsKey(dayUnix)) {
      // ignore: avoid_print
      print({'reslver': reslver[day] ?? []});
    }
    return reslver[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text(value[index].title),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              context.push('/lesson');
            },
            child: const Icon(Icons.plus_one_outlined),
          )
        ],
      ),
    );
  }
}