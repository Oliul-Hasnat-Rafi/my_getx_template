
import 'package:photos/src/model/pogo_model/profile_image_model.dart';


class User {
  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.totalPromotedPhotos,
    this.totalIllustrations,
    this.totalPromotedIllustrations,
    this.acceptedTos,
    this.forHire,

  });

  final String? id;
  final DateTime? updatedAt;
  final String? username;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? twitterUsername;
  final String? portfolioUrl;
  final String? bio;
  final String? location;
  final UserLinks? links;
  final ProfileImage? profileImage;
  final String? instagramUsername;
  final int? totalCollections;
  final int? totalLikes;
  final int? totalPhotos;
  final int? totalPromotedPhotos;
  final int? totalIllustrations;
  final int? totalPromotedIllustrations;
  final bool? acceptedTos;
  final bool? forHire;


  User copyWith({
    String? id,
    DateTime? updatedAt,
    String? username,
    String? name,
    String? firstName,
    String? lastName,
    String? twitterUsername,
    String? portfolioUrl,
    String? bio,
    String? location,
    UserLinks? links,
    ProfileImage? profileImage,
    String? instagramUsername,
    int? totalCollections,
    int? totalLikes,
    int? totalPhotos,
    int? totalPromotedPhotos,
    int? totalIllustrations,
    int? totalPromotedIllustrations,
    bool? acceptedTos,
    bool? forHire,

  }) {
    return User(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      twitterUsername: twitterUsername ?? this.twitterUsername,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      links: links ?? this.links,
      profileImage: profileImage ?? this.profileImage,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      totalCollections: totalCollections ?? this.totalCollections,
      totalLikes: totalLikes ?? this.totalLikes,
      totalPhotos: totalPhotos ?? this.totalPhotos,
      totalPromotedPhotos: totalPromotedPhotos ?? this.totalPromotedPhotos,
      totalIllustrations: totalIllustrations ?? this.totalIllustrations,
      totalPromotedIllustrations: totalPromotedIllustrations ?? this.totalPromotedIllustrations,
      acceptedTos: acceptedTos ?? this.acceptedTos,
      forHire: forHire ?? this.forHire,

    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      username: json["username"],
      name: json["name"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      twitterUsername: json["twitter_username"],
      portfolioUrl: json["portfolio_url"],
      bio: json["bio"],
      location: json["location"],
      links: json["links"] == null ? null : UserLinks.fromJson(json["links"]),
      profileImage: json["profile_image"] == null ? null : ProfileImage.fromJson(json["profile_image"]),
      instagramUsername: json["instagram_username"],
      totalCollections: json["total_collections"],
      totalLikes: json["total_likes"],
      totalPhotos: json["total_photos"],
      totalPromotedPhotos: json["total_promoted_photos"],
      totalIllustrations: json["total_illustrations"],
      totalPromotedIllustrations: json["total_promoted_illustrations"],
      acceptedTos: json["accepted_tos"],
      forHire: json["for_hire"],
    
    );
  }

  @override
  String toString() {
    return "$id, $updatedAt, $username, $name, $firstName, $lastName, $twitterUsername, $portfolioUrl, $bio, $location, $links, $profileImage, $instagramUsername, $totalCollections, $totalLikes, $totalPhotos, $totalPromotedPhotos, $totalIllustrations, $totalPromotedIllustrations, $acceptedTos, $forHire, ";
  }
}

class UserLinks {
  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  final String? self;
  final String? html;
  final String? photos;
  final String? likes;
  final String? portfolio;
  final String? following;
  final String? followers;

  UserLinks copyWith({
    String? self,
    String? html,
    String? photos,
    String? likes,
    String? portfolio,
    String? following,
    String? followers,
  }) {
    return UserLinks(
      self: self ?? this.self,
      html: html ?? this.html,
      photos: photos ?? this.photos,
      likes: likes ?? this.likes,
      portfolio: portfolio ?? this.portfolio,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  factory UserLinks.fromJson(Map<String, dynamic> json) {
    return UserLinks(
      self: json["self"],
      html: json["html"],
      photos: json["photos"],
      likes: json["likes"],
      portfolio: json["portfolio"],
      following: json["following"],
      followers: json["followers"],
    );
  }

  @override
  String toString() {
    return "$self, $html, $photos, $likes, $portfolio, $following, $followers, ";
  }
}