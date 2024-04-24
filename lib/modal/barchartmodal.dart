import 'dart:convert';

class BarchartModal {
  dynamic population_data;
  dynamic age_dist;
  Chartdataclass mother_language;
  Chartdataclass toilet_type;
  Chartdataclass water_type;

  Chartdataclass fuel_type;
  Chartdataclass electricity_type;
  Chartdataclass literacy_woda;
  Chartdataclass road_type;
  Chartdataclass family_count;

  BarchartModal({
    required this.population_data,
    required this.age_dist,
    required this.mother_language,
    required this.toilet_type,
    required this.water_type,
    required this.fuel_type,
    required this.electricity_type,
    required this.literacy_woda,
    required this.road_type,
    required this.family_count,
  });

  factory BarchartModal.fromJson(Map<String, dynamic> map) {
    return BarchartModal(
      population_data: map['population_data'],
      age_dist: map['age_dist'],
      mother_language: Chartdataclass.fromJson(map['mother_language']),
      toilet_type: Chartdataclass.fromJson(map['toilet_type']),
      water_type: Chartdataclass.fromJson(map['water_type']),
      fuel_type: Chartdataclass.fromJson(map['fuel_type']),
      electricity_type: Chartdataclass.fromJson(map['electricity_type']),
      literacy_woda: Chartdataclass.fromJson(map['literacy_woda']),
      road_type: Chartdataclass.fromJson(map['road_type']),
      family_count: Chartdataclass.fromJson(map['family_count']),
    );
  }
}

class Chartdataclass {
  dynamic title;
  dynamic table;
  List<Chartmodal>? chart;
  Chartdataclass({
    this.title,
    this.table,
    this.chart,
  });

  factory Chartdataclass.fromJson(Map<String, dynamic> value) {
    List<dynamic> graph = value['chart']['data'];
    var graphlist = graph == null
        ? null
        : graph.map((e) => Chartmodal.fromJson(e)).toList();

    return Chartdataclass(
        title: value['chart']['key_label'],
        table: value['table'],
        chart: graphlist!);
  }
}

class Chartmodal {
  dynamic key;
  dynamic value;
  Chartmodal({
    this.key,
    this.value,
  });

  factory Chartmodal.fromJson(Map<String, dynamic> map) {
    return Chartmodal(
      key: map['key'],
      value: map['value'],
    );
  }
}

class Chartdataclassnamevalue {
  dynamic title;
  dynamic table;
  List<Chartdataclassnamevalue>? chart;
  Chartdataclassnamevalue({
    this.title,
    this.table,
    this.chart,
  });

  factory Chartdataclassnamevalue.fromJson(Map<String, dynamic> value) {
    List<dynamic> graph = value['chart'];
    var graphlist = graph == null
        ? null
        : graph.map((e) => Chartdataclassnamevalue.fromJson(e)).toList();
    return Chartdataclassnamevalue(
        title: value['chart']['key_label'],
        table: value['table'],
        chart: graphlist!);
  }
}

class Chartmodalfornameandvalue {
  dynamic key;
  dynamic value;
  Chartmodalfornameandvalue({
    this.key,
    this.value,
  });

  factory Chartmodalfornameandvalue.fromJson(Map<String, dynamic> map) {
    return Chartmodalfornameandvalue(
      key: map['key'],
      value: map['value'],
    );
  }
}
