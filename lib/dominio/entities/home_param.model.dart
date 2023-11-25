

// import 'dart:convert';

// HomeParamModel homeParamModelFromJson(String str) => HomeParamModel.fromJson(json.decode(str));

// String homeParamModelToJson(HomeParamModel data) => json.encode(data.toJson());

class HomeParamModel {
    final String email;
    final String password;

    HomeParamModel({
        required this.email,
        required this.password,
    });

    factory HomeParamModel.fromJson(Map<String, dynamic> json) => HomeParamModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
