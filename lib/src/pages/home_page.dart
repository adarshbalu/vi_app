import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:vi_app/src/pages/call.dart';
import '../ad_manager.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  void initState() {
    super.initState();
    _initAdMob();
    _initAd();
  }

  @override
  void dispose() {
    super.dispose();
    disposeBanner();
  }

  final FirebaseAdMob firebaseAdMob = FirebaseAdMob.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Random video app',
            style: Theme.of(context).textTheme.headline5,
          ),
          Text('If no user joins after 15 seconds call ends.'),
          SizedBox(
            height: 16,
          ),
          Center(
            child: RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 42),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CallPage()));
              },
              child: Text('Get Started!'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _initAdMob() {
    return firebaseAdMob.initialize(appId: AdManager.appId);
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'test ad',
    ],
    contentUrl: 'https://github.icom/adarshbalu',
    childDirected: false,
    testDevices: <String>[],
  );

  BannerAd myBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );
  disposeBanner() async {
    if (myBanner != null && await myBanner.isLoaded()) await myBanner.dispose();
  }

  void _initAd() {
    myBanner
      ..load()
      ..show(
        anchorOffset: 00.0,
        horizontalCenterOffset: 10.0,
        anchorType: AnchorType.bottom,
      );
  }
}
