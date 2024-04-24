import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HowToUse'.tr,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: Column(
            children: [
              Text(
                '१. सर्वप्रथम एप्सको  मेन्युमा गइ लग-इन बटन थिच्नुहोस । \n\n२. नयाँ प्रयोग कर्ताको हकमा दर्ता फारम भरी, आफ्नो मोबाइलमा आएको OTP कोड प्रविष्ट गर्नुपर्ने हुन्छ ।\n\n३. दर्ता गरी सक्नु भएका प्रयोग कर्ताहरुले आफ्नो इमेल वा मोवाइल नं. तथा पासवर्ड राखी लग-इन गर्नुपर्ने हुन्छ । लग-इन गरिसकेपछी एप्सका अधिकांश सेवा प्रयोगका लागी उपलब्ध हुनेछन । \n\nनोट: परिक्षण काल पश्चात एप्समा लग-इन गर्ने संयन्त्र परिवर्तन भइ घरधुरी टोकन लग-इन व्यवस्ता लागु हुनेछ।',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
                // textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
