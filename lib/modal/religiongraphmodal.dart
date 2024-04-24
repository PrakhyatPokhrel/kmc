import 'dart:convert';

class ReligionTablegraph {
  dynamic message;
  List<TableDataReligion>? table;
  List<ChartdataReligion>? chart;
  ReligionTablegraph({
    this.message,
    this.table,
    this.chart,
  });

  factory ReligionTablegraph.fromJson(Map<String, dynamic> map) {
    List<dynamic> table = map['data']['table_data'];
    var tablelists = table == null
        ? null
        : table.map((e) => TableDataReligion.fromJson(e)).toList();

    List<dynamic> graph = map['data']['chart_data'];
    var graphlists = graph == null
        ? null
        : graph.map((e) => ChartdataReligion.fromJson(e)).toList();
    return ReligionTablegraph(
        message: map['message'], table: tablelists, chart: graphlists);
  }
}

class TableDataReligion {
  dynamic name;
  dynamic percent;
  TableDataReligion({
    this.name,
    this.percent,
  });

  factory TableDataReligion.fromJson(Map<String, dynamic> map) {
    return TableDataReligion(
      name: map['name'],
      percent: map['percent'],
    );
  }
}

class ChartdataReligion {
  dynamic key_label;
  List<DataListReligion>? data;
  ChartdataReligion({
    this.key_label,
    this.data,
  });

  factory ChartdataReligion.fromJson(Map<String, dynamic> map) {
    List<dynamic> graph = map['data'];
    var graphlist = graph == null
        ? null
        : graph.map((e) => DataListReligion.fromJson(e)).toList();

    return ChartdataReligion(key_label: map['key_label'], data: graphlist);
  }
}

class DataListReligion {
  dynamic key;
  dynamic value;
  DataListReligion({
    this.key,
    this.value,
  });

  factory DataListReligion.fromJson(Map<String, dynamic> map) {
    return DataListReligion(
      key: map['key'],
      value: map['value'],
    );
  }
}
