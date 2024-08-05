import 'package:kmc/config/replaceable.dart';

const BASE_URL = Config.base_url;
const BASE_URL_API = Config.base_url_api;


const BASE_URL_FOR_TOILET_TEST = Config.base_url_for_toilet;


const digitalprofiledata =
    '$BASE_URL_API/profiledata'; //get badapatra completed
const religiouschartdata = '$BASE_URL_API/piechart'; //get badapatra completed
const barchartdata = '$BASE_URL_API/barchart';
const pratinidhiandkarmachari = '$BASE_URL_API/get-pratinidhi';
// const pratinidhiandkarmachari = '$BASE_URL/api/pratinidhi';
// const pratinidhiandkarmachari1 = '$BASE_URL_API/get-pratinidhi';
const rajpatra = '$BASE_URL/api/rajpatra';
const wodapatra = '$BASE_URL_API/nagarik-wodapatra';
const intro = '$BASE_URL_API/palika-intro';
const wodajanakariurl = '$BASE_URL_API/woda-jankari';
const userImage = '$BASE_URL/images/user/';
const villagedatasearch = '$BASE_URL_API/village-profile-by-data';
const nagarkarmachari = '$BASE_URL_API/get-karmachari';
// const wodakarmachari = '$BASE_URL_API/woda-karmachari';
const wodakarmachari = '$BASE_URL_API/woda-karmachari';
const exkarmachari = '$BASE_URL/api/karmachari/dismissed';

const emergencynumber = '$BASE_URL_API/gethospital';
const new_emergencynumber = '$BASE_URL/api/emergency-services';
const events = '$BASE_URL_API/event';
// const yojana = '$BASE_URL/yojana/api/project-progress';
const yojana = '$BASE_URL_API/get-all-pariyojana';
const localProduction = '$BASE_URL_API/local-production';
const eventsimagewaling = '$BASE_URL/images/event/';
const newsnotice = '$BASE_URL/news/api';
const notice = '$BASE_URL/api/notice/all';
const latestnews = '$BASE_URL_API/latest-news-notice';
const noticeimage = '$BASE_URL/images/notice/feature_img/';
const newsimage = '$BASE_URL/images/news/feature_img/';
const volunteerdata = '$BASE_URL_API/volunteerdata';
const tendernotice = '$BASE_URL_API/tender-notice';
const login = '$BASE_URL/loginapi/login';
const logout = '$BASE_URL/loginapi/logout';

const user_image = '$BASE_URL/images/user/';
const signup_image = '$BASE_URL/loginapi/user-image';
const citizenshipuploadurl = '$BASE_URL/loginapi/citizenship-store';
const signup = '$BASE_URL/loginapi/register';
const verifySignUp = '$BASE_URL/loginapi/signup-verify';
const resendemailotp = '$BASE_URL/loginapi/resend-OTP';
const verifyapi = '$BASE_URL/loginapi/signup-verify';
const suggestion = '$BASE_URL_API/suggestion';
const tokenregister = '$BASE_URL_API/has-login-register';
const chatimage = '$BASE_URL_API/images/chat_images/';
const applicatoinCountApiLink = '$BASE_URL/sifarish/api/get-sifarish-count';

const forgotpasswordopt = '$BASE_URL/loginapi/forget-password';
const checkforgotopt = '$BASE_URL/loginapi/verify-household-OTP';
const updatepassword = '$BASE_URL/loginapi/household-user-update';
const householdverify = '$BASE_URL/loginapi/household-verify';
const litracychart =
    '$BASE_URL/villagereport/mobile-app/population-woda-literacy';
//Pusher
const pusher_authorize = '$BASE_URL/loginapi/authorize-pusher';
//All chats
const checkmayor = '$BASE_URL/hellomayor/mobile-app/check-mayor';
const checkupamayor = '$BASE_URL/nyayiksamiti/mobile-app/check-upamayor';
const checksuchana = '$BASE_URL/janagunaso/mobile-app/check-suchana-adhikari';
//Hello Mayor
const mayorchatlist = '$BASE_URL/hellomayor/mobile-app/upamayorinteract';
const hMchatfromuser = "$BASE_URL/hellomayor/mobile-app/hellomayor";
const getMsgFromUserHM = "$BASE_URL/hellomayor/mobile-app/getmessage";
const storechatHM = "$BASE_URL/hellomayor/mobile-app/storechat";
const mayorchathistory = "$BASE_URL/hellomayor/mobile-app/";
//Janagunaso
const gunasochatlist = '$BASE_URL/janagunaso/mobile-app/upamayorinteract';
const jGchatfromuser = "$BASE_URL/janagunaso/mobile-app/janagunaso";
const getMsgFromUserJG = "$BASE_URL/janagunaso/mobile-app/getmessage";
const storechatJG = "$BASE_URL/janagunaso/mobile-app/storechat";
const gunasochathistory = "$BASE_URL/janagunaso/mobile-app/";
//Nyayik Samiti
const nyayikchatlist = '$BASE_URL/nyayiksamiti/mobile-app/upamayorinteract';
const NSchatfromuser = "$BASE_URL/nyayiksamiti/mobile-app/nyayiksamiti";
const getMsgFromUserNS = "$BASE_URL/nyayiksamiti/mobile-app/getmessage";
const storechatNS = "$BASE_URL/nyayiksamiti/mobile-app/storechat";
const nyayikchathistory = "$BASE_URL/nyayiksamiti/mobile-app/";
//
const toiletgraph = "'$BASE_URL/villagereport/mobile-app/house-toilet-type";
const religiongraph = "$BASE_URL/villagereport/mobile-app/house-toilet-type";
const chatimageurl = '$BASE_URL/images/chat_images/';

//bibagh Api
const bibagh = '$BASE_URL/bibhag/api/fetch-bibhag-details';
// https://walingstaging.smartpalika.io/bibhag/api/fetch-bibhag-details
//sifarish
const sifarishmainlist = '$BASE_URL/sifarish/api/get-all-sifarish';
const sifarishnata = '$BASE_URL_API/sifarish-naata';
const sifarishbasicform = '$BASE_URL/sifarish/api/get-sifarish-form-by-id';
const getchildsifarishfield = '$BASE_URL/sifarish/api/get-child-form-by-id';
const childsifarishstore = '$BASE_URL/sifarish/api/store-child';
const storechildimage = '$BASE_URL/sifarish/api/sifarish-child-image';
const receipt = '$BASE_URL/paymentmodule/mobile-app/invoices';
const sifarishpaymentdetail =
    '$BASE_URL/paymentmodule/mobile-app/payment-detail';
const saveSifaris = '$BASE_URL/sifarish/api/store-sifarish';
const saveSifarisDocument = '$BASE_URL/sifarish/api/store-sifarish-document';
const sifarisstatushcheck = '$BASE_URL/sifarish/api/sifarish-image-verify';
const sifarispaymentdetail = '$BASE_URL/sifarish/api/sifarish-payment';
const ipsnpapost =
    'https://connectips.com/connectipswebgw/loginpage'; //Connect IPS URL
//business
const getBusinessListings = '$BASE_URL_API/village-profile-by-data';
const connectips_payment = '$BASE_URL/paymentmodule/ips-payment';

//household login
const household_check = '$BASE_URL/loginapi/check-household';
const verify_otp = '$BASE_URL/loginapi/verify-household-OTP';
const household = '$BASE_URL/loginapi/household';
const householdlogincheck = '$BASE_URL/loginapi/household-login-check';
const passwordset = '$BASE_URL/loginapi/household-user-update';
const askotp = '$BASE_URL/loginapi/household-OTP';
const emailotpask = '$BASE_URL/loginapi/resend-OTP';
const emailforgotpass = '$BASE_URL/loginapi/forget-password';
const setpassword = '$BASE_URL/loginapi/submit-password';
const userimagechange = '$BASE_URL/loginapi/user-image';

const general_notification =
    '$BASE_URL/pushnotification/api/general-notification';
const user_notification = '$BASE_URL/pushnotification/api/user-notification';

//second profile page data jaha chai sifarish haru ko status auuxa
const sifarishstatus = '$BASE_URL_API/profile';
const editprofile = '$BASE_URL/loginapi/update'; //profile edit
const updateprofileimage = '$BASE_URL/loginapi/user-image'; //profile edit

const sifarishpaymentdetailforsecondprofilepage =
    '$BASE_URL/paymentmodule/mobile-app/payment-detail';

const khaltiverifyapi = '$BASE_URL/paymentmodule/mobile-app/khalti-verify';
const esewaVerityApi =
    '$BASE_URL/paymentmodule/mobile-app/verify/esewa/verification';

//tax payment
const taxinfo = '$BASE_URL/apilink/e-tax'; //etax API
const taxoptverify = '$BASE_URL/apilink/e-tax-verify';
const taxregister = '$BASE_URL/etax/api/taxpayer';
const taxDocument = '$BASE_URL/etax/api/taxpayer-docs/';
const taxRegisterOTP = "$BASE_URL/etax/api/send-otp";
const taxRegisterSumbit = "$BASE_URL/etax/api/taxpayer-verify";
const getTaxPayerlist = "$BASE_URL/etax/api/check-taxpayer";
const sendTaxIdPayment =
    "$BASE_URL/etax/payment/taxpayer-info"; // tax payment step1
const verifyPaymentRequest = "$BASE_URL/etax/payment/verify-payment-request";
const taxSendOTP = '$BASE_URL/etax/payment/taxpayer-info'; //etax API

//land property
const landregister = '$BASE_URL/etax/api/tax-property-land';
const landDocument = '$BASE_URL/etax/api/tax-property-land-docs';
const landRegisterVerify = '$BASE_URL/etax/api/tax-property-land-verify';

// ghar property
const gharregister = '$BASE_URL/etax/api/create-house-detail';
const gharDocument = '$BASE_URL/etax/api/tax-property-house-docs';

//vital registration

const registerdevice = '$BASE_URL_API/register';

//graph api
const barcharts = '$BASE_URL/villagereport/api/barchart'; //barchart API
const barchart = '$BASE_URL/villagereport/api/barchart'; //barchart API

//form registration
const birthform = '$BASE_URL_API/birthform-data';
const deathform = '$BASE_URL_API/deathform-data';
const divorceform = '$BASE_URL_API/divorceform-data';
const save_event_report_document =
    '$BASE_URL_API/vital-registration-documents'; //vital documents post
const vital_status_check =
    '$BASE_URL_API/vital-image-verify'; //vital documents verify
const vital_payment_detail = '$BASE_URL_API/vital-payment'; //vital payment

//IPT Tax module
const taxpayerdetail = '$BASE_URL/etax/api/taxpayer';

//KMC Wordpress Api
const wordpressKMCApiLink = 'https://kathmandu.gov.np/api/articles-api';

//appointment
const appointment = '$BASE_URL/api/appointment/store';
const appointmentMayor = '$BASE_URL/api/appointment/secretariat_mayor_upamayor';
const appointmentSallahkar = '$BASE_URL/api/appointment/secretariat';
const appointmentList =  '$BASE_URL/api/appointment/user_appointment';


abstract class CustomURL {
  static const BASE_URL = Config.base_url;
  static const BASE_URL_API = Config.base_url_api;
  static const digitalprofiledata =
      '$BASE_URL_API/profiledata'; //get badapatra completed
  static const religiouschartdata =
      '$BASE_URL_API/piechart'; //get badapatra completed
  static const barchartdata = '$BASE_URL_API/barchart';
  static const pratinidhiandkarmachari = '$BASE_URL_API/get-pratinidhi';
// static const pratinidhiandkarmachari = '$BASE_URL/api/pratinidhi';
// static const pratinidhiandkarmachari1 = '$BASE_URL_API/get-pratinidhi';
  static const rajpatra = '$BASE_URL/api/rajpatra';
  static const wodapatra = '$BASE_URL_API/nagarik-wodapatra';
  static const intro = '$BASE_URL_API/palika-intro';
  static const wodajanakariurl = '$BASE_URL_API/woda-jankari';
  static const userImage = '$BASE_URL/images/user/';
  static const villagedatasearch = '$BASE_URL_API/village-profile-by-data';
  static const nagarkarmachari = '$BASE_URL_API/get-karmachari';
// static const wodakarmachari = '$BASE_URL_API/woda-karmachari';
  static const wodakarmachari = '$BASE_URL_API/woda-karmachari';
  static const exkarmachari = '$BASE_URL/api/karmachari/dismissed';

  static const emergencynumber = '$BASE_URL_API/gethospital';
  static const events = '$BASE_URL_API/event';
// static const yojana = '$BASE_URL/yojana/api/project-progress';
  static const yojana = '$BASE_URL_API/get-all-pariyojana';
  static const localProduction = '$BASE_URL_API/local-production';
  static const eventsimagewaling = '$BASE_URL/images/event/';
  static const newsnotice = '$BASE_URL/news/api';
  static const notice = '$BASE_URL/api/notice/all';
  static const latestnews = '$BASE_URL_API/latest-news-notice';
  static const noticeimage = '$BASE_URL/images/notice/feature_img/';
  static const newsimage = '$BASE_URL/images/news/feature_img/';
  static const volunteerdata = '$BASE_URL_API/volunteerdata';
  static const tendernotice = '$BASE_URL_API/tender-notice';
  static const login = '$BASE_URL/loginapi/login';
  static const logout = '$BASE_URL/loginapi/logout';

  static const user_image = '$BASE_URL/images/user/';
  static const signup_image = '$BASE_URL/loginapi/user-image';
  static const citizenshipuploadurl = '$BASE_URL/loginapi/citizenship-store';
  static const signup = '$BASE_URL/loginapi/register';
  static const verifySignUp = '$BASE_URL/loginapi/signup-verify';
  static const resendemailotp = '$BASE_URL/loginapi/resend-OTP';
  static const verifyapi = '$BASE_URL/loginapi/signup-verify';
  static const suggestion = '$BASE_URL_API/suggestion';
  static const tokenregister = '$BASE_URL_API/has-login-register';
  static const chatimage = '$BASE_URL_API/images/chat_images/';
  static const applicatoinCountApiLink =
      '$BASE_URL/sifarish/api/get-sifarish-count';

  static const forgotpasswordopt = '$BASE_URL/loginapi/forget-password';
  static const checkforgotopt = '$BASE_URL/loginapi/verify-household-OTP';
  static const updatepassword = '$BASE_URL/loginapi/household-user-update';
  static const householdverify = '$BASE_URL/loginapi/household-verify';
  static const litracychart =
      '$BASE_URL/villagereport/mobile-app/population-woda-literacy';
//Pusher
  static const pusher_authorize = '$BASE_URL/loginapi/authorize-pusher';
//All chats
  static const checkmayor = '$BASE_URL/hellomayor/mobile-app/check-mayor';
  static const checkupamayor =
      '$BASE_URL/nyayiksamiti/mobile-app/check-upamayor';
  static const checksuchana =
      '$BASE_URL/janagunaso/mobile-app/check-suchana-adhikari';
//Hello Mayor
  static const mayorchatlist =
      '$BASE_URL/hellomayor/mobile-app/upamayorinteract';
  static const hMchatfromuser = "$BASE_URL/hellomayor/mobile-app/hellomayor";
  static const getMsgFromUserHM = "$BASE_URL/hellomayor/mobile-app/getmessage";
  static const storechatHM = "$BASE_URL/hellomayor/mobile-app/storechat";
  static const mayorchathistory = "$BASE_URL/hellomayor/mobile-app/";
//Janagunaso
  static const gunasochatlist =
      '$BASE_URL/janagunaso/mobile-app/upamayorinteract';
  static const jGchatfromuser = "$BASE_URL/janagunaso/mobile-app/janagunaso";
  static const getMsgFromUserJG = "$BASE_URL/janagunaso/mobile-app/getmessage";
  static const storechatJG = "$BASE_URL/janagunaso/mobile-app/storechat";
  static const gunasochathistory = "$BASE_URL/janagunaso/mobile-app/";
//Nyayik Samiti
  static const nyayikchatlist =
      '$BASE_URL/nyayiksamiti/mobile-app/upamayorinteract';
  static const NSchatfromuser =
      "$BASE_URL/nyayiksamiti/mobile-app/nyayiksamiti";
  static const getMsgFromUserNS =
      "$BASE_URL/nyayiksamiti/mobile-app/getmessage";
  static const storechatNS = "$BASE_URL/nyayiksamiti/mobile-app/storechat";
  static const nyayikchathistory = "$BASE_URL/nyayiksamiti/mobile-app/";
//
  static const toiletgraph =
      "'$BASE_URL/villagereport/mobile-app/house-toilet-type";
  static const religiongraph =
      "$BASE_URL/villagereport/mobile-app/house-toilet-type";
  static const chatimageurl = '$BASE_URL/images/chat_images/';

//bibagh Api
  static const bibagh = '$BASE_URL/bibhag/api/fetch-bibhag-details';
// https://walingstaging.smartpalika.io/bibhag/api/fetch-bibhag-details
//sifarish
  static const sifarishmainlist = '$BASE_URL/sifarish/api/get-all-sifarish';
  static const sifarishnata = '$BASE_URL_API/sifarish-naata';
  static const sifarishbasicform =
      '$BASE_URL/sifarish/api/get-sifarish-form-by-id';
  static const getchildsifarishfield =
      '$BASE_URL/sifarish/api/get-child-form-by-id';
  static const childsifarishstore = '$BASE_URL/sifarish/api/store-child';
  static const storechildimage = '$BASE_URL/sifarish/api/sifarish-child-image';
  static const receipt = '$BASE_URL/paymentmodule/mobile-app/invoices';
  static const sifarishpaymentdetail =
      '$BASE_URL/paymentmodule/mobile-app/payment-detail';
  static const saveSifaris = '$BASE_URL/sifarish/api/store-sifarish';
  static const saveSifarisDocument =
      '$BASE_URL/sifarish/api/store-sifarish-document';
  static const sifarisstatushcheck =
      '$BASE_URL/sifarish/api/sifarish-image-verify';
  static const sifarispaymentdetail = '$BASE_URL/sifarish/api/sifarish-payment';
  static const ipsnpapost =
      'https://uat.connectips.com:7443/connectipswebgw/loginpage'; //Connect IPS URL
//business
  static const getBusinessListings = '$BASE_URL_API/village-profile-by-data';

//household login
  static const household_check = '$BASE_URL/loginapi/check-household';
  static const verify_otp = '$BASE_URL/loginapi/verify-household-OTP';
  static const household = '$BASE_URL/loginapi/household';
  static const householdlogincheck = '$BASE_URL/loginapi/household-login-check';
  static const passwordset = '$BASE_URL/loginapi/household-user-update';
  static const askotp = '$BASE_URL/loginapi/household-OTP';
  static const emailotpask = '$BASE_URL/loginapi/resend-OTP';
  static const emailforgotpass = '$BASE_URL/loginapi/forget-password';
  static const setpassword = '$BASE_URL/loginapi/submit-password';
  static const userimagechange = '$BASE_URL/loginapi/user-image';

  static const general_notification =
      '$BASE_URL/pushnotification/api/general-notification';
  static const user_notification =
      '$BASE_URL/pushnotification/api/user-notification';

//second profile page data jaha chai sifarish haru ko status auuxa
  static const sifarishstatus = '$BASE_URL_API/profile';
  static const editprofile = '$BASE_URL/loginapi/update'; //profile edit
  static const updateprofileimage =
      '$BASE_URL/loginapi/update-user-image'; //profile edit

  static const sifarishpaymentdetailforsecondprofilepage =
      '$BASE_URL/paymentmodule/mobile-app/payment-detail';

  static const khaltiverifyapi =
      '$BASE_URL/paymentmodule/mobile-app/khalti-verify';
  static const esewaVerityApi =
      '$BASE_URL/paymentmodule/mobile-app/verify/esewa/verification';

//tax payment
  static const taxinfo = '$BASE_URL/apilink/e-tax'; //etax API
  static const taxoptverify = '$BASE_URL/apilink/e-tax-verify';
  static const taxregister = '$BASE_URL/etax/api/taxpayer';
  static const taxDocument = '$BASE_URL/etax/api/taxpayer-docs/';
  static const taxRegisterOTP = "$BASE_URL/etax/api/send-otp";
  static const taxRegisterSumbit = "$BASE_URL/etax/api/taxpayer-verify";
  static const getTaxPayerlist = "$BASE_URL/etax/api/check-taxpayer";
  static const sendTaxIdPayment =
      "$BASE_URL/etax/payment/taxpayer-info"; // tax payment step1
  static const verifyPaymentRequest =
      "$BASE_URL/etax/payment/verify-payment-request";
  static const taxSendOTP = '$BASE_URL/etax/payment/taxpayer-info'; //etax API

//land property
  static const landregister = '$BASE_URL/etax/api/tax-property-land';
  static const landDocument = '$BASE_URL/etax/api/tax-property-land-docs';
  static const landRegisterVerify =
      '$BASE_URL/etax/api/tax-property-land-verify';

// ghar property
  static const gharregister = '$BASE_URL/etax/api/create-house-detail';
  static const gharDocument = '$BASE_URL/etax/api/tax-property-house-docs';

//vital registration

  static const registerdevice = '$BASE_URL_API/register';

//graph api
  static const barcharts =
      '$BASE_URL/villagereport/api/barchart'; //barchart API
  static const barchart = '$BASE_URL/villagereport/api/barchart'; //barchart API

//form registration
  static const birthform = '$BASE_URL_API/birthform-data';
  static const deathform = '$BASE_URL_API/deathform-data';
  static const divorceform = '$BASE_URL_API/divorceform-data';
  static const save_event_report_document =
      '$BASE_URL_API/vital-registration-documents'; //vital documents post
  static const vital_status_check =
      '$BASE_URL_API/vital-image-verify'; //vital documents verify
  static const vital_payment_detail =
      '$BASE_URL_API/vital-payment'; //vital payment

//IPT Tax module
  static const taxpayerdetail = '$BASE_URL/etax/api/taxpayer';

//KMC Wordpress Api
  static const wordpressKMCApiLink =
      'https://kathmandu.gov.np/api/articles-api';
}

//imepay api
const imepay_initialize = "$BASE_URL/paymentmodule/mobile-app/generate-payment-token/imepay";
const imepay_recording_url = "$BASE_URL/paymentmodule/mobile-app/imepay/transaction/recording-url";
const imepay_delivery = "$BASE_URL/paymentmodule/mobile-app/verify-payment/imepay";
const imepay_new_delivery = "$BASE_URL/paymentmodule/mobile-app/imepay/delivery-service";

//get nearby toilet
const nearby_place ="$BASE_URL/api/nearby-places/all";

//server-maintain
const server_maintain ="$BASE_URL/api/server-maintainance";

//kmc pratinidhi karmachari url
const pratinidhi = "";
const karmachari = "";

//offline payment
const offlinePaymentUrl = '$BASE_URL/paymentmodule/api/cash-payment';


//toilet new api 
const toiletGetOrganizationUrl='$BASE_URL_FOR_TOILET_TEST/api/public_shauchalaya/getOrganizations';
const toiletGetBranchesUrl='$BASE_URL_FOR_TOILET_TEST/api/public_shauchalaya/getBranches';
const toiletGetSingleBranchUrl='$BASE_URL_FOR_TOILET_TEST/api/public_shauchalaya/oneBranch';
const getAllToiletRange='$BASE_URL_FOR_TOILET_TEST/api/geo_location/show_nearby_branch';
const postToiletReviewUrl='$BASE_URL_FOR_TOILET_TEST/api/review/create_review';
const postOrganizationFormUrl='$BASE_URL_FOR_TOILET_TEST/api/public_shauchalaya/org_verification_request';