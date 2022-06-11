// To parse this JSON data, do
//
//     final responseApi = responseApiFromJson(jsonString);

import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String? message;
  bool? success;
  dynamic data;

  ResponseApi({
      this.message,
      this.success,
      this.data
  });

  

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
      message: json["message"],
      success: json["success"],
      data: json["data"],
  );

  Map<String, dynamic> toJson() => {
      "message": message,
      "success": success,
      "data": data
  };
}
