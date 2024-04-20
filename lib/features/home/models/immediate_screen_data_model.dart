class ImmediateBookingScreenDataModel {
  final String id;
  final String serviceId;
  final String serviceAvatar;
  final String serviceName;
  final String name;
  final String? description;
  final List<String> tags;
  const ImmediateBookingScreenDataModel({
    required this.serviceAvatar,
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.name,
    this.description,
    required this.tags,
  });
}
