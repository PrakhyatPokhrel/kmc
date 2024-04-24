import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String token;
  final Profile profile;
  final Role? role;
  final RoleDesig? roleDesig;
  const LoginModel({
    required this.token,
    required this.profile,
    required this.role,
    required this.roleDesig,
  });

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      token: map["token"] as String,
      profile: Profile.fromMap(map["profile"] as Map<String, dynamic>),
      role: Role.fromMap(map["role"] as Map<String, dynamic>),
      roleDesig: RoleDesig.fromMap(map["role_desig"] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [token, profile];
}

class Profile extends Equatable {
  final int id;
  final String name;
  final String nameNp;
  final int wardId;
  final String email;
  final String address;
  final String mobile;
  final String gender;
  final String userImg;
  const Profile({
    required this.id,
    required this.name,
    required this.nameNp,
    required this.wardId,
    required this.email,
    required this.address,
    required this.mobile,
    required this.gender,
    required this.userImg,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map["id"].toInt() as int,
      name: map["name"] as String,
      nameNp: map["name_np"] as String,
      wardId: map["ward_id"].toInt() as int,
      email: map["email"] as String,
      address: map["address"] as String,
      mobile: map["mobile"] as String,
      gender: map["gender"] as String,
      userImg: map["user_img"] as String,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      nameNp,
      wardId,
      email,
      address,
      mobile,
      gender,
      userImg,
    ];
  }
}

class Role extends Equatable {
  final String roleName;
  final int roleOrder;
  const Role({
    required this.roleName,
    required this.roleOrder,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "role_name": roleName,
      "role_order": roleOrder,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      roleName: map["role_name"] as String,
      roleOrder: map["role_order"].toInt() as int,
    );
  }

  @override
  List<Object> get props => [roleName, roleOrder];
}

class RoleDesig extends Equatable {
  final String designation;
  final String roleName;
  final String roleOrder;
  const RoleDesig({
    required this.designation,
    required this.roleName,
    required this.roleOrder,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "designation": designation,
      "role_name": roleName,
      "role_order": roleOrder,
    };
  }

  factory RoleDesig.fromMap(Map<String, dynamic> map) {
    return RoleDesig(
      designation: map["designation"] as String,
      roleName: map["role_name"] as String,
      roleOrder: map["role_order"] as String,
    );
  }

  @override
  List<Object> get props => [designation, roleName, roleOrder];
}
