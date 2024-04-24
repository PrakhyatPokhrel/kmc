// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:html/parser.dart' show parse;

enum TypeEnum { pdf, image }

class NewsNoticeModelWordpress {
  final String title;
  final String language;
  final String tags;
  final List<DocumentModel> docs;
  // final String? supportingDocuments;

  const NewsNoticeModelWordpress({
    required this.title,
    required this.language,
    required this.tags,
    required this.docs,
    // required this.supportingDocuments,
  });

  factory NewsNoticeModelWordpress.fromMap(Map<String, dynamic> map) {
    return NewsNoticeModelWordpress(
      title: map['Title'] as String,
      language: map['Language'] as String,
      tags: map['Tags'] as String,
      docs: getDocuments(map['Body'], map['Supporting Documents']),
    );
  }

  TypeEnum get type {
    if (docs.isNotEmpty) {
      if (docs[0].url.split(".").last == "pdf") {
        return TypeEnum.pdf;
      }
    }
    return TypeEnum.image;
  }
}

List<DocumentModel> getDocuments(String bodyHtml, String supportingDocHtml) {
  List<DocumentModel> imgList = [];
  imgList.addAll(getAllFromTag(bodyHtml, "img", "src"));
  imgList.addAll(getAllFromTag(supportingDocHtml, "a", "href"));
  return imgList.toSet().toList();
}

List<DocumentModel> getAllFromTag(
    String html, String querySelectorString, String attributeString) {
  List<DocumentModel> list = [];
  var document = parse(html);
  final aTags = document.querySelectorAll(querySelectorString);
  // Iterate over the a tags and print their href attributes
  for (var aTag in aTags) {
    if (aTag.attributes[attributeString] != null) {
      list.add(
        DocumentModel(
          title: aTag.text,
          url: aTag.attributes[attributeString]!,
        ),
      );
    }
  }
  return list;
}

class DocumentModel {
  final String? title;
  final String url;
  const DocumentModel({
    required this.title,
    required this.url,
  });
}
