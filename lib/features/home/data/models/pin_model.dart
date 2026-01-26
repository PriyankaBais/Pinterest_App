import '../../domain/entities/pin_entity.dart';

class PinModel extends PinEntity {
  PinModel({
    required super.id,
    required super.imageUrl,
    required super.width,
    required super.height,
    super.description,
    super.photographer,
    super.photographerUrl,
    super.color,
  });

  // Pexels API format
  factory PinModel.fromPexelsJson(Map<String, dynamic> json) {
    // Pexels API structure: src.large, src.medium, src.original
    final src = json['src'] as Map<String, dynamic>?;
    final imageUrl = src?['large'] ?? 
                     src?['medium'] ?? 
                     src?['original'] ?? 
                     src?['small'] ?? 
                     '';
    
    return PinModel(
      id: json['id']?.toString() ?? '',
      imageUrl: imageUrl,
      width: json['width'] is int 
          ? json['width'] as int 
          : (json['width'] as num?)?.toInt() ?? 400,
      height: json['height'] is int 
          ? json['height'] as int 
          : (json['height'] as num?)?.toInt() ?? 600,
      description: json['alt']?.toString(),
      photographer: json['photographer']?.toString(),
      photographerUrl: json['photographer_url']?.toString(),
      color: json['avg_color']?.toString(),
    );
  }

  // Unsplash API format (alternative)
  factory PinModel.fromUnsplashJson(Map<String, dynamic> json) {
    return PinModel(
      id: json['id']?.toString() ?? '',
      imageUrl: json['urls']?['regular'] ?? json['urls']?['full'] ?? json['urls']?['small'] ?? '',
      width: json['width'] is int ? json['width'] as int : (json['width'] as num?)?.toInt() ?? 0,
      height: json['height'] is int ? json['height'] as int : (json['height'] as num?)?.toInt() ?? 0,
      description: json['description']?.toString() ?? json['alt_description']?.toString(),
      photographer: json['user']?['name']?.toString(),
      photographerUrl: json['user']?['links']?['html']?.toString(),
      color: json['color']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'width': width,
      'height': height,
      'description': description,
      'photographer': photographer,
      'photographerUrl': photographerUrl,
      'color': color,
    };
  }
}
