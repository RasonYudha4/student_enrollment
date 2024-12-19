class Enrollment {
  String? id;
  List<String> packageId;
  String? userId;

  Enrollment({
    this.id,
    this.userId,
    required this.packageId,
  });

  factory Enrollment.fromMap(Map<String, dynamic> data) {
    return Enrollment(
        packageId: List<String>.from(data['packageId'] ?? []),
        id: data['id'] as String?,
        userId: data['userId'] as String?);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'packageId': packageId,
      'userId': userId,
    };
  }
}
