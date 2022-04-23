import 'package:music_mates_app/data/data_export.dart';

class HomeModel {
  // final UserModel currentUser = UserModel.dummy();

  // final List<UserModel> musicMates =  List.generate(9, (index) => UserModel.dummy());

  UserModel? currentUser;
  List<UserModel>? musicMates;

  HomeModel();

  HomeModel.fromJson(Map<String, dynamic> json)
      : currentUser = UserModel.fromJson(json['userInfo']),
        musicMates = UserList.musicMatesJson(json).users;
}
