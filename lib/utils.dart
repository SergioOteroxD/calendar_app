// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:math';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _random = Random();
final listMaterias= ['Gina Montiel INVESTIGACION DE OPERACIONES','Domingo Galeano ORGANIZACION DE COMPUTADORES', 'Domingo Galeano DESARROLLO DE APPS'];

final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => Event(listMaterias[_random.nextInt(listMaterias.length)])) }
  ..addAll({
    kToday: [
      const Event('Domingo Galeano ORGANIZACION DE COMPUTADORES'),
      const Event('Domingo Galeano ORGANIZACION DE COMPUTADORES'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 2, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 2, kToday.day);