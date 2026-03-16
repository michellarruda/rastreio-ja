// Rastreio Já — Formatadores de data
library;

import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static final _full     = DateFormat("dd/MM/yyyy 'as' HH:mm", 'pt_BR');
  static final _short    = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final _time     = DateFormat('HH:mm', 'pt_BR');
  static final _relative = DateFormat('EEE, dd MMM', 'pt_BR');

  static String full(final DateTime dt)     => _full.format(dt);
  static String short(final DateTime dt)    => _short.format(dt);
  static String time(final DateTime dt)     => _time.format(dt);
  static String relative(final DateTime dt) => _relative.format(dt);
}
