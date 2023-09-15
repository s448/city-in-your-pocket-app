import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreSearchController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // DocumentSnapshot?
    //     startAfter; // Set this to the last document snapshot from the previous query if using pagination
  }

  final searchQuery = ''.obs;
  // Rx<List<DocumentSnapshot>> searchResults = Rx<List<DocumentSnapshot>>([]);

  // Future<void> searchFirestore(String collection,int pageIndex) async {
  //   searchResults.value;
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(collection).startAfterDocument(documentSnapshot)
  //       .get();
  //   print(searchQuery.value);
  //   searchResults.value = querySnapshot.docs;
  // }
  final RxList filteredData = [].obs;
  Future<RxList> searchDocuments(DocumentSnapshot? startAfter) async {
    final collectionRef = FirebaseFirestore.instance.collection('buy_and_sell');
    if (searchQuery.value.isEmpty) {
      filteredData.clear();
    }
    filteredData.clear();
    QuerySnapshot querySnapshot;
    if (startAfter != null) {
      querySnapshot =
          await collectionRef.startAfterDocument(startAfter).limit(20).get();
    } else {
      querySnapshot = await collectionRef.limit(100).get();
    }

    for (final document in querySnapshot.docs) {
      final title = document['title'] as String;
      final description = document['description'] as String;

      if (title.contains(searchQuery) || description.contains(searchQuery)) {
        final BuySell item =
            BuySell.fromJson(document.data() as Map<String, dynamic>);

        // final item = BuySell(
        //   date: document['date'],
        //   description: document['description'],
        //   docId: document['docid'],
        //   id: document['id'],
        //   images: document['images'],
        //   price: document['price'],
        //   title: document['title'],
        //   user: UserModel.fromJson(document['user']),
        // );
        filteredData.add(item);
      }
    }
    print(filteredData.length);
    return filteredData;
  }
}
