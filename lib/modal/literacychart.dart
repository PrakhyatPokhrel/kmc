import 'dart:convert';

class Litracychartandtable {
  dynamic message;
  List<TableData>? table;
  List<Chartdata>? chart;
  Litracychartandtable({
    this.message,
    this.table,
    this.chart,
  });

  factory Litracychartandtable.fromJson(Map<String, dynamic> map) {
    List<dynamic> table = map['data']['table_data'];
    var tablelists =
        table == null ? null : table.map((e) => TableData.fromJson(e)).toList();

    List<dynamic> graph = map['data']['chart_data'];
    var graphlists =
        graph == null ? null : graph.map((e) => Chartdata.fromJson(e)).toList();
    return Litracychartandtable(
        message: map['message'], table: tablelists, chart: graphlists);
  }
}

class TableData {
  dynamic ward;
  dynamic male;
  dynamic female;
  dynamic total;
  TableData({
    this.ward,
    this.male,
    this.female,
    this.total,
  });

  factory TableData.fromJson(Map<String, dynamic> map) {
    return TableData(
      ward: map['ward'],
      male: map['male'],
      female: map['female'],
      total: map['total'],
    );
  }
}

class Chartdata {
  dynamic key_label;
  List<DataList>? data;
  Chartdata({
    this.key_label,
    this.data,
  });

  factory Chartdata.fromJson(Map<String, dynamic> map) {
    List<dynamic> graph = map['data'];
    var graphlist =
        graph == null ? null : graph.map((e) => DataList.fromJson(e)).toList();

    return Chartdata(key_label: map['key_label'], data: graphlist!);
  }
}

class DataList {
  dynamic key;
  dynamic value;
  DataList({
    this.key,
    this.value,
  });

  factory DataList.fromJson(Map<String, dynamic> map) {
    return DataList(
      key: map['key'],
      value: map['value'],
    );
  }
}

class SalesDatas {
  final String? key;
  final int? value;
  SalesDatas({
    this.key,
    this.value,
  });

  factory SalesDatas.fromJson(Map<String, dynamic> map) {
    return SalesDatas(
      key: map['key'],
      value: map['value'],
    );
  }
}
