
class ToiletTablegraph {
  dynamic message;
  List<TableDatatoilet>? table;
  List<ChartdataToilet>? chart;
  ToiletTablegraph({
    this.message,
    this.table,
    this.chart,
  });

  factory ToiletTablegraph.fromJson(Map<String, dynamic> map) {
    List<dynamic> table = map['data']['table_data'];
   var tablelists = table == null
        ? null
        : table.map((e) => TableDatatoilet.fromJson(e)).toList();

    List<dynamic> graph = map['data']['chart_data'];
   var graphlists = graph == null
        ? null
        : graph.map((e) => ChartdataToilet.fromJson(e)).toList();
    return ToiletTablegraph(
        message: map['message'], table: tablelists, chart: graphlists);
  }
}

class TableDatatoilet {
  dynamic name;
  dynamic value;
  dynamic percent;
  TableDatatoilet({
    this.name,
    this.value,
    this.percent,
  });

  factory TableDatatoilet.fromJson(Map<String, dynamic> map) {
    return TableDatatoilet(
      name: map['name'],
      value: map['value'],
      percent: map['percent'],
    );
  }
}

class ChartdataToilet {
  dynamic key_label;
  List<DataListToilet>? data;
  ChartdataToilet({
    this.key_label,
    this.data,
  });

  factory ChartdataToilet.fromJson(Map<String, dynamic> map) {
    List<dynamic> graph = map['data'];
   var graphlist = graph == null
        ? null
        : graph.map((e) => DataListToilet.fromJson(e)).toList();

    return ChartdataToilet(key_label: map['key_label'], data: graphlist!);
  }
}

class DataListToilet {
  dynamic key;
  dynamic value;
  DataListToilet({
    this.key,
    this.value,
  });

  factory DataListToilet.fromJson(Map<String, dynamic> map) {
    return DataListToilet(
      key: map['key'],
      value: map['value'],
    );
  }
}
