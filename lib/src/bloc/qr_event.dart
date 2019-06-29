import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class QrEvent extends Equatable {
  QrEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class ShowCamera extends QrEvent {
  @override
  String toString() => 'ShowCamera';
}
