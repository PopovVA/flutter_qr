import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../app_id.dart' show app_id, banner_id;
import '../bloc/qr_bloc.dart';
import '../bloc/qr_event.dart';
import '../key_words.dart' show key_words;

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {@required this.data, @required this.qrBloc, @required this.locale});

  final String data;
  final QrBloc qrBloc;
  final Locale locale;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: app_id != null ? <String>[app_id] : null,
    keywords: key_words,
  );

  BannerAd bannerAd;

  BannerAd buildBanner() {
    return BannerAd(
        adUnitId: app_id,
        targetingInfo: targetingInfo,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print(event);
        });
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: app_id);
    bannerAd = buildBanner()..load();
  }

  @override
  Widget build(BuildContext context) {
    bannerAd..show();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTitle(),
          _buildResult(),
          _buildCameraButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
              child: Text(
                  widget.locale.languageCode == 'ru'
                      ? 'Результат сканирования:'
                      : 'Your scan result:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).primaryColorLight)))),
    );
  }

  Widget _buildResult() {
    return Expanded(
      child: Align(
          alignment: FractionalOffset.center,
          child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                widget.data != null
                    ? widget.data
                    : widget.locale.languageCode == 'ru'
                        ? 'Запустите сканер'
                        : 'Try to start scanner',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 15.0),
              ))),
    );
  }

  Widget _buildCameraButton() {
    return Container(
        child: Expanded(
      child: Align(
        alignment: FractionalOffset.topCenter,
        child: RaisedButton(
            color: Theme.of(context).primaryColor,
            disabledColor: const Color(0xE6CACACA),
            elevation: 8,
            onPressed: () => widget.qrBloc.dispatch(ShowCamera()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.camera_alt),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                Text(
                    widget.locale.languageCode == 'ru'
                        ? 'сканировать'
                        : 'new scan',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 20.0))
              ],
            )),
      ),
    ));
  }
}
