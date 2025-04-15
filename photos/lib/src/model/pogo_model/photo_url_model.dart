class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  final String? raw;
  final String? full;
  final String? regular;
  final String? small;
  final String? thumb;
  final String? smallS3;

  Urls copyWith({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    String? smallS3,
  }) {
    return Urls(
      raw: raw ?? this.raw,
      full: full ?? this.full,
      regular: regular ?? this.regular,
      small: small ?? this.small,
      thumb: thumb ?? this.thumb,
      smallS3: smallS3 ?? this.smallS3,
    );
  }

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      raw: json["raw"],
      full: json["full"],
      regular: json["regular"],
      small: json["small"],
      thumb: json["thumb"],
      smallS3: json["small_s3"],
    );
  }

  @override
  String toString() {
    return "$raw, $full, $regular, $small, $thumb, $smallS3, ";
  }
}