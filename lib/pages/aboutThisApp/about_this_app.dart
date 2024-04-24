import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/suggestion.dart';

class AboutThisAppScreen extends StatefulWidget {
  @override
  _AboutThisAppScreenState createState() => _AboutThisAppScreenState();
}

class _AboutThisAppScreenState extends State<AboutThisAppScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                Text(
                  'AboutThisApp'.tr,
                  style: TextStyle(
                    color: primary,
                    fontSize: 22,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: primary, size: 28)),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
               mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   
                    Text("Developed by:",style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    
                  ),),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Image.asset(
                  'assets/images/cellapp.png',
                  height: 80,width: 80,
                ),
                SizedBox(width: 20,),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey,
                ),
                 SizedBox(width: 20,),
                 Image.asset(
                  'assets/images/sp_logo_horiz.png',
                   height: 80,width: 80,
                )
                    ],)
                  ],
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            child: Column(
              children: [
                Text(
                  'AboutThisAppContent'.tr,
                  // textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(color: Colors.grey,),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 50,
                  width: 500,
                  child: ElevatedButton.icon(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Suggestion()));
                  }, 
                  style: ElevatedButton.styleFrom(
                    
                    backgroundColor: tertiary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: Icon(Icons.engineering_rounded), label:Text("feedback_developer".tr,style: TextStyle(fontSize: 18,color: textPrimaryLightColor),)),
                )
                // Image.asset(
                //   'assets/images/icon.png',
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
