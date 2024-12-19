import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_enrollment/model/enrollment.dart';

class EnrollmentService {
  final CollectionReference _enrollmentCollection =
      FirebaseFirestore.instance.collection('enrollments');

  Future<Enrollment?> getEnrollment(String userId) async {
    try {
      QuerySnapshot snapshot = await _enrollmentCollection
          .where('userId', arrayContains: userId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = snapshot.docs.first;

        return Enrollment.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to fetch enrollment for user ID $userId: $e");
    }
  }

  Future<void> createEnrollment(Enrollment enrollment) {
    return _enrollmentCollection.add({
      'userId': enrollment.userId,
      'packageId': enrollment.packageId,
    });
  }
}
