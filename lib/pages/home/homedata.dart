import 'package:kmc/modal/dummymodal.dart';
import 'package:kmc/pages/business.dart';
import 'package:kmc/pages/digitalprofile/dphome.dart';
import 'package:kmc/pages/emergency/emergency.dart';
import 'package:kmc/pages/hellomayor/hellomayorEntry.dart';
import 'package:kmc/pages/hellomayor/janagunaso/gunasoEntry.dart';
import 'package:kmc/pages/hellomayor/nyayiksamiti/nyayikEntry.dart';
import 'package:kmc/pages/parichaya.dart';
import 'package:kmc/pages/paryatak_sthal.dart';
import 'package:kmc/pages/pratinidhikarmachari/pratinidhikarmachari.dart';
import 'package:kmc/pages/pratinidhiwordpress/screen/pratinidhiwordpress.dart';
import 'package:kmc/pages/rajpatra.dart';
import 'package:kmc/pages/sewa/sifarish/sifarish.dart';
import 'package:kmc/pages/sewa/sifarish_new/screens/sifarish_dashboard_screen.dart';
import 'package:kmc/pages/tax/taxInAppView.dart';
import 'package:kmc/pages/tax/taxhome.dart';
import 'package:kmc/pages/wodajankari.dart';
import 'package:kmc/pages/wodapatra/citizencharter.dart';
import 'package:kmc/pages/yojana/yojana.dart';

import '../toilet.dart';

class HomeData {
  final String icon;
  final String title;
  final link;
  final String nepaliname;
  // final bool permit;

  HomeData(this.title, this.icon, this.nepaliname, {this.link});
}

var link = 'assets/images/icons/newIcons/';
final List<HomeData> homeData = [
  HomeData('Administration', link + 'Prasaasan.svg', 'प्रशासन'),
  HomeData('Education', link + 'Sikshya_Full.svg', 'शिक्षा'),
  HomeData('Health', link + 'Swasthya_Full.svg', 'स्वास्थ्य'),
  HomeData('Notices', link + 'SuchanaPrawidhi.svg', 'सूचना प्रविधि'),
  HomeData('Revenue', link + 'Lekhaa.svg', 'राजस्व'),
  HomeData('Law / Human Rights', link + 'Kaanun.svg', 'कानून तथा मानव अधिकार'),
  HomeData('Urban Management', link + 'PurwadharBikash.svg', 'सहरी व्यवस्थापन'),
  HomeData(
      'Public Construction', link + 'Punarnirmaan.svg', 'सार्वजनिक निर्माण'),
  HomeData('Finance', link + 'Rojgaar.svg', 'बित्त'),
  HomeData('Social Development', link + 'Yojanaa.svg', 'सामाजिक विकास'),
  // HomeData('Cooperative', link + 'sahakari.png', 'सहकारी'),
  HomeData('Environment / Agri', link + 'Krishi_Full.svg', 'वातावरण तथा कृषि'),
  // HomeData('Disaster Mgmt', link + '', 'विपद व्यवस्थापन'),
  // HomeData('Heritage and Tourism', link + '', 'सम्पदा तथा पर्यटन'),
];

class Sewa {
  final String title;
  final String icon;
  final List sewadata;
  dynamic link;
  Sewa(this.title, this.icon, this.sewadata, this.link);
}

final List<Sewa> sewa = [
  Sewa('sanchar', link + 'Sifaarish.svg', sewaData.sublist(3, 6), null),
  Sewa('sewas', link + 'Sifaarish.svg', sewaData.sublist(0, 2), Sifarish()),
  Sewa('jankari', link + 'Sifaarish.svg', sewaData.sublist(6,9), null),
];

class SewaData {
  final String icon;
  final String title;
  final String details;
  final link;
  final bool permit;
  SewaData(this.title, this.icon, this.details, this.link, this.permit);
}

final List<SewaData> sewaData = [
  //first
  SewaData('sifaris', link + 'Sifaarish.svg', 'sewa_desc',
      SifarishDashboardScreen(), true),
  SewaData('smart_tax', link + 'SmartTax.svg', 'tax_desc', TaxAppView(), true),
  //Tax();

  SewaData('event-reports', link + 'vital.svg', 'vital_desc', '', true),

  //2nd
  SewaData('hello_mayor', link + 'HelloMayor.svg', 'hm_desc', HellomayorEntry(),
      true),
  SewaData('janagunaso', link + 'JanaGunaso.svg', 'jg_desc', JanaGunasoEntry(),
      true),
  SewaData('Judicial_committee', link + 'JanaGunaso.svg', 'jg_desc',
      NyayikEntry(), true),

  //3rd
  SewaData('prati_karma', link + 'karmachari.svg', 'rk_desc', PratinidhiWordpress(),
      false),
  SewaData('wodapatra', link + 'NagarikWadapatra.svg', 'wodapatra_desc',
      CitizenCharter(), false),
  SewaData('digital_profile', link + 'DigitalProfile.svg', 'dp_desc',
      Digitalprofile(), false),
];

class GridData {
  final String icon;
  final String title;
  final link;
  GridData(this.title, this.icon, this.link);
}

final List<GridData> gridData = [
  GridData('intro', link + 'Parichaya_Full.svg', Parichaya()),
  GridData('ward', link + 'Wada_Full.svg', Wodajankari()),
  // GridData('yojana', link + 'Yojanaa.svg', Yojana()),
  // GridData('byapar', link + 'Byapar_Full.svg', Business()),
  // GridData('utpadan', link + 'Utpadan_Full.svg', Wodajankari()),
  GridData('emergency-services', link + 'Emergency.svg', Emergency()),
  GridData('Tourism_site', link + 'location.svg', Paryatak_Sthal()),
  GridData('rajpatra', link + 'wadapatra_TaxLaw.svg', Rajpatra()),
  GridData('toilet', link + 'toilet_new.svg', Toilet()),
  // GridData('dev_partners', link + 'Bikash_Full.svg', DevPartners()),
];

class BibhagData {
  final String icon;
  final String title;
  final link;
  BibhagData(this.title, this.icon, this.link);
}

final List<BibhagData> bibhagData = [
  BibhagData('संस्थाहरु', link + 'sanstha.svg', ''),
  BibhagData('वालबिकास', link + 'balbaalika.svg', ''),
  BibhagData('तालिम केन्द्र', link + 'TalimKendra.svg', ''),
  BibhagData('जानकारी', link + 'jaankaari.svg', ''),
];
