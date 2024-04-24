import 'package:image_picker/image_picker.dart';
import 'package:kmc/components/custom_api_service.dart';
import 'package:kmc/config/url.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_model.dart';
import 'package:dio/dio.dart';

typedef StringCallback = List<SifarishModel> Function();

abstract class SifarishApiService {
  static Future<List<SifarishModel>> getSifarishList() async {
    try {
      Response response =
          await CustomApiService().get(url: CustomURL.sifarishmainlist);
      List<SifarishModel> sifarishList = List<SifarishModel>.from(
          (response.data['data'].map((x) => SifarishModel.fromMap(x))));
      return sifarishList;
    } catch (e) {
      throw CustomApiService.handleException(e,
          message: "Could not get sifarish");
    }
  }

  static Future<int> postSifarishFields(Map<String, dynamic> data) async {
    try {
      Response response = await CustomApiService().post(
        CustomURL.saveSifaris,
        data: data,
      );
      return response.data['data']['data']['id']['entry_id'];
    } catch (e) {
      throw CustomApiService.handleException(e,
          message: "Could not submit sifarish");
    }
  }

  static Future<int> postChildSifarishFields(Map<String, dynamic> data) async {
    try {
      var response = await CustomApiService().post(
        CustomURL.childsifarishstore,
        data: data,
      );
      return response.data['data']['data']['child_id'];
    } catch (e) {
      throw CustomApiService.handleException(e,
          message: "Could not submit sifarish");
    }
  }

  static Future<void> uploadSifarishDocument({
    required XFile imageFile,
    required int entryId,
    required String docIndex,
  }) async {
    try {
      var data = {
        'entry_id': entryId.toString(),
        'doc$docIndex': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path),
      };
      await CustomApiService().post(
        CustomURL.saveSifarisDocument,
        data: data,
      );
    } catch (e) {
      throw CustomApiService.handleException(e,
          message: "Could not upload document");
    }
  }

  static Future<void> uploadChildSifarishDocument({
    required XFile imageFile,
    required int childId,
    required String docIndex,
  }) async {
    try {
      var data = {
        'child_id': childId.toString(),
        'doc$docIndex': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path,
        ),
      };
      await CustomApiService().post(
        storechildimage,
        data: data,
      );
    } catch (e) {
      throw CustomApiService.handleException(e,
          message: "Could not upload document");
    }
  }
}
