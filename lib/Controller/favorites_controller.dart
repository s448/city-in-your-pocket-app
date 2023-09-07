import 'package:cityinpocket/Model/buy_sell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends GetxController {
  final prefs = Get.find<SharedPreferences>();
  RxList<String> favorites = <String>[].obs;
  final String _favoritesKey = 'favorites';

  final CollectionReference buySellRef =
      FirebaseFirestore.instance.collection('buy_and_sell');

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void addRemoveFavItem(String? documentId) {
    if (!favorites.contains(documentId)) {
      favorites.add(documentId!);
    } else {
      favorites.remove(documentId);
    }
    saveFavorites();
    update();
    print(favorites);
  }

  Future<void> saveFavorites() async {
    await prefs.setStringList(_favoritesKey, favorites.toList());
  }

  Future<void> loadFavorites() async {
    final savedFavorites = prefs.getStringList(_favoritesKey);
    if (savedFavorites != null) {
      favorites.addAll(savedFavorites);
    }
  }

  Stream<List<BuySell>> fetchMarketFavoriteItems() {
    return buySellRef.snapshots().map((snapshot) {
      return snapshot.docs
          .where((e) => favorites.contains(e['docid']))
          .map((doc) {
        Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
        return BuySell.fromJson(data);
      }).toList();
    });
  }
}
