import 'package:equatable/equatable.dart';
import 'package:kmc/pages/sewa/sifarish_new/model/sifarish_form_model.dart';

class SifarishModel extends Equatable {
  final String categoryName;
  final List<SifarishFormModel> forms;
  const SifarishModel({
    required this.categoryName,
    required this.forms,
  });

  factory SifarishModel.fromMap(Map<String, dynamic> map) {
    return SifarishModel(
      categoryName: map['cate_name'] as String,
      forms: List<SifarishFormModel>.from(
        (map['forms'] as List).map<SifarishFormModel>(
          (x) => SifarishFormModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  List<Object> get props => [categoryName, forms];
}
