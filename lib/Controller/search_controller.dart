import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreSearchController extends GetxController {
  final searchQuery = ''.obs;
  Rx<List<DocumentSnapshot>> searchResults = Rx<List<DocumentSnapshot>>([]);

  Future<void> searchFirestore(String collection) async {
    searchResults.value;

    final querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('title', isEqualTo: searchQuery.value)
        .where('description', isEqualTo: searchQuery.value)
        .get();
    print(searchQuery.value);
    searchResults.value = querySnapshot.docs;
  }
}
