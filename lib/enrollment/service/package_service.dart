import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_enrollment/model/package.dart';

class PackageService {
  final CollectionReference _packageCollection =
      FirebaseFirestore.instance.collection('packages');
  Future<List<Package>> getAllPackage() async {
    try {
      QuerySnapshot snapshot = await _packageCollection.get();
      return snapshot.docs.map((doc) {
        return Package.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch packages: $e");
    }
  }

  Future<List<Package>> getAllPackageByUserId(String userId) async {
    try {
      QuerySnapshot snapshot =
          await _packageCollection.where('userId', arrayContains: userId).get();
      return snapshot.docs.map((doc) {
        return Package.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch packages for user ID $userId: $e");
    }
  }
}
