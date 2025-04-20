class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      depth: json['depth'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }

  Dimensions copyWith({
    double? width,
    double? height,
    double? depth,
  }) {
    return Dimensions(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }
}
