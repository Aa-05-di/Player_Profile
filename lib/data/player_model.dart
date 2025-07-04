class Autogenerated {
  bool? status;
  String? message;
  List<Player>? player;

  Autogenerated({this.status, this.message, this.player});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['player'] != null) {
      player = <Player>[];
      json['player'].forEach((v) {
        player!.add(new Player.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.player != null) {
      data['player'] = this.player!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  int? id;
  int? userId;
  String? fullname;
  String? location;
  String? skillLevel;
  String? rating;
  String? archive;
  String? playerImage;
  String? createdAt;
  String? updatedAt;

  Player(
      {this.id,
      this.userId,
      this.fullname,
      this.location,
      this.skillLevel,
      this.rating,
      this.archive,
      this.playerImage,
      this.createdAt,
      this.updatedAt});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullname = json['fullname'];
    location = json['location'];
    skillLevel = json['skill_level'];
    rating = json['rating'];
    archive = json['archive'];
    playerImage = json['player_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['location'] = this.location;
    data['skill_level'] = this.skillLevel;
    data['rating'] = this.rating;
    data['archive'] = this.archive;
    data['player_image'] = this.playerImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
