// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LeaderboardModel {
  String uid;
  String? name;
  String? email;
  String? photoUrl;
  int point;
  DateTime loginDate;

  LeaderboardModel({
    required this.uid,
    this.name,
    this.email,
    this.photoUrl,
    required this.point,
    required this.loginDate,
  });

  LeaderboardModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    int? point,
    DateTime? loginDate,
  }) {
    return LeaderboardModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      point: point ?? this.point,
      loginDate: loginDate ?? this.loginDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'point': point,
      'loginDate': loginDate.millisecondsSinceEpoch,
    };
  }

  static LeaderboardModel fromSnapshot(snapshot) {
    return LeaderboardModel(
      uid: snapshot.data['uid'],
      name: snapshot.data['name'] as String,
      email: snapshot.data['email'] as String,
      point: snapshot.data['point'] as int,
      photoUrl: snapshot.data['photoUrl'] as String,
      loginDate: DateTime.fromMillisecondsSinceEpoch(
          snapshot.data['loginDate'] as int),
    );
  }

  factory LeaderboardModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardModel(
      uid: map['uid'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      point: map['point'] as int,
      loginDate: DateTime.fromMillisecondsSinceEpoch(map['loginDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaderboardModel.fromJson(String source) =>
      LeaderboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LeaderboardModel(uid: $uid, name: $name, email: $email, photoUrl: $photoUrl, point: $point, loginDate: $loginDate)';
  }

  @override
  bool operator ==(covariant LeaderboardModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.point == point &&
        other.loginDate == loginDate;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        point.hashCode ^
        loginDate.hashCode;
  }
}
