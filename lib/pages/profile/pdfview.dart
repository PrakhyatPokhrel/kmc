import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:kmc/config/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfviewer extends StatefulWidget {
  @override
  final data;
  Pdfviewer({this.data});
  _Pdfviewer createState() => _Pdfviewer(data: this.data);
}

class _Pdfviewer extends State<Pdfviewer> {
  var data;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  _Pdfviewer({this.data});

  bool _isLoading = true;
  var connectivityResult;

  @override
  void initState() {
    super.initState();
    checknetwork();
  }

  bool network = true;
  checknetwork() async {
    connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        network = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('कागजात', style: TextStyle(color: primary, fontSize: 22)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        body: Center(
            child: Container(
                child: network == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.signal_wifi_connected_no_internet_4_rounded,
                            color: primary,
                            size: 80,
                          ),
                        ],
                      )
                    : SfPdfViewer.network('${widget.data}',
                        canShowScrollStatus: true,
                        enableDoubleTapZooming: false,
                        enableDocumentLinkAnnotation: false))));
  }
}
