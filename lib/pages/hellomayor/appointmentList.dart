import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmc/config/Apiconnectservices.dart';
import 'package:kmc/modal/appointmentlist_model.dart';

import '../../config/colors.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
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
              Text('appointment'.tr,
                  style: TextStyle(color: primary, fontSize: 22)),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: primary, size: 28)),
            ],
          ),
        ),
      ),
      body: FutureBuilder<AppointmentList>(
          future: getAppointment(),
          builder: (context, AsyncSnapshot<AppointmentList> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: primary,
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              print(snapshot.data!.data.toString());
              var data = snapshot.data;
              return ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(horizontal: 20),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration( borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: primary)),
                                            child: Center(
                                              child: Text(
                                                "Appointment Details",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: primary),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.edit_outlined,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "NAME".tr +
                                                    ":" +
                                                    " ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                                    snapshot.data!.data[index]
                                                        .name
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone_outlined,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "mobilenumber".tr +
                                                    ":" +
                                                    " " ,
                                                  
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: primary),
                                              ),
                                              Text(
                                                
                                                    snapshot.data!.data[index]
                                                        .mobile
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.ac_unit ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "province".tr +
                                                    ":" +
                                                    " " ,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: primary),
                                              ),
                                              Text(
                                              
                                                    snapshot
                                                        .data!.data[index].province
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.alt_route_sharp ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "district".tr +
                                                    ":" +
                                                    " " ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                                
                                                    snapshot
                                                        .data!.data[index].district
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.local_library_outlined ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "local_level".tr +
                                                    ":" +
                                                    " " ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: primary,
                                                   fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              Expanded(
                                                child: Text(
                                              
                                                      snapshot.data!.data[index].lg
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      overflow: TextOverflow.ellipsis
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.apartment_sharp ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "ward".tr +
                                                    ":" +
                                                    " " ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                                    snapshot.data!.data[index].ward
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.date_range_outlined ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "date".tr +
                                                    ":" +
                                                    " " ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                                snapshot.data!.data[index]
                                                        .requestDate
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.perm_phone_msg_rounded ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "report_to".tr +
                                                    ":" +
                                                    " ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                                (snapshot.data!.data[index]
                                                                .requestTo ==
                                                            null
                                                        ? ""
                                                        : snapshot.data!.data[index]
                                                            .requestTo
                                                            .toString()),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.business ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "organization".tr +
                                                    ":" +
                                                    " ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                               
                                                    snapshot.data!.data[index]
                                                        .organization
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.engineering ,
                                                color: primary,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Designation".tr +
                                                    ":" +
                                                    " " ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Text(
                                                 snapshot.data!.data[index]
                                                        .designation
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.align_vertical_bottom_rounded ,
                                                color: primary,
                                                size: 20,
                                              ),
                                               SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Priority".tr + ":" + "  ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: snapshot
                                                                    .data!
                                                                    .data[index]
                                                                    .priority ==
                                                                "high"
                                                            ? Colors.red
                                                            : (snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .status ==
                                                                    "medium")
                                                                ? Colors.amber
                                                                : Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  snapshot.data!.data[index]
                                                      .priority
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: snapshot
                                                                  .data!
                                                                  .data[index]
                                                                  .priority ==
                                                              "high"
                                                          ? Colors.red
                                                          : (snapshot
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .status ==
                                                                  "medium")
                                                              ? Colors.amber
                                                              : Colors.green),
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                Icons.question_mark_outlined ,
                                                color: primary,
                                                size: 20,
                                              ),
                                               SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "status".tr + ":",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: snapshot
                                                                    .data!
                                                                    .data[index]
                                                                    .status ==
                                                                "pending"
                                                            ? Colors.amber
                                                            : (snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .status ==
                                                                    "rejected")
                                                                ? Colors.red
                                                                : Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  snapshot
                                                      .data!.data[index].status
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: snapshot
                                                                  .data!
                                                                  .data[index]
                                                                  .status ==
                                                              "pending"
                                                          ? Colors.amber
                                                          : (snapshot
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .status ==
                                                                  "rejected")
                                                              ? Colors.red
                                                              : Colors.green),
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2),
                                                child: Icon(
                                                  Icons.message_outlined ,
                                                  color: primary,
                                                  size: 20,
                                                ),
                                              ),
                                               SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "MESSAGES".tr +
                                                    ":" +
                                                    " ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary),
                                              ),
                                              Expanded(
                                                child: Text(
                                                      snapshot
                                                          .data!.data[index].message
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.mail,
                              size: 30,
                            ),
                            title: Text(
                              snapshot.data!.data[index].name.toString(),
                              style: TextStyle(color: textPrimaryDarkColor),
                            ),
                            subtitle: Text(
                              snapshot.data!.data[index].mobile.toString(),
                              style: TextStyle(color: textPrimaryDarkColor),
                            ),
                            trailing: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: snapshot.data!.data[index]
                                                      .status ==
                                                  "pending"
                                              ? Colors.amber
                                              : (snapshot.data!.data[index]
                                                          .status ==
                                                      "rejected")
                                                  ? Colors.red
                                                  : Colors.green),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    snapshot.data!.data[index].status
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            snapshot.data!.data[index].status ==
                                                    "pending"
                                                ? Colors.amber
                                                : (snapshot.data!.data[index]
                                                            .status ==
                                                        "rejected")
                                                    ? Colors.red
                                                    : Colors.green),
                                  ),
                                )),
                          ),
                        ),
                        Divider(
                          height: 30,
                          color: textPrimaryDarkColor,
                        ),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
