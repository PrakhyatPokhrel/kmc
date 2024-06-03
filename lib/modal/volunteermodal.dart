
class Volunteermodal {
  int? id;
  dynamic name;
  dynamic contact_num;
  dynamic device_id;
  dynamic post;
  dynamic volunteer_image;
  dynamic leader;
  Volunteermodal({
    this.id,
    this.name,
    this.contact_num,
    this.device_id,
    this.post,
    this.volunteer_image,
    this.leader,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact_num': contact_num,
      'device_id': device_id,
      'post': post,
      'volunteer_image': volunteer_image,
      'leader': leader,
    };
  }

  factory Volunteermodal.fromJson(Map<String, dynamic> map) {
    return Volunteermodal(
      id: map['id'],
      name: map['name'],
      contact_num: map['contact_num'],
      device_id: map['device_id'],
      post: map['post'],
      volunteer_image: map['volunteer_image'],
      leader: map['leader'],
    );
  }
}
