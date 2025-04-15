import '../pogo_model/photo_response_model_links.dart';
import '../pogo_model/photo_url_model.dart';
import '../pogo_model/user_model.dart';

class PhotoScreenResponseModel {
    PhotoScreenResponseModel({
        required this.id,
        required this.slug,
        required this.createdAt,
        required this.updatedAt,
        required this.promotedAt,
        required this.width,
        required this.height,
        required this.color,
        required this.blurHash,
        required this.description,
        required this.altDescription,
        required this.breadcrumbs,
        required this.urls,
        required this.links,
        required this.likes,
        required this.likedByUser,
        required this.currentUserCollections,

        required this.assetType,
        required this.user,
    });

    final String? id;
    final String? slug;
   
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic promotedAt;
    final int? width;
    final int? height;
    final String? color;
    final String? blurHash;
    final String? description;
    final String? altDescription;
    final List<dynamic> breadcrumbs;
    final Urls? urls;
    final PhotoResponseModelLinks? links;
    final int? likes;
    final bool? likedByUser;
    final List<dynamic> currentUserCollections;

    final String? assetType;
    final User? user;

    PhotoScreenResponseModel copyWith({
        String? id,
        String? slug,
   
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic promotedAt,
        int? width,
        int? height,
        String? color,
        String? blurHash,
        String? description,
        String? altDescription,
        List<dynamic>? breadcrumbs,
        Urls? urls,
        PhotoResponseModelLinks? links,
        int? likes,
        bool? likedByUser,
        List<dynamic>? currentUserCollections,

        String? assetType,
        User? user,
    }) {
        return PhotoScreenResponseModel(
            id: id ?? this.id,
            slug: slug ?? this.slug,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            promotedAt: promotedAt ?? this.promotedAt,
            width: width ?? this.width,
            height: height ?? this.height,
            color: color ?? this.color,
            blurHash: blurHash ?? this.blurHash,
            description: description ?? this.description,
            altDescription: altDescription ?? this.altDescription,
            breadcrumbs: breadcrumbs ?? this.breadcrumbs,
            urls: urls ?? this.urls,
            links: links ?? this.links,
            likes: likes ?? this.likes,
            likedByUser: likedByUser ?? this.likedByUser,
            currentUserCollections: currentUserCollections ?? this.currentUserCollections,
          
            assetType: assetType ?? this.assetType,
            user: user ?? this.user,
        );
    }

    factory PhotoScreenResponseModel.fromJson(Map<String, dynamic> json){ 
        return PhotoScreenResponseModel(
            id: json["id"],
            slug: json["slug"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            promotedAt: json["promoted_at"],
            width: json["width"],
            height: json["height"],
            color: json["color"],
            blurHash: json["blur_hash"],
            description: json["description"],
            altDescription: json["alt_description"],
            breadcrumbs: json["breadcrumbs"] == null ? [] : List<dynamic>.from(json["breadcrumbs"]!.map((x) => x)),
            urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
            links: json["links"] == null ? null : PhotoResponseModelLinks.fromJson(json["links"]),
            likes: json["likes"],
            likedByUser: json["liked_by_user"],
            currentUserCollections: json["current_user_collections"] == null ? [] : List<dynamic>.from(json["current_user_collections"]!.map((x) => x)),
          
            assetType: json["asset_type"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    @override
    String toString(){
        return "$id, $slug, $createdAt, $updatedAt, $promotedAt, $width, $height, $color, $blurHash, $description, $altDescription, $breadcrumbs, $urls, $links, $likes, $likedByUser, $currentUserCollections,  $assetType, $user, ";
    }
}
