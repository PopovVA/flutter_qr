import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocListener, BlocListenerTree;
import '../bloc/qr_bloc.dart';
import '../bloc/qr_event.dart';
import '../bloc/qr_state.dart';
import 'result.dart' show ResultScreen;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  QrBloc _qrBloc;

  @override
  void initState() {
    super.initState();
    _qrBloc = QrBloc();
    _qrBloc.dispatch(ShowCamera());
  }

  @override
  Widget build(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);
    return Container(
        child: BlocListenerTree(
            blocListeners: <BlocListener<dynamic, dynamic>>[
          BlocListener<QrEvent, QrState>(
            bloc: _qrBloc,
            listener: (BuildContext context, QrState state) {
              if (state is DataLoadingError) {
                print('error');
              }
            },
          )
        ],
            child: BlocBuilder<QrEvent, QrState>(
                bloc: _qrBloc,
                builder: (BuildContext context, QrState state) {
                  if (state is AppUninitialized || state is DataLoading) {
                    return Container(child: const CircularProgressIndicator());
                  }
                  if (state is DataLoaded) {
                    return ResultScreen(
                      data: state.data,
                      qrBloc: _qrBloc,
                      locale: locale,
                    );
                  }
                  if (state is DataLoadingError) {
                    return ResultScreen(
                        data: state.error, qrBloc: _qrBloc, locale: locale);
                  }
                  return ResultScreen(
                      data: locale.languageCode == 'ru'
                          ? 'Запустите сканер'
                          : 'Start scanner',
                      qrBloc: _qrBloc,
                      locale: locale);
                })));
  }
}
