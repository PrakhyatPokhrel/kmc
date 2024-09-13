import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({
    Key? key,
    required this.url,
    required this.fileName,
    required this.extension,
  }) : super(key: key);

  final String url;
  final String fileName;
  final String extension;

  @override
  State<DownloadingDialog> createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  String progress = "0";
  CancelToken cancelToken = CancelToken();

  void startDownloading() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();

    String downloadsDirectoryPath = Platform.isAndroid
        ? await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS) //FOR ANDROID
        : await getApplicationDocumentsDirectory().then((value) => value.path);

    String url = widget.url;
    String fileName = '${widget.fileName}.${widget.extension}';

    await dio.download(
      url,
      "$downloadsDirectoryPath/$fileName",
      cancelToken: cancelToken,
      onReceiveProgress: (received, total) {
        print(total);
        if (total != -1) {
          setState(() {
            progress = ((received / 1) * 100).toStringAsFixed(0);
          });
        }
      },
      deleteOnError: true,
    ).then(
      (value) {
        if (value.statusCode == 200) {
          EasyLoading.showSuccess(
            "Downloaded. Open the downloaded files from Files.",
            duration: Duration(seconds: 2),
          );
          Navigator.pop(context, progress);
        } else {
          EasyLoading.showSuccess(
            "Failed",
            duration: Duration(seconds: 2),
          );

          Navigator.pop(context, progress);
        }
        // Navigator.pop(context);
      },
    );
  }

  @override
  void initState() {
    startDownloading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(
        24.0,
        30.0,
        24.0,
        24.0,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            // value: double.parse(progress),
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'डाउनलोड हुदैछ',
                // 'डाउनलोड गर्दै: ${NepaliUnicode.convert(progress)} %',

                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  cancelToken.cancel();
                  Navigator.pop(context);
                },
                child: Text(
                  'रद्द गर्नुहोस्',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 22,
                        color: Colors.red,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
