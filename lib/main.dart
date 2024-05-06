import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:khalti/khalti.dart';
import 'package:kmc/components/bottomNavBar.dart';
import 'package:kmc/components/translation.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/firebase_options.dart';
import 'package:kmc/pages/emergency/emergency.dart';
import 'package:kmc/pages/hellomayor/appointmentList.dart';
import 'package:kmc/pages/hellomayor/hellomayorEntry.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasoEntry.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/nyayiklist.dart';
import 'package:kmc/pages/news/newslist.dart';
import 'package:kmc/pages/notification.dart';
import 'package:kmc/pages/onboarding/onboarding_screen.dart';
import 'package:kmc/pages/parichaya.dart';
import 'package:kmc/pages/paryatak_sthal.dart';
import 'package:kmc/pages/pratinidhiwordpress/cubit/karmachariwordpress_cubit.dart';
import 'package:kmc/pages/pratinidhiwordpress/cubit/pratinidhinew_cubit.dart';
import 'package:kmc/pages/pratinidhiwordpress/screen/pratinidhiwordpress.dart';
import 'package:kmc/pages/profile/profile.dart';
import 'package:kmc/pages/profile/secondprofile.dart';
import 'package:kmc/pages/rajpatra.dart';
import 'package:kmc/pages/settings.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_form_cubit/sifarish_form_cubit.dart';
import 'package:kmc/pages/sewa/sifarish_new/sifarish_list_cubit/sifarish_list_cubit.dart';
import 'package:kmc/pages/wodajankari.dart';
import 'package:kmc/pages/wodapatra/citizencharter.dart';
import 'package:kmc/pages/yojana/woda_janakari_cubit/cubit/woda_jankari_cubit.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'config/replaceable.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessage: ${message.data}");
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NepaliUtils(Language.nepali);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FlutterDownloader.initialize(debug: false);
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  await firebaseAnalytics.logAppOpen();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp: $message");
    Get.to(Notifications());
    // navigateToPageFromNotification(message);
  });

  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('devicetoken')) {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    prefs.setString('devicetoken', fcmToken!);
    print("FCM:  " + fcmToken);
    print('FCM NEW TEST');
  } else {
    print("GET FCM:  " + prefs.getString('devicetoken')!);
    print('FCM GET TEST');
  }
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NepaliUtils(Language.nepali);

  configLoading();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SifarishListCubit(),
        ),
        BlocProvider(
          create: (context) => SifarishFormCubit(),
        ),
        BlocProvider(
          create: (context) => PratinidhinewCubit()..pratinidhiWordpressApi(),
        ),
        BlocProvider(
          create: (context) =>
              KarmachariwordpressCubit()..karmachariWordpressApi(),
        ),
        BlocProvider(
          create: (context) => WodaJankariCubit()..fetch(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorWidget
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = primary
    ..backgroundColor = background
    ..indicatorColor = primary
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primary));
    return GetMaterialApp(
      translations: Messages(),
      locale:
          Locale('hi', 'IN'), // translations will be displayed in that locale
      debugShowCheckedModeBanner: false,

      title: '${Config.app_name}',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: kDebugMode ? 0 : 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isOnboardingCompleted = pref.getBool("onBoardingCompleted");
    if (isOnboardingCompleted != null && isOnboardingCompleted == true) {
      Get.off(BottomNavBar());
    } else {
      Get.off(NewOnBoardingScreen());
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) async {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
      var newUpdate = await InAppUpdate.checkForUpdate();
      newUpdate.updateAvailability == UpdateAvailability.updateAvailable
          ? SystemNavigator.pop()
          : null;
    }).catchError((e) {
      print("Could not update");
      // showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    if (!kDebugMode) {
      checkForUpdate();
    }
    print(UpdateAvailability.updateAvailable);
    print('started');

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    startTime();
    firebaseMessaging.getToken().then((token) {
      print("Firebase Token: $token");
      // Save or use the token as needed
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/splash1.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            bottom: Get.height * 0.2,
            right: Get.width * 0.35,
            child: Container(
              height: Get.height * 0.3,
              width: Get.width * 0.3,
              child: Image.asset(
                "assets/botu.gif",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void navigateToPageFromNotification(RemoteMessage message) {
  // Navigate to your desired page here
  handleMessage(
    message,
  ); // Example navigation to BottomNavBar
}

void handleMessage(RemoteMessage message) async {
  String? linkCategory = message.data['link_category'];
  String? deepLinkCategory = message.data['deep_link_category'];
  if (linkCategory == 'deep') {
    var pref = await SharedPreferences.getInstance();
    bool? s = pref.getBool('login');
    if (s == true) {
      switch (deepLinkCategory) {
        case 'notice_news':
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const NewsList(),
          //   ),
          // );
          Get.to(NewsList());
          break;
        case 'my_profile':
          Get.to(Profile());
          break;
        case 'my_profile':
          Get.to(Settings());
          break;
        case 'emergency':
          Get.to(Emergency());
          break;
        case 'ward':
          Get.to(Wodajankari());
          break;
        case 'staff':
          Get.to(PratinidhiWordpress());
          break;
        case 'representative':
          Get.to(PratinidhiWordpress());
          break;
        case 'social_development':
          Get.to(BottomNavBar());
          break;
        case 'tourist_center':
          Get.to(Paryatak_Sthal());
          break;
        case 'ejalassh':
          Get.to(NyayikList());
          break;
        case 'digital_profile':
          Get.to(NewsList());
          break;
        case 'finance':
          Get.to(NewsList());
          break;
        case 'home':
          Get.to(NewsList());
          break;
        case 'hello_mayor':
          Get.to(HellomayorEntry());
          break;
        case 'appointment':
          Get.to(AppointmentListScreen());
          break;
        case 'nagarik_wodapatra':
          Get.to(CitizenCharter());
          break;
        case 'janagunaso':
          Get.to(JanaGunasoEntry());
          break;
        case 'esifarish':
          Get.to(SecondProfile());
          break;
        case 'parichaya':
          Get.to(Parichaya());
          break;
        case 'rajpatra':
          Get.to(Rajpatra());
          break;
        case 'environment_agriculture':
          Get.to(NewsList());
          break;
        case 'education':
          Get.to(BottomNavBar());
          break;
        case 'administrative':
          Get.to(BottomNavBar());
          break;
        case 'health':
          Get.to(BottomNavBar());
          break;
        case 'revenue':
          Get.to(BottomNavBar());
          break;
        case 'informationtechnology':
          Get.to(BottomNavBar());
          break;
        case 'law':
          Get.to(BottomNavBar());
          break;
        case 'public_works':
        default:
          break;
      }
    } else{
      switch (deepLinkCategory) {
        case 'notice_news':
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const NewsList(),
          //   ),
          // );
          Get.to(NewsList());
          break;
        case 'emergency':
          Get.to(Emergency());
          break;
        case 'ward':
          Get.to(Wodajankari());
          break;
        case 'staff':
          Get.to(PratinidhiWordpress());
          break;
        case 'representative':
          Get.to(PratinidhiWordpress());
          break;
        case 'social_development':
          Get.to(BottomNavBar());
          break;
        case 'tourist_center':
          Get.to(Paryatak_Sthal());
          break;
        case 'ejalassh':
          Get.to(NyayikList());
          break;
        case 'digital_profile':
          Get.to(NewsList());
          break;
        case 'finance':
          Get.to(NewsList());
          break;
        case 'home':
          Get.to(NewsList());
          break;
        case 'public_works':
        default:
        Get.to(Notifications());
          break;
      }
    }
  }else if (linkCategory == 'external') {
      Get.to(Notifications());
      // launchUrl(Uri.parse(message.data['link']));
    }
}
