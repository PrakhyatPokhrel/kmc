import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/colors.dart';
import 'package:kmc/pages/suggestion.dart';

class TestingPhaseScreen extends StatefulWidget {
  const TestingPhaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TestingPhaseScreen> createState() => _TestingPhaseScreenState();
}

class _TestingPhaseScreenState extends State<TestingPhaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'TestingPhase'.tr,
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
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
          child: Column(
            children: [
              Text(
                'का. म. पा. डिजिटल सुशासन एप्स हाल सार्वजनिक परीक्षण काल (beta) मा छ। परीक्षण कालभर अधिकांश सेवाहरु सुचारु रहिरहेपनि प्रणाली निरन्तर अद्यावधिक भइरहने हुन्छ, साथै प्रणालीमा आउन सक्ने त्रुटीबारे जानकारी लिने र सुधार गर्ने कार्य चलीरहेको हुन्छ।\n\nसर्वजनिक परीक्षण कालको मुख्य उद्देश्य यहाँहरु बाट धेरै भन्दा धेरै प्रतिक्रिया तथा सुझाव लिनु हो। कृपयाँ एप्सको मेनुमा भएको /"सुझाव दिनुहोस/" बटन थिची प्रतिकृया दिनुहोला।\n\nयसका साथै, यस अवधी भर का. म. न. पा. का सबै वार्ड तथा कल सेन्टर लगायतलाई थप प्रशिक्षण दिइने छ। प्रणालीमा परिक्षण सर्वर लगायत अन्य स्रोतहरूको  प्रयोग हुनेछ, साथै सम्पुर्ण प्रणालीको थप सुरक्षा तथा अडिट हुने हुँदा-हुँदा सेवा केहि प्रभावित हुनसक्छ।',
                // textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  submitButton() {
    return Center(
        child: new Container(
      child: ButtonTheme(
          height: 40.0,
          child: new ElevatedButton(
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(Get.width - 54, 50)),
                backgroundColor: MaterialStateProperty.all(tertiary),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Wrap(children: [
                Text(
                  'suggestions'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: textPrimaryLightColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Icon(Icons.arrow_forward_rounded,
                      color: textPrimaryLightColor),
                )
              ]),
            ),
            onPressed: () {
              Get.to(Suggestion());
            },
          )),
    ));
  }
}
