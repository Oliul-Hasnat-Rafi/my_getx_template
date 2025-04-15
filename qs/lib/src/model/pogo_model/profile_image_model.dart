
class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  final String? small;
  final String? medium;
  final String? large;

  ProfileImage copyWith({
    String? small,
    String? medium,
    String? large,
  }) {
    return ProfileImage(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      small: json["small"],
      medium: json["medium"],
      large: json["large"],
    );
  }

  @override
  String toString() {
    return "$small, $medium, $large, ";
  }
}