class PinEntity {
  final String id;
  final String imageUrl;
  final int width;
  final int height;
  final String? description;
  final String? photographer;
  final String? photographerUrl;
  final String? color;

  PinEntity({
    required this.id,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.description,
    this.photographer,
    this.photographerUrl,
    this.color,
  });
}
