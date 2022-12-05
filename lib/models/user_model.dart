// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'user_model.g.dart';


@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? profile;
  @HiveField(5)
  String? uid;
  @HiveField(6)
  String? fullName;
  @HiveField(7)
  String? joinedDate;
  @HiveField(8)
  List<dynamic>? categories;
  @HiveField(9)
  bool? isSocialUser;
  
  UserModel({this.firstName, this.lastName, this.email, this.phone, this.profile,this.uid,this.fullName,this.joinedDate,this.categories,this.isSocialUser});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profile': profile,
      'uid': uid,
      "fullName" : fullName,
      "joinedDate" : joinedDate,
      "isSocialUser" : isSocialUser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : "",
      lastName: map['lastName'] != null ? map['lastName'] as String : "",
      email: map['email'] != null ? map['email'] as String : "",
      phone: map['phone'] != null ? map['phone'] as String : "",
      profile: map['profile'] != null ? map['profile'] as String : "",
      uid: map['uid'] != null ? map['uid'] as String : "",
      fullName: map['fullName'] != null ? map['fullName'] as String : "",
      joinedDate: map['joinedDate'] != null ? map['joinedDate'] as String : "",
      categories: map['categories'] != null ? map['categories'] as List<dynamic> : [],
      isSocialUser: map['isSocialUser'] != null ? map['isSocialUser'] as bool : false,

    );
  }
}
