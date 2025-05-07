class AppModel {
  String? appTheme;
  String? appLanguage;

  AppModel({
    this.appTheme,
    this.appLanguage,
  });
  AppModel copyWith({
    String? appTheme,
    String? appLanguage,
  }) {
    return AppModel(
      appTheme: appTheme ?? this.appTheme,
      appLanguage: appLanguage ?? this.appLanguage,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'appTheme': appTheme,
      'appLanguage': appLanguage,
    };
  }
  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      appTheme: json['appTheme'],
      appLanguage: json['appLanguage'],
    );
  }

  
}
