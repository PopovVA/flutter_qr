import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class QrState extends Equatable {
  QrState([List<dynamic> props = const <dynamic>[]]) : super(props);

  @override
  String toString();
}

class AppUninitialized extends QrState {
  @override
  String toString() => 'AppUninitialized';
}

class DataLoading extends QrState {
  @override
  String toString() => 'DataLoading';
}

class DataLoaded extends QrState {
  DataLoaded(this.data);

  final String data;

  @override
  String toString() => 'DataLoaded';
}

class DataLoadingError extends QrState {
  DataLoadingError(this.error);

  final String error;

  @override
  String toString() => error;
}
