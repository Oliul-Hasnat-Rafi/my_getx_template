class PhotoResponseModelLinks {
  PhotoResponseModelLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  final String? self;
  final String? html;
  final String? download;
  final String? downloadLocation;

  PhotoResponseModelLinks copyWith({
    String? self,
    String? html,
    String? download,
    String? downloadLocation,
  }) {
    return PhotoResponseModelLinks(
      self: self ?? this.self,
      html: html ?? this.html,
      download: download ?? this.download,
      downloadLocation: downloadLocation ?? this.downloadLocation,
    );
  }

  factory PhotoResponseModelLinks.fromJson(Map<String, dynamic> json) {
    return PhotoResponseModelLinks(
      self: json["self"],
      html: json["html"],
      download: json["download"],
      downloadLocation: json["download_location"],
    );
  }

  @override
  String toString() {
    return "$self, $html, $download, $downloadLocation, ";
  }
}