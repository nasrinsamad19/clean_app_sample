class RefreshModel {
  RefreshModel({
    required this.message,
    required this.token,
    required this.refreshtoken,
  });
  late final String message;
  late final String token;
  late final String refreshtoken;

  RefreshModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    refreshtoken = json['refreshtoken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    data['refreshtoken'] = refreshtoken;
    return data;
  }
}
