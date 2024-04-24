import 'package:kmc/pages/hellomayor/hellomayorEntry.dart';
import 'package:kmc/pages/sewa/sifarish_new/screens/sifarish_list_screen.dart';

var link = 'assets/images/icons/newIcons/';

class SifarishData {
  final String icon;
  final String title;
  final String details;
  final link;
  final bool? permit;
  SifarishData(this.title, this.icon, this.details, this.link, {this.permit});
}

final List<SifarishData> sifarishData = [
  //first
  SifarishData(
      'sifaris', link + 'Sifaarish.svg', 'sewa_desc', HellomayorEntry()),
  SifarishData(
      'smart_tax', link + 'SmartTax.svg', 'tax_desc', HellomayorEntry()),
  SifarishData('events-report', link + 'ghatana_darta.svg', 'ghatana_desc',
      HellomayorEntry()),
  SifarishData(
      'emap_pass', link + 'enaksha.svg', 'enaksha_desc', HellomayorEntry()),
];

class BhuktaaniGridData {
  final String icon;
  final String title;
  final link;
  BhuktaaniGridData(this.title, this.icon, this.link);
}

final List<BhuktaaniGridData> bhuktaanigridData = [
  BhuktaaniGridData('nea', link + 'nea.svg', ''),
  BhuktaaniGridData('khanepani', link + 'khanepani.svg', ''),
  BhuktaaniGridData('dishhome', link + 'dishhome.svg', ''),
  BhuktaaniGridData('adsl', link + 'adsl.svg', ''),
  BhuktaaniGridData('worldlink', link + 'worldlink.svg', ''),
  BhuktaaniGridData('topup', link + 'topup.svg', ''),
];

class SifarishInsideData {
  final String icon;
  final String title;
  final link;
  final bool? permit;
  SifarishInsideData(this.title, this.icon, this.link, {this.permit});
}

final List<SifarishInsideData> sifarishInsideData = [
  //first
  SifarishInsideData(
    'नागरिकता सिफारिश',
    link + 'nagarikta_sifarish.svg',
    HellomayorEntry(),
    permit: null,
  ),
  SifarishInsideData(
      'घर/जग्गा/बाटो सिफारिश', link + 'ghar_sifarish.svg', HellomayorEntry()),
  SifarishInsideData(
      'उपभोक्ता सिफारिश', link + 'upabhogta_sifarish.svg', HellomayorEntry()),
  SifarishInsideData(
      'पञ्जीकरण सिफारिश', link + 'panjikaran_sifarish.svg', HellomayorEntry()),
  SifarishInsideData(
      'कर सिफारिश', link + 'tax_sifarish.svg', HellomayorEntry()),
  SifarishInsideData(
      'अन्य सिफारिश', link + 'anya_sifarish.svg', HellomayorEntry()),
];

class StaticSifarishDataModel {
  final String title;
  final String image;
  final SifarishTypeEnum sifarishTypeEnum;
  StaticSifarishDataModel({
    required this.sifarishTypeEnum,
    required this.title,
    required this.image,
  });
}

final List<StaticSifarishDataModel> sifarishInsideDataModel = [
  //first
  StaticSifarishDataModel(
    title: 'नागरिकता सिफारिश',
    image: link + 'nagarikta_sifarish.svg',
    sifarishTypeEnum: SifarishTypeEnum.nagarikta,
  ),
  StaticSifarishDataModel(
    title: 'घर/जग्गा/बाटो सिफारिश',
    image: link + 'ghar_sifarish.svg',
    sifarishTypeEnum: SifarishTypeEnum.gharJaggaBato,
  ),
  StaticSifarishDataModel(
    title: 'उपभोक्ता सिफारिश',
    image: link + 'upabhogta_sifarish.svg',
    sifarishTypeEnum: SifarishTypeEnum.upabhokta,
  ),
  StaticSifarishDataModel(
    title: 'पञ्जीकरण सिफारिश',
    image: link + 'panjikaran_sifarish.svg',
    sifarishTypeEnum: SifarishTypeEnum.panjikaran,
  ),
  StaticSifarishDataModel(
    title: 'कर सिफारिश',
    image: link + 'tax_sifarish.svg',
    sifarishTypeEnum: SifarishTypeEnum.kar,
  ),
  StaticSifarishDataModel(
    title: 'अन्य सिफारिश',
    image: link + 'anya_sifarish.svg',
    sifarishTypeEnum: SifarishTypeEnum.anya,
  ),
];
