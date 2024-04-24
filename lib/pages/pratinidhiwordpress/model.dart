// ignore_for_file: public_member_api_docs, sort_constructors_first

class PratinidhiModelWordpress {
  final String title;
  final String designation;
  final String photo;
  final String section;

  // final String? supportingDocuments;

  const PratinidhiModelWordpress({
    required this.title,
    required this.designation,
    required this.photo,
    required this.section,

    // required this.supportingDocuments,
  });

  factory PratinidhiModelWordpress.fromMap(Map<String, dynamic> map) {
    return PratinidhiModelWordpress(
      title: map['Title'] as String,
      designation: map['Designation'] as String,
      photo: map['Photo'] as String,
      section: map['Section'] as String,
    );
  }
}
