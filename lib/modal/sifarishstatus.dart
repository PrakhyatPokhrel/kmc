// import 'dart:convert';

// class Sifarishstatus {
//   dynamic status;
//   List<Data> sifarishstatusdata;
//   Sifarishstatus({
//      this.status,
//      this.sifarishstatusdata,
//   });

//   factory Sifarishstatus.fromMap(Map<String, dynamic> map) {
//       List<dynamic> datas = json['forms'];
//     List<dynamic> lists = datas.map((e) => FormList
//     return Sifarishstatus(
//       status: map['status'],
//       sifarishstatusdata: List<Data>.from(map['sifarishstatusdata']?.map((x) => Data.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Sifarishstatus.fromJson(String source) => Sifarishstatus.fromMap(json.decode(source));
// }

// class Data {}
