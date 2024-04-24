import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kmc/components/custom_exception.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/config/url.dart';
import 'package:kmc/modal/appointmentlist_model.dart';
import 'package:kmc/modal/barchartmodal.dart';
import 'package:kmc/modal/business.dart';
import 'package:kmc/modal/chatfromuserside.dart';
import 'package:kmc/modal/chathistorymodal.dart';
import 'package:kmc/modal/chatlistmodal.dart';
import 'package:kmc/modal/citizencharter.dart';
import 'package:kmc/modal/digitalprofilemodal.dart';
import 'package:kmc/modal/emergencynum.dart';
import 'package:kmc/modal/eventsmodal.dart';
import 'package:kmc/modal/getmessage.dart';
import 'package:kmc/modal/nagarkarmacharimodal.dart';
import 'package:kmc/modal/newsnoticemodal.dart';
import 'package:kmc/modal/newsnoticemodalwordpress.dart';
import 'package:kmc/modal/noticeModel.dart';
import 'package:kmc/modal/palikaintro.dart';
import 'package:kmc/modal/pratinidhikarmachari.dart';
import 'package:kmc/modal/rajpatra.dart';
import 'package:kmc/modal/receiptmodule.dart';
import 'package:kmc/modal/sifarishbasicfieldmodal.dart';
import 'package:kmc/modal/sifarishlistmodal.dart';
import 'package:kmc/modal/taxPayerDetail.dart';
import 'package:kmc/modal/taxPaymentDetail.dart';
import 'package:kmc/modal/toiletgraph.dart';
import 'package:kmc/modal/wodajanakari.dart';
import 'package:kmc/modal/wodapratinidhi.dart';
import 'package:kmc/modal/yojanamodal.dart';
import 'package:kmc/pages/forgetpassword/forgetpassword.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottomNavBar.dart';
import '../modal/addressmodal.dart';
import '../modal/appointmentmodal.dart';
import '../modal/nearby_places.dart';
import '../pages/home/signUpOTP.dart';
import '../server_maintan.dart';

DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
Options _cacheOptions =
    buildCacheOptions(Duration(days: 30), forceRefresh: true);
Dio _dio =
    Dio(); //*dio chai cache ma api lai rakhna use gareko navaye http hunxa
Options _cacheOption =
    buildCacheOptions(Duration(days: 1), forceRefresh: false);
Future<List<Pratinidhikarmacharidata>> getpratinidhi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(pratinidhiandkarmachari, options: _cacheOptions);
  List<dynamic> list = data.data['data'];
  var a = data.data['data'][0]['data'];
  var mayor = json.encode(a[0]);
  var vicemayor = json.encode(a[1]);

  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('mayor', mayor);
  pref.setString('vicemayor', vicemayor);
  mayorvicemayor();
  var karmachari =
      list.map((e) => Pratinidhikarmacharidata.fromJson(e)).toList();
  return karmachari;
}

Future<List<Wodapratinidhi>> getpratinidhiwoda() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(pratinidhiandkarmachari, options: _cacheOptions);
  List<dynamic> list = data.data['data'][2]['data'];
  // //print(list[2]);

  SharedPreferences pref = await SharedPreferences.getInstance();

  var karmachari = list.map((e) => Wodapratinidhi.fromJson(e)).toList();
  return karmachari;
}

//taxpayer infromation
getTaxPayerDetail() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var res =
      await _dio.get(getTaxPayerlist, options: Options(headers: _setHeaders()));

  var data = res.data;

  if (res.statusCode == 200) {
    var taxpayerlist = TaxPayerDetailModel.fromJson(data);
    return taxpayerlist;
  } else {
    EasyLoading.showError('server_connection_error'.tr);
  }
}

Future<List<Nagarkarmacharidata>> nagarKarmachari() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(nagarkarmachari, options: _cacheOptions);
  List<dynamic> list = data.data['data'];

  for (var a in list) {
    if (a['data_type'] == "सूचना अधिकारी") {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('suchanaAdhikari', json.encode(a['data'][0]));
      print(json.encode(a['data'][0]));
      suchana();
    }
  }

  var nagarkarmachariapi =
      list.map((e) => Nagarkarmacharidata.fromJson(e)).toList();
  return nagarkarmachariapi;
}

Future<List<Wodapratinidhi>> wodakarmachariApi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(wodakarmachari, options: _cacheOptions);
  List<dynamic> list = data.data['data'];
  var karmachari = list.map((e) => Wodapratinidhi.fromJson(e)).toList();
  return karmachari;
}

Future<List<Nagarkarmacharidata>> exkarmachariApi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(exkarmachari, options: _cacheOptions);
  List<dynamic> list = data.data['data'];

  var nagarkarmachariapi =
      list.map((e) => Nagarkarmacharidata.fromJson(e)).toList();
  return nagarkarmachariapi;
}

dynamic vicemayor;
dynamic mayordata;
dynamic suchanaAdhikari;
mayorvicemayor() async {
  SharedPreferences? pref = await SharedPreferences.getInstance();
  mayordata = json.decode(pref.getString('mayor')!);
  vicemayor = json.decode(pref.getString('vicemayor')!);
}

suchana() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  suchanaAdhikari = json.decode(pref.getString('suchanaAdhikari')!);
  print('suchanaAdhikari');
  // //print(suchanaAdhikari);
}

dynamic token;
getToken() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  token = localStorage.getString('token');
  // //print(token);
}

Map<String, String> _setHeaders() => {
      'Content-Type': 'application/json',
      'content-type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

Future<Chatlist?> mayorchatlistAPI() async {
  EasyLoading.show(status: 'Please wait...'.tr);

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    http.Response response =
        await http.get(Uri.parse(mayorchatlist), headers: _setHeaders());
    dynamic list = response.body;
    if (response.statusCode == 200) {
      var hellomayor = Chatlist.fromJson(json.decode(list));
      return hellomayor;
    } else {
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
  return null;
}

Future<Userchat?> openhellomayorfromuserAPI() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    // _dio.options.headers[HttpHeaders.authorizationHeader] = _setHeaders();
    // Response data =
    //     await _dio.get(HMchatfromuser, options: _cacheOptions);
    http.Response response =
        await http.get(Uri.parse(hMchatfromuser), headers: _setHeaders());
    if (response.statusCode == 200) {
      // EasyLoading.dismiss();

      dynamic list = response.body;
      var hellomayor =
          list != null ? Userchat.fromJson(json.decode(list)) : null;
      return hellomayor!;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
  return null;
}

Future<Getmessage?> getMsgFromUserHMApi() async {
  getToken();

  http.Response response =
      await http.get(Uri.parse(getMsgFromUserHM), headers: _setHeaders());

  dynamic list = response.body;
  if (response.statusCode == 200) {
    var hellomayor = Getmessage.fromJson(json.decode(list));
    return hellomayor;
  } else {
    EasyLoading.dismiss();
    EasyLoading.showError('server_connection_error'.tr);
    return null;
  }
}

storechatHMApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    http.Response response = await http.post(
      Uri.parse(storechatHM),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}

//imepay initialize to get token
initiateIMEPayment(sp_pay_code, int ward) async {
  var dio = await Dio();
  dio.options.headers = _setHeaders();
  try {
    var response = await dio.post(imepay_initialize,
        data: {'sp_pay_code': sp_pay_code, 'ward': ward});
    print(response.data['data']['TokenId'].toString());
    return response.data;
  } on DioError catch (e) {
    print(e.message.toString());
    throw Exception();
  }
}

finalIMEPayment(amount, msisdn, refId, responseCode, String responseDescription,
    transactionId, sifarisCode, ward, hash, context) async {
  var dio = await Dio();
  dio.options.headers = _setHeaders();
  try {
    var response = await dio.post(
      imepay_delivery,
      data: {
        'totalAmount': amount,
        'msisdn': msisdn,
        'refId': refId,
        'responseCode': responseCode,
        'responseDescription': responseDescription,
        'transactionId': transactionId,
        'sp_pay_code': sifarisCode,
        'ward': ward,
      },
    );
    print("DEBUG Response:" + response.data.toString());
    if (response.statusCode == 200) {
      print(response.data['message']);
      EasyLoading.showSuccess("भुक्तानी सफल भएको छ");
      Navigator.pop(context);
      Get.off(BottomNavBar());
    } else {
      EasyLoading.showError('server_connection_error'.tr);
    }
    return response.data;
  } on DioError catch (e) {
    print(e.message.toString());
    throw Exception();
  }
}

//janagunaso Chat
Future<Chatlist?> gunasochatlistAPI() async {
  EasyLoading.show(status: 'Please wait...'.tr);

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    http.Response response =
        await http.get(Uri.parse(gunasochatlist), headers: _setHeaders());
    dynamic list = response.body;
    if (response.statusCode == 200) {
      var gunaso = Chatlist.fromJson(json.decode(list));
      return gunaso;
    } else {
      EasyLoading.showError('server_connection_error'.tr);
      return null;
    }
  }
  return null;
}

Future<Userchat?> opengunasofromuserAPI() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  try {
    if (connectivityResult == ConnectivityResult.none) {
      EasyLoading.dismiss();

      EasyLoading.showError('no_internet_connection'.tr);
    } else {
      getToken();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      // _dio.options.headers[HttpHeaders.authorizationHeader] = _setHeaders();
      // Response data =
      //     await _dio.get(JGchatfromuser, options: _cacheOptions);
      http.Response response =
          await http.get(Uri.parse(jGchatfromuser), headers: _setHeaders());

      dynamic list = response.body;
      if (response.statusCode == 200) {
        var gunaso = list != null ? Userchat.fromJson(json.decode(list)) : null;
        return gunaso!;
      } else {
        EasyLoading.dismiss();

        EasyLoading.showError('server_connection_error'.tr);
        return null;
      }
    }
  } catch (e) {
    print(e.toString());
  }

  return null;
}

Future<Getmessage?> getMsgFromUserJGApi() async {
  getToken();
  _dio.interceptors.add(_dioCacheManager.interceptor);

  http.Response response =
      await http.get(Uri.parse(getMsgFromUserJG), headers: _setHeaders());
  dynamic list = response.body;

  if (response.statusCode == 200) {
    var gunaso = Getmessage.fromJson(json.decode(list));
    return gunaso;
  } else {
    EasyLoading.showError('server_connection_error'.tr);
    return null;
  }
}

// wodapatra ko garo data
List array = [];
Future<List<WodaPatraData>> wodapatraApi() async {
  array.clear();

  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(wodapatra, options: _cacheOptions);
  var list = data.data['data'];
  for (final mapEntry in list.entries) {
    dynamic abc = {'key': mapEntry.key, 'value': mapEntry.value};
    array.add(abc);
  }
  var wodapatradata = array.map((e) => WodaPatraData.fromJson(e)).toList();
  return wodapatradata;
}

storechatJGApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    http.Response response = await http.post(
      Uri.parse(storechatJG),
      body: json.encode(data),
      headers: _setHeaders(),
    );
    return json.decode(response.body);
  }
}

//Nyayik Samiti Chat
Future<Chatlist?> nyayikchatlistAPI() async {
  EasyLoading.show(status: 'Please wait...'.tr);

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    http.Response response =
        await http.get(Uri.parse(nyayikchatlist), headers: _setHeaders());

    dynamic list = response.body;
    if (response.statusCode == 200) {
      var nyayik = Chatlist.fromJson(json.decode(list)) /*  */;
      return nyayik;
    } else {
      EasyLoading.dismiss();

      EasyLoading.showError('server_connection_error'.tr);
      return null;
    }
  }
  return null;
}

Future<Userchat?> opennyayikfromuserAPI() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    // _dio.options.headers[HttpHeaders.authorizationHeader] = _setHeaders();
    // Response data =
    //     await _dio.get(NSchatfromuser, options: _cacheOptions);
    http.Response response =
        await http.get(Uri.parse(NSchatfromuser), headers: _setHeaders());
    if (response.statusCode == 200) {
      dynamic list = response.body;

      var nyayik = list != null ? Userchat.fromJson(json.decode(list)) : null;
      return nyayik;
    } else {
      EasyLoading.dismiss();

      EasyLoading.showError('server_connection_error'.tr);
    }
  }
  return null;
}

Future<Getmessage?> getMsgFromUserNSApi() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    _dio.interceptors.add(_dioCacheManager.interceptor);

    http.Response response =
        await http.get(Uri.parse(getMsgFromUserNS), headers: _setHeaders());

    dynamic list = response.body;
    var nyayik = Getmessage.fromJson(json.decode(list));
    return nyayik;
  }
  return null;
}

storechatNSApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    http.Response response = await http.post(
      Uri.parse(storechatNS),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );

    return json.decode(response.body);
  }
}

Future download2(Dio dio, String url, String savePath) async {
  //get pdf from link
  var response = await dio.get(
    url,
    //Received data with List<int>
    options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }),
  );

  //write in download folder
  File file = File(savePath);
  var raf = file.openSync(mode: FileMode.write);
  raf.writeFromSync(response.data);
  await raf.close();
}

dynamic ismayorcheck;
checkmayorAPi() async {
  getToken();
  SharedPreferences pref = await SharedPreferences.getInstance();
  http.Response response =
      await http.get(Uri.parse(checkmayor), headers: _setHeaders());

  if (response.statusCode == 200) {
    pref.setString("ismayor", json.decode(response.body));
    ismayorcheck = pref.getString("ismayor");
  }
}

Future<List<ChathistoryfromMayorside>?> getchathistoryApifromMayor(id) async {
  getToken();
  http.Response response = await http.get(
      Uri.parse(mayorchathistory + id + '/upmessage'),
      headers: _setHeaders());
  List<dynamic> list = json.decode(response.body);

  if (response.statusCode == 200) {
    return list.map((e) => ChathistoryfromMayorside.fromJson(e)).toList();
  }
  return null;
}

Future<List<ChathistoryfromMayorside>?> getchathistoryApifromGunaso(id) async {
  getToken();
  http.Response response = await http.get(
      Uri.parse(gunasochathistory + id + '/upmessage'),
      headers: _setHeaders());
  List<dynamic> list = json.decode(response.body);

  if (response.statusCode == 200) {
    return list.map((e) => ChathistoryfromMayorside.fromJson(e)).toList();
  }
  return null;
}

Future<List<ChathistoryfromMayorside>?> getchathistoryApifromNyayik(id) async {
  getToken();
  http.Response response = await http.get(
      Uri.parse(nyayikchathistory + id + '/upmessage'),
      headers: _setHeaders());
  List<dynamic> list = json.decode(response.body);

  if (response.statusCode == 200) {
    return list.map((e) => ChathistoryfromMayorside.fromJson(e)).toList();
  }
  return null;
}

checkvicemayorAPi() async {
  getToken();
  SharedPreferences pref = await SharedPreferences.getInstance();
  http.Response response =
      await http.get(Uri.parse(checkupamayor), headers: _setHeaders());

  if (response.statusCode == 200) {
    pref.setString("isvicemayor", json.decode(response.body));
  }
}

checksuchanaAPi() async {
  getToken();
  SharedPreferences pref = await SharedPreferences.getInstance();
  http.Response response =
      await http.get(Uri.parse(checksuchana), headers: _setHeaders());

  if (response.statusCode == 200) {
    pref.setString("issuchana", json.decode(response.body));
  }
}

taxRegisterotpAPi(data) async {
  http.Response response = await http.post(Uri.parse(taxRegisterOTP),
      headers: _setHeaders(), body: jsonEncode(data));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
}

forgotPasswordotpAPi(data) async {
  http.Response response = await http.post(Uri.parse(forgotpasswordopt),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    data = jsonDecode(response.body);
    EasyLoading.showError(data['message']);
  }
}

verifyotpFogotAPi(data) async {
  http.Response response = await http.post(Uri.parse(checkforgotopt),
      headers: {
        'Content-Type': 'application/json',
        'accept':"application/json",
      },
      body: jsonEncode(data));
  if (response.statusCode == 200 ) {
    
    var a = json.decode(response.body);
    if(a['status']){
      return json.decode(response.body);
    }else{

       EasyLoading.showError(a['message']);
    }
  }else{
    var a = json.decode(response.body);
    EasyLoading.showError(a['message']);
  }
}

passUpdateApi(data) async {
  http.Response response =
      await http.post(Uri.parse(updatepassword), body: jsonEncode(data));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {}
}

householdVerify(data) async {
  http.Response response = await http.post(Uri.parse(householdverify),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {}
}

setpass(data) async {
  http.Response response = await http.post(Uri.parse(setpassword),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    var d = json.decode(response.body);
    EasyLoading.showError(d['error']);
  }
}

householdpasswordset(data) async {
  http.Response response = await http.post(
    Uri.parse(setpassword),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {}
}

///household end

// Future<List<Bibagh>> bibaghApi() async {
//   _dio.interceptors.add(_dioCacheManager.interceptor);
//   var data = await _dio.get(bibagh, options: _cacheOptions);
//   List<dynamic> list = data.data;
//   var karmachari = list.map((e) => Bibagh.fromjson(e)).toList();
//   return karmachari;
// }

  getBibagh() async {
    _dio.interceptors.add(_dioCacheManager.interceptor);
    var response = await _dio.get(bibagh, options: _cacheOption);

    return response.data;
  }

loginApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(login),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
      firebaseAnalytics.logLogin();
      firebaseAnalytics.setUserProperty(
          name: "Name", value: jsonDecode(response.body)['data']['name']);
      firebaseAnalytics.setUserProperty(
          name: "Email", value: jsonDecode(response.body)['data']['email']);
      dynamic d = json.decode(response.body);
      if (d['data']['status'] == "user_not_verified") {
        resendEmailOtp(data);
        EasyLoading.dismiss();
        
        print(data['phone']);
        Get.to(SignUpOTP(
          mobile: data['phone'],
          password: data['password'],
        ));
      }
      if (d['status'] == true) {
        print(d['data']['status']);
        print(d['data']);
        return d['data'];
      } else {
        EasyLoading.showError('email_or_password_incorrect'.tr);
      }
    } else {
      EasyLoading.dismiss();
      dynamic d = json.decode(response.body);
      EasyLoading.showError(d['message']);
    }
  }
}


//!LOGOUT API
logoutApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(logout),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );
    return true;
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}

//householdlogin part
loginApihousehold(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(household),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      if (d['status'] == true) {
        return d['data'];
      } else {
        EasyLoading.showError('email_or_password_incorrect'.tr);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

tokenregisterApi() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  final LocalStorage storage = new LocalStorage('changu');
  dynamic s = jsonDecode(pref.getString('user')!);

  dynamic userdata = s;

  var token = pref.getString('devicetoken');
  var data = {"gcm_token": '$token', "user_id": '${userdata['id']}'};

  http.Response response = await http.post(
    Uri.parse(tokenregister),
    body: data,
  );
  if (response.statusCode == 200) {
    //

    //
  } else {
    EasyLoading.dismiss();

    EasyLoading.showError('server_connection_error'.tr);
  }
}

householdapicheck(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(household_check),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    //
    if (response.statusCode == 200) {
      dynamic d = await json.decode(response.body);

      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError(d['message']);
      }
    } else {
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

householdindividuallogincheck(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(householdlogincheck),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      return d;
    } else {
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

setpasswordapi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(passwordset),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError(d['message']);
      }
    } else {
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

askOtp(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(askotp),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError(d['message']);
      }
    } else {
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

signUp(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(signup),
      headers: {
        "accept": 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      dynamic d = json.decode(response.body);
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError('Please check all fields !! ');
      }
      return d;
    } else if (response.statusCode == 500) {
      EasyLoading.showError('server_error'.tr);
    } else {
      Map<String, dynamic> d = json.decode(response.body);
      var message = 'server_error'.tr;
      if (d["errors"]["mobile"] != null) {
        message = d["errors"]["mobile"].first;
      }
      if (d["errors"]["email"] != null) {
        message = d["errors"]["email"].first;
      }
      EasyLoading.showError(message);
      // EasyLoading.showError(d['message']);
    }
  }
}

dynamic userimagesignup;
dynamic imagearray = [];
upload(imageFile) async {
  try {
    // open a bytestream
    var stream = new http.ByteStream(imageFile.openRead());
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(signup_image);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      var a = json.decode(value);
      userimagesignup = a['data'];
      imagearray.add(a['data']);
    });
  } catch (e) {
    print(e);
  }
}

dynamic nagarikata = [];
citizenshipupload(imageFile, field) async {
  EasyLoading.show(status: 'Please wait...'.tr);

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    // open a bytestream
    var stream = new http.ByteStream(imageFile.openRead());
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(citizenshipuploadurl);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile(field, stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      var a = json.decode(value);

      nagarikata.add(a['data']);
      if (a['status'] == true) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(a['message']);
      }
    });
  }
}

dynamic profileimageupdate;
Future<bool> profileupdateimage(imageFile) async {
  EasyLoading.show(status: 'Please wait...'.tr);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(updateprofileimage);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  // listen for response
  Completer<bool> completer = Completer<bool>();
  response.stream.transform(utf8.decoder).listen((value) async {
    var a = json.decode(value);

    if (a['status']) {
      profileimageupdate = a['data'];
      var user = prefs.getString('user');
      var userData = jsonDecode(user!);
      userData["user_img"] = a["img_url"];
      await prefs.setString('user', json.encode(userData));
      EasyLoading.dismiss();
      completer.complete(true);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(a['message']);
      completer.complete(false);
    }
  });
  return completer.future;
}

Future<String> registerProfileImageUpload(imageFile) async {
  EasyLoading.show(status: 'Please wait...'.tr);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(updateprofileimage);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll({
    'Content-Type': 'application/json',
    'content-type': 'application/json',
    'accept': 'application/json',
    'Accept': 'application/json',
  });

  // multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  // listen for response
  Completer<String> completer = Completer<String>();
  response.stream.transform(utf8.decoder).listen((value) async {
    var a = json.decode(value);

    if (a['status']) {
      if (a['data'] != null) {
        EasyLoading.dismiss();
        completer.complete(a['data']);
      }
    } else {
      EasyLoading.dismiss();
      if (a["message"] != null) {
        EasyLoading.showError(a['message']);
      }
      completer.complete("");
    }
  });
  return completer.future;
}

verify(data) async {
  http.Response response = await http.post(
    Uri.parse(verifyapi),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    dynamic d = json.decode(response.body);
    return d;
  } else {}
}

verifyhouseholdapi(data) async {
  http.Response response = await http.post(
    Uri.parse(verify_otp),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    dynamic d = json.decode(response.body);
    return d;
  } else {}
}

verifySignUpapi(data) async {
  http.Response response = await http.post(
    Uri.parse(verifySignUp),
    headers: {'Content-Type': 'application/json', 'accept': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    dynamic d = json.decode(response.body);

    return d;
  } else {
    dynamic d = json.decode(response.body);
    EasyLoading.dismiss();
    EasyLoading.showError(d['message']);
  }
}


resendEmailOtp(data) async {
  http.Response response = await http.post(
    Uri.parse(resendemailotp),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    dynamic d = json.decode(response.body);
    return d;
  } else {
    dynamic d = json.decode(response.body);

    EasyLoading.showError(d['message']);
  }
}

//sifarish
Future<dynamic> sifarishlitApi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(sifarishmainlist,
      options: buildCacheOptions(Duration(days: 30),
          forceRefresh: true, options: Options(headers: _setHeaders())));
  if (data.statusCode == 200) {
    List<dynamic> list = data.data['data'];

    if (data.data['status'] == true) {
      var sifarishlist = list.map((e) => SifarishModal.fromJson(e)).toList();
      return sifarishlist;
    } else {
      EasyLoading.showError('server_error'.tr);
      return null;
    }
  } else {
    EasyLoading.showError('server_error'.tr);
    return null;
  }
}

Future<List<SifarishModel>> newSifarishListApi() async {
  try {
    var response = await _dio.get(sifarishmainlist,
        options: buildCacheOptions(
          Duration(days: 30),
          forceRefresh: true,
          options: Options(headers: _setHeaders()),
        ));
    List<SifarishModel> sifarishlist = List<SifarishModel>.from(
        (response.data['data'].map((x) => SifarishModel.fromMap(x))));
    return sifarishlist;
  } on DioError catch (dioError) {
    throw CustomException(
      message: dioError.response?.statusMessage ?? 'Error while getting data',
      statusCode: dioError.response?.statusCode ?? 0,
    );
  } on SocketException {
    throw CustomException(
      message: 'Check your internet and try again',
      statusCode: 0,
    );
  } on Error catch (e) {
    print(e);
    throw CustomException(
      message:
          "Invalid data format. This will be fixed shortly. Please, try again later",
    );
  }
}

Future<BasicformModal?> sifarishbasicFormfieldWithIdApi(data) async {
  getToken();
  http.Response response = await http.post(Uri.parse(sifarishbasicform),
      body: jsonEncode(data), headers: _setHeaders());

  print(token);

  print(data);

  if (response.statusCode == 200) {
    dynamic list = json.decode(response.body);

    if (list['status'] == true) {
      BasicformModal sifarishlist = BasicformModal.fromJson(list);

      return sifarishlist;
    } else {
      EasyLoading.showError(list['message']);
      return null;
    }
  } else {
    EasyLoading.showError('server_error'.tr);
  }
  return null;
}

Future<BasicformModal?> sifarishchildFormfieldWithIdApi(data) async {
  getToken();
  http.Response response = await http.post(Uri.parse(getchildsifarishfield),
      body: jsonEncode(data), headers: _setHeaders());

  if (response.statusCode == 200) {
    dynamic list = json.decode(response.body);
    if (list['status'] == true) {
      BasicformModal sifarishlist = BasicformModal.fromJson(list);
      return sifarishlist;
    } else {
      EasyLoading.showError('server_error'.tr);
      return null;
    }
  } else {
    EasyLoading.showError('server_error'.tr);
    return null;
  }
}

Future<List<Receiptmodal>?> receiptApi() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    getToken();
    http.Response response =
        await http.get(Uri.parse(receipt), headers: _setHeaders());

    if (response.statusCode == 200) {
      var status = json.decode(response.body);
      List<dynamic> list = status['data'];
      if (status["status"] == true) {
        var receiptdata = list.map((e) => Receiptmodal.fromJson(e)).toList();

        return receiptdata;
      } else {
        EasyLoading.showError('server_error'.tr);
        return null;
      }
    } else {
      EasyLoading.showError('server_error'.tr);
      return null;
    }
  }
  return null;
}

Future basicinfoFormsubmitApi(data) async {
  getToken();
  // var check = jsonEncode(data);

  try {
    http.Response response = await http.post(Uri.parse(saveSifaris),
        body: jsonEncode(data), headers: _setHeaders());

    dynamic list = json.decode(response.body);
    if (response.statusCode == 200) {
      if (list['status'] == true) {
        return list['data'];
      } else {
        EasyLoading.showError('${list['message']}');
        return null;
      }
    } else {
      EasyLoading.showError('${list['message']}');
      return null;
    }
  } catch (e) {
    EasyLoading.dismiss();
    print(e.toString());
  }
}

childinfoFormsubmitApi(data) async {
  getToken();

  http.Response response = await http.post(Uri.parse(childsifarishstore),
      body: jsonEncode(data), headers: _setHeaders());

  dynamic list = json.decode(response.body);

  if (response.statusCode == 200) {
    if (list['status'] == true) {
      return list['data'];
    } else {
      EasyLoading.showError('${list['message']}');
      return null;
    }
  } else {
    EasyLoading.showError('${list['message']}');
    return null;
  }
}

taxRegisterSubmit(data) async {
  getToken();

  http.Response response = await http.post(Uri.parse(taxRegisterSumbit),
      body: jsonEncode(data), headers: _setHeaders());

  dynamic res = json.decode(response.body);

  if (response.statusCode == 200) {
    if (res['status'] == true) {
      return res;
    } else {
      EasyLoading.showError('${res['message']}');
      return null;
    }
  } else {
    EasyLoading.showError('${res['message']}');
    return null;
  }
}

//sending sms of property register
registerProperty(data) async {
  getToken();

  http.Response response = await http.post(Uri.parse(landRegisterVerify),
      body: jsonEncode(data), headers: _setHeaders());

  dynamic res = json.decode(response.body);

  if (response.statusCode == 200) {
    if (res['status'] == true) {
      return res;
    } else {
      EasyLoading.showError('${res['message']}');
      return null;
    }
  } else {
    EasyLoading.showError('${res['message']}');
    return null;
  }
}

// verify tax payment

Future<TaxPaymentDetail?> verifyTaxPayment(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
  } else {
    http.Response response = await http.post(
      Uri.parse(verifyPaymentRequest),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    dynamic d = json.decode(response.body);

    if (response.statusCode == 200) {
      if (d['status'] == true) {
        TaxPaymentDetail taxDetail = TaxPaymentDetail.fromJson(d);
        return taxDetail;
      } else {
        EasyLoading.showError(d['message']);
      }
    } else {
      EasyLoading.showError(d['message']);
    }
  }
  return null;
}
// verifyTaxPayment(data) async {
//
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.none) {
//     EasyLoading.showError('no_internet_connection'.tr);
//   } else {
//     http.Response response = await http.post(
//       Uri.parse(verifyPaymentRequest),
//       headers: _setHeaders(),
//       body: jsonEncode(data),
//     );

//
//     dynamic d = json.decode(response.body);

//     if (response.statusCode == 200) {
//       if (d['status'] == true) {
//
//         return d;
//       } else {
//         EasyLoading.showError(d['message']);
//       }
//     } else {
//       //print('test');
//       EasyLoading.showError(d['message']);
//     }
//   }
// }

Future<List<WodaJanakaridata>> wodaJanakariApi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(wodajanakariurl, options: _cacheOptions);
  List<dynamic> list = data.data['data'];

  var wodajanakari = list.map((e) => WodaJanakaridata.fromJson(e)).toList();
  return wodajanakari;
}

Future<List<Publicplacess>> villagedatasearchApi(datas, wodaid) async {
  List wardfilterdata = [];
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.post(villagedatasearch, data: datas);
  List<dynamic> list = data.data['data'] == "No Data" ? [] : data.data['data'];
  for (var item in list) {
    if (item['sp_pp_ward'] == '$wodaid') {
      wardfilterdata.add(item);
    }
  }
  var publicplaces =
      wardfilterdata.map((e) => Publicplacess.fromJson(e)).toList();
  return publicplaces;
}

Future<List<Yojanalist>?> yojanaAPis(value) async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(yojana, options: _cacheOptions);

  List<dynamic> list = data.data['data'];

  var yojanalistwithid =
      list = list.where((o) => o["woda_id"] == int.parse(value)).toList();

  var datas = yojanalistwithid.map((e) => Yojanalist.fromJson(e)).toList();
  return datas;
}

dynamic uploadfile;
fileupload(imageFile, id, docName) async {
  try {
    // open a bytestream
    var stream = new http.ByteStream(imageFile.openRead());
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(saveSifarisDocument);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(_setHeaders());

    // multipart that takes file
    var multipartFile = new http.MultipartFile('doc$docName', stream, length,
        filename: basename(imageFile.path));
    request.fields['entry_id'] = '$id';

    // add file to multipart
    request.files.add(multipartFile);
    // send
    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      var a = json.decode(value);
    });
    return response.statusCode;
  } catch (e) {
    throw e;
  }
  // open a bytestream
  // var stream = new http.ByteStream(imageFile.openRead());
  // // get file length
  // var length = await imageFile.length();

  // // string to uri
  // var uri = Uri.parse(saveSifarisDocument);

  // // create multipart request
  // var request = new http.MultipartRequest("POST", uri);
  // request.headers.addAll(_setHeaders());

  // // multipart that takes file
  // var multipartFile = new http.MultipartFile('doc$index', stream, length,
  //     filename: basename(imageFile.path));
  // request.fields['entry_id'] = '$id';

  // // add file to multipart
  // request.files.add(multipartFile);
  // // send
  // var response = await request.send();

  // // listen for response
  // response.stream.transform(utf8.decoder).listen((value) {
  //   var a = json.decode(value);
  // });
  // return response.statusCode;
}

fileuploadvitalko(imageFile, id, index) async {
  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(save_event_report_document);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile('doc$index', stream, length,
      filename: basename(imageFile.path));
  request.fields['entry_id'] = '$id';

  // add file to multipart
  request.files.add(multipartFile);
  // send
  var response = await request.send();

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    var a = json.decode(value);
  });
  return response.statusCode;
}

fileuploadTaxDocument(imageFile, id, field) async {
  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(taxDocument + '$id');

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile('$field', stream, length,
      filename: basename(imageFile.path));
  request.fields['owner_id'] = '$id';

  // add file to multipart
  request.files.add(multipartFile);
  // send
  var response = await request.send();

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    var a = json.decode(value);
  });
  return response.statusCode;
}

fileuploadLandPropertyDocument(imageFile, id, field) async {
  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(landDocument);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile(
    '$field',
    stream,
    length,
    filename: basename(imageFile.path),
  );
  request.fields['land_id'] = '$id';

  // add file to multipart
  request.files.add(multipartFile);
  // send
  var response = await request.send();

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    var a = json.decode(value);
  });
  return response.statusCode;
}

fileuploadHousePropertyDocument(imageFile, id, field) async {
  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(gharDocument);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile(
    '$field',
    stream,
    length,
    filename: basename(imageFile.path),
  );
  request.fields['house_id'] = '$id';

  // add file to multipart
  request.files.add(multipartFile);
  // send
  var response = await request.send();

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    var a = json.decode(value);
  });
  return response.statusCode;
}

fileuploadSifarishDocument(imageFile, id, fields) async {
  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(saveSifarisDocument);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile('$fields', stream, length,
      filename: basename(imageFile.path));
  request.fields['entry_id'] = '$id';

  // add file to multipart
  request.files.add(multipartFile);
  // send
  var response = await request.send();

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    var a = json.decode(value);
  });
  return response.statusCode;
}

childsifarishdocsupload(imageFile, id, index) async {
  // open a bytestream
  var stream = new http.ByteStream(imageFile.openRead());
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse(storechildimage);

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(_setHeaders());

  // multipart that takes file
  var multipartFile = new http.MultipartFile('doc$index', stream, length,
      filename: basename(imageFile.path));
  request.fields['child_id'] = '$id';

  // add file to multipart
  request.files.add(multipartFile);
  // send
  var response = await request.send();

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    var a = json.decode(value);
  });
  return response.statusCode;
}

Future<List<Emergencydata>?> emergencyAPitest(value) async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(new_emergencynumber, options: _cacheOptions);
  print(data.data['data']);
  if (data.data['data'] != null) {
    List<dynamic> list = data.data['data'];
    var emergencynumberdata =
        list.map((e) => Emergencydata.fromJson(e)).toList();
    List law = list == [] ? [] : list.where((o) => o['type'] == value).toList();

    return list == [] ? [] : law.map((e) => Emergencydata.fromJson(e)).toList();
  } else {
    return null;
  }
}

List dharmikplace = [];

Future<List<PalikaIntroData>> palikaintroApi() async {
  List list5 = [];
  _dio.interceptors.add(_dioCacheManager.interceptor);
  dynamic data = await _dio.get(intro, options: _cacheOptions);
  List<dynamic> list = data.data['data'];
  for (var listdata in list) {
    if (listdata['title'] != "धार्मिक स्थल / पर्यटकीय स्थल") {
      list5.add(listdata);
    }
  }

  // var k;
  // dharmikplace = [];

  // list[list.length - 1]['data'].forEach((k, v) => {
  //       k = {"key": k, "value": v},
  //       dharmikplace.add(k),
  //     });
  var palikaintrodata = list5.map((e) => PalikaIntroData.fromJson(e)).toList();
  return palikaintrodata;
}

sifarishpayment(data) async {
  getToken();
  http.Response response = await http.post(Uri.parse(sifarispaymentdetail),
      body: jsonEncode(data), headers: _setHeaders());

  if (response.statusCode == 200) {
    dynamic list = json.decode(response.body);
    if (list['status'] == true) {
      return list;
    } else {
      EasyLoading.showError('server_error'.tr);
      return null;
    }
  } else {
    EasyLoading.showError('server_error'.tr);
    return null;
  }
}

Future<int> applicationCountApi() async {
  getToken();
  http.Response response = await http.get(Uri.parse(applicatoinCountApiLink),
      headers: _setHeaders());

  if (response.statusCode == 200) {
    dynamic list = json.decode(response.body);
    return list["data"];
  } else {
    return 0;
  }
}

Future<DigitalProfileModal> digitalprofile() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(digitalprofiledata, options: _cacheOptions);
  var list = data.data['data'];

  DigitalProfileModal digitalProfiledata = DigitalProfileModal.fromJson(list);
  return digitalProfiledata;
}

Future<ToiletTablegraph> toiletgraphAPi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(toiletgraph, options: _cacheOptions);
  dynamic list = data.data;

  var literacychart = ToiletTablegraph.fromJson(list);
  return literacychart;
}

dynamic notificationhistoryAPi() async {
  getToken();

  http.Response response = await http.get(
    Uri.parse(general_notification),
    headers: _setHeaders(),
  );

  print(response.body);
  if (response.statusCode == 200) {
    EasyLoading.dismiss();
    dynamic list = json.decode(response.body);

    return list['data'];
  } else {
    EasyLoading.dismiss();
    // EasyLoading.showError('server_connection_error'.tr);
  }
}

dynamic personalnotificationhistoryAPi() async {
  getToken();

  http.Response response = await http.get(
    Uri.parse(user_notification),
    headers: _setHeaders(),
  );

  print(response.body);
  if (response.statusCode == 200) {
    EasyLoading.dismiss();
    dynamic list = json.decode(response.body);
    return list['data'];
  } else {
    throw Exception();
    EasyLoading.dismiss();
    // EasyLoading.showError('server_connection_error'.tr);
  }
}

//get district
Future<AddressModal> getAddressFromJson() async {
  final String addressJson =
      await rootBundle.loadString('assets/json/address.json');
  var res = await jsonDecode(addressJson);
  AddressModal address = AddressModal.fromMap(res);
  return address;
}

suggestionApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(suggestion),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      return d;
    } else {
      EasyLoading.dismiss();

      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

profileupdateApi(data) async {
  EasyLoading.show(status: 'Please wait...'.tr);
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(editprofile),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      EasyLoading.dismiss();
      return d;
    } else {
      EasyLoading.dismiss();
      var res = json.decode(response.body);
      if (res["message"] != null) {
        EasyLoading.showError(res["message"]);
        return;
      }
      EasyLoading.showError('तपाईंको जानकारी पठाउदा समस्या आयो।'.tr);
    }
  }
}

Future<List<NoticeModal>> noticeAPI() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(notice, options: _cacheOptions);
  List<dynamic> list = data.data['data'];

  var eventsapidata = list.map((e) => NoticeModal.fromJson(e)).toList();
  return eventsapidata;
}

Future<List<NewsNoticeModal>> newsnoticeAPI() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(newsnotice, options: _cacheOptions);
  List<dynamic> list = data.data['data'];

  var eventsapidata = list.map((e) => NewsNoticeModal.fromJson(e)).toList();
  return eventsapidata;
}

Future<NewsNoticeModal> walingthisweek() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(latestnews, options: _cacheOptions);
  var list = data.data['data'];
  var a;
  if (list['notice_id'] != null) {
    a = {
      'news_id': list['notice_id'],
      'title': list['title'],
      'news_date': list['notice_date'],
      'feature_img': list['feature_img'],
      "news_img": [],
      'link': list['link'],
      'detail': list['detail'],
      'news_file': list['pdf_files'],
      'created_at': list['created_at'],
    };
  } else {
    a = list;
  }

  NewsNoticeModal eventsapidata = NewsNoticeModal.fromJson(a);
  return eventsapidata;
}

taxdetailapi(data) async {
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(taxinfo),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError('${d['message']}');
      }
    } else {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();
      EasyLoading.showError('${d['message']}');
    }
  }
}

//send otp on entering tax id
taxpayerOTPSend(data) async {
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(taxSendOTP),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError('${d['message']}');
      }
    } else {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();
      EasyLoading.showError('${d['message']}');
    }
  }
}

taxotp(data) async {
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(taxoptverify),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();

      return d;
    } else {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();
      EasyLoading.showError('${d['message']}');
    }
  }
}

taxRegisterapi(data) async {
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(taxregister),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError('${d['message']}');
      }
    } else {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();
      EasyLoading.showError('${d['message']}');
    }
  }
}

//send tax Id
sendTaxIdForPayment(data) async {
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(sendTaxIdPayment),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError('${d['message']}');
      }
    } else {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();
      EasyLoading.showError('${d['message']}');
    }
  }
}

sifarishstatusApi(data) async {
  getToken();

  http.Response response =
      await http.get(Uri.parse(sifarishstatus), headers: _setHeaders());
  // print(token);
  if (response.statusCode == 200) {
    if (data == "unapproved") {
      var d = json.decode(response.body);

      return d['data']['unapproved'];
    }
    if (data == "approved") {
      var d = json.decode(response.body);
      return d['data']['approved'];
    }
  } else {
    EasyLoading.showError('server_connection_error'.tr);
  }
}

paymentfromsecondprofilepage(data) async {
  getToken();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(sifarishpaymentdetail),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      EasyLoading.dismiss();

      return d['data'];
    } else {
      dynamic d = json.decode(response.body);

      EasyLoading.dismiss();
      EasyLoading.showError('${d['message']}');
    }
  }
}

bool downloading = true;
String downloadingStr = "No data";
double download = 0.0;

Future<bool> dowloadButton(imageUrl) async {
  // Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
  try {
    String appDocDir = Platform.isAndroid
        ? await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) //FOR ANDROID
        : await getApplicationDocumentsDirectory().then((value) => value.path);
    String? downloadResult = await FlutterDownloader.enqueue(
      url: imageUrl,
      savedDir: appDocDir,
      showNotification: true,
      openFileFromNotification: true,
    );

    return true;
  } catch (e) {
    return false;
  }
}

Future getCountries() async {
  Dio dio = Dio();

  var response = await dio.get("https://api.printful.com/countries");
  try {
    switch (response.statusCode) {
      case 200:
        {
          List<dynamic> list = response.data['result'];
          return response.data;
        }
      case 100:
        {
          //print("Informational Response");
        }
        break;
      case 300:
        {
          //print("Redirecting");
        }
        break;
      case 500:
        {
          //print("Server Error");
        }
        break;
    }
  } catch (e) {}
}

Future getDistrict() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var response = await _dio.get(
      "https://dash.sipshala.com/api/province-district",
      options: _cacheOptions);
  var list = response.data;

  return list["districts"];
}

Future getLocalLevel() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var response = await _dio.get("https://dash.sipshala.com/api/district-local",
      options: _cacheOptions);
  try {
    switch (response.statusCode) {
      case 200:
        {
          var list = response.data;
          return list["local_levels"];
        }
    }
  } catch (e) {}
}

birthformApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(birthform),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      if (d['status'] == true) {
        return d['data'];
      } else {
        EasyLoading.showError('email_or_password_incorrect'.tr);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

divorceformApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(divorceform),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    // {"status":"true","success":true,"data":"DivorceForm Added","message":"Success","entry_id":26}

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      //
      //print(d['status'].runtimeType);

      if (d['status'] == true) {
        //
        var data = {"entry_id": d['entry_id'], "form_name": d['data']};
        //print('inside status true');
        return data;
      } else {
        //print('inside Please fill form correctly');
        EasyLoading.showError('please_check_all_fields'.tr);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

deviceregisterApi(token) async {
  var request = {
    "mob_user": "true",
    "house_num": "0",
    "gcm_token": token,
    //"password": "admin@1234",
    "people_id": "2"
  };
  http.Response response = await http.post(
    Uri.parse(registerdevice),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  //print(request);

  if (response.statusCode == 200) {
    dynamic d = json.decode(response.body);
    return d;
  }
}

List bardata = [];
barchartsAPi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(barcharts, options: _cacheOptions);
  var list = data.data;
  return list;
}

Future<BarchartModal> barchartdata() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(barchart, options: _cacheOptions);
  var list = data.data;
  var populationData = list['population_data'];
  bardata.add({'title': 'population_data', 'data': populationData});
  var ageDist = list['age_dist'];
  bardata.add({'title': 'age_dist', 'data': ageDist});
  var motherLanguage = list['mother_language'];
  bardata.add({'title': 'mother_language', 'data': motherLanguage});
  var toiletType = list['toilet_type'];
  bardata.add({'title': 'toilet_type', 'data': toiletType});
  var waterType = list['water_type'];
  bardata.add({'title': 'water_type', 'data': waterType});
  var fuelType = list['fuel_type'];
  bardata.add({'title': 'fuel_type', 'data': fuelType});
  var electricityType = list['electricity_type'];
  bardata.add({'title': 'electricity_type', 'data': electricityType});
  var literacyWoda = list['literacy_woda'];
  bardata.add({'title': 'literacy_woda', 'data': literacyWoda});
  var roadType = list['road_type'];
  bardata.add({'title': 'road_type', 'data': roadType});
  var familyCount = list['family_count'];
  bardata.add({'title': 'family_count', 'data': familyCount});

  BarchartModal bchartdata = BarchartModal.fromJson(list);
  return bchartdata;
}

barchartdatawithoutmodal() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(barchart, options: _cacheOptions);
  var list = data.data;
  var populationData = list['population_data'];
  bardata.add({'title': 'population_data', 'data': populationData});
  var ageDist = list['chart_data_age_dist'];
  bardata.add({'title': 'age_dist', 'data': ageDist});
  var motherLanguage = list['mother_language'];
  bardata.add({'title': 'mother_language', 'data': motherLanguage});
  var toiletType = list['toilet_type'];
  bardata.add({'title': 'toilet_type', 'data': toiletType});
  var waterType = list['water_type'];
  bardata.add({'title': 'water_type', 'data': waterType});
  var fuelType = list['fuel_type'];
  bardata.add({'title': 'fuel_type', 'data': fuelType});
  var electricityType = list['electricity_type'];
  bardata.add({'title': 'electricity_type', 'data': electricityType});
  var literacyWoda = list['literacy_woda'];
  bardata.add({'title': 'literacy_woda', 'data': literacyWoda});
  var roadType = list['road_type'];
  bardata.add({'title': 'road_type', 'data': roadType});
  var familyCount = list['family_count'];
  bardata.add({'title': 'family_count', 'data': familyCount});

  return bardata;
}

Future<List<Eventsapi>?> eventsAPis() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(events, options: _cacheOptions);
  List<dynamic> list = data.data['data'];

  var eventsapidata = data.data['data'] == []
      ? null
      : list.map((e) => Eventsapi.fromJson(e)).toList();
  return eventsapidata;
}

deathformApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(deathform),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);

      if (d['status'] == true) {
        return d['data'];
      } else {
        EasyLoading.showError('email_or_password_incorrect'.tr);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

Future<dynamic> esewaVerifyApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    await getToken();
    http.Response response = await http.post(
      Uri.parse(esewaVerityApi),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    print(response);
    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      return d;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

khaltiverfyApi(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();

    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    await getToken();
    http.Response response = await http.post(
      Uri.parse(khaltiverifyapi),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      dynamic d = json.decode(response.body);
      print(d.toString());
      return d;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('server_connection_error'.tr);
    }
  }
}

// tax registration step1
posttaxpayerdetails(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(taxpayerdetail),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    dynamic d = json.decode(response.body);

    if (response.statusCode == 200) {
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError(d['message']);
        return false;
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(d['message']);
    }
  }
}

List pdfArray = [];
Future<List<RajpatraData>> rajpatraApi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  var data = await _dio.get(rajpatra, options: _cacheOptions);
  var list = data.data['data'];

  for (var mapEntry in list.entries) {
    var kv = {'key': mapEntry.key, 'value': mapEntry.value};
    pdfArray.add(kv);
  }
  //print('pdfArray$pdfArray');
  var rajpatradata = pdfArray.map((e) => RajpatraData.fromJson(e)).toList();
  pdfArray.clear();
  return rajpatradata;
}

postLandPropertydetails(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(landregister),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    dynamic d = json.decode(response.body);

    if (response.statusCode == 200) {
      if (d['status'] == true) {
        return d['data'];
      } else {
        EasyLoading.showError(d['message']);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(d['message']);
    }
  }
}

postGharPropertydetails(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    EasyLoading.dismiss();
    EasyLoading.showError('no_internet_connection'.tr);
  } else {
    http.Response response = await http.post(
      Uri.parse(gharregister),
      headers: _setHeaders(),
      body: jsonEncode(data),
    );

    dynamic d = json.decode(response.body);

    if (response.statusCode == 200) {
      if (d['status'] == true) {
        return d;
      } else {
        EasyLoading.showError(d['message']);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(d['message']);
    }
  }
}

Future<List<NewsNoticeModelWordpress>> wordpressApi() async {
  _dio.interceptors.add(_dioCacheManager.interceptor);
  try {
    var response = await _dio.get(wordpressKMCApiLink,
        options: buildCacheOptions(Duration(days: 30), forceRefresh: true));
    var list = List<NewsNoticeModelWordpress>.from(
        response.data.map((x) => NewsNoticeModelWordpress.fromMap(x)));
    return list;
  } catch (e) {
    print(e);
    throw Exception(e);
  }
}

//appointment
Future<bool> createAppointment(AppointmentModal appointmentModal) async {
  http.Response response = await http.post(
    Uri.parse(appointment),
    headers: _setHeaders(),
    body: jsonEncode(appointmentModal.toMap()),
  );
  // await _dio.post(appointment, data: FormData.fromMap();
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<dynamic>> dropdownData() async {
  var data = [];
  _dio.options.headers = _setHeaders();
  var response1 = await _dio.get(appointmentMayor);
  print(response1.data['message']);
  var response2 = await _dio.get(appointmentSallahkar);

  var data1 = response1.data['data'];
  var data2 = response2.data['data'];
  var finalData2 = [];
  final userList = (data2 as List).map((userJson) {
    final name = userJson['name'] as String;
    final id = userJson['user_id'] as int;
    final designation = userJson['designation'] as String;
    return {'id': id, 'name': name, 'designation': designation};
  }).toList();
  print(userList.toList());
  var data3 = userList.toList();
  data = [...data1, ...data3];
  print(data);
  return data;
}

Future<AppointmentList> getAppointment() async {
  _dio.options.headers = _setHeaders();
  try {
    var response = await _dio.get(appointmentList);
    return AppointmentList.fromJson(response.data);
  } on DioError catch (e) {
    throw Exception(e.toString());
  }
}

Future<NearbyPlaces> getNearbyPlaces(data_type) async {
  _dio.options.headers = _setHeaders();
  var status = await Permission.location.request();
  if (status == PermissionStatus.granted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 10),
    );
    print(position);
    try {
      String latitude = position.latitude.toStringAsFixed(3);
      String longitude = position.longitude.toStringAsFixed(3);
      double desiredLatitude = double.parse(latitude);
      double desiredLongitude = double.parse(longitude);
      var response = await _dio.post(nearby_place, data: {
        "data_type": data_type,
        "latitude": desiredLatitude,
        "longitude": desiredLongitude,
      });
      if (response.statusCode == 200) {
        print(response.data.toString());
        return NearbyPlaces.fromJson(response.data);
      }
    } catch (e) {
      throw EasyLoading.showError("server_error".tr);
    }
  } else {
    throw EasyLoading.showError("permission_request".tr);
  }
  throw Container();
}

maintain(context) async {
  try {
    var response = await _dio.get(server_maintain);
    //
    //   if(response.data['status'] = true){
    //   return showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //  builder: (builder){
    //   return Center(
    //     child: Stack(
    //       children: [
    //         SizedBox(
    //           height: 300,
    //           child: Dialog(
    //             alignment: Alignment.center,
    //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    //             backgroundColor: Colors.white,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 SizedBox(height: 10,),
    //                 Icon(Icons.error, color: Colors.black, size: 50,),
    //                SizedBox(height: 20,),
    //                 Expanded(
    //                   flex: 2,
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //                     child: Text(
    //                       'आदरणीय प्रयोगकर्ताहरू,हाम्रो सर्भर मर्मत र अप्डेट भइरहेको छ। सर्भर  अप्डेटको कारण हुनगयको असुविधाको लागि हामी क्षमाप्रार्थी छौं।',
    //                       style: TextStyle(color: Colors.black, fontSize: 18),

    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: tertiary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), onPressed: (){Navigator.popUntil(context, (route) => false);}, icon: Icon(Icons.error_outline_rounded), label: Text("cancel".tr),)
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );

    //  }
    //  );
    //   }
  } catch (e) {
    return showDialog(
        context: context,
        builder: (builder) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Dialog.fullscreen(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'आदरणीय प्रयोगकर्ताहरू,हाम्रो सर्भर मर्मत र अप्डेट भइरहेको छ। सर्भर  अप्डेटको कारण हुनगयको असुविधाको लागि हामी क्षमाप्रार्थी छौं।',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
