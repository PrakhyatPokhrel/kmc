
class DigitalProfileModal {
  dynamic total_population;
  dynamic total_house;
  dynamic male_population;
  dynamic female_population;
  dynamic others_population;

  DigitalProfileModal({
    this.total_population,
    this.total_house,
    this.male_population,
    this.female_population,
    this.others_population,
  });

  factory DigitalProfileModal.fromJson(Map<String, dynamic> map) {
    return DigitalProfileModal(
      total_population: map['total_population'],
      total_house: map['total_house'],
      male_population: map['male_population'],
      female_population: map['female_population'],
      others_population: map['others_population'],
    );
  }
}
