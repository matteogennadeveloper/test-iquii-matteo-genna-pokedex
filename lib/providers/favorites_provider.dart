import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_iquii/screens/pokedex_screen.dart';

updateFavorite(bool val, int numeroPokedex) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(numeroPokedex.toString(), val);
}

Future<List<bool>> loadFavorites() async {
  List<bool> favoriteList = [];
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool valore;
  for (int i = 1; i <= pokemonNumberToLoad+1; i++) {
    valore = sharedPreferences.getBool(i.toString()) ?? false;
    favoriteList.add(valore);
  }
  return favoriteList;
}

class FavoritesDataNotifier extends StateNotifier<List<bool>> {
  FavoritesDataNotifier() : super([]);

  caricaLista() async {
    state = await loadFavorites();
  }

  updateFavorites(bool val, int index) {
    var value = state;
    value[index] = val;
    state = [...value];
  }
}

var favoritesData = StateNotifierProvider<FavoritesDataNotifier, List<bool>>(
    (ref) => FavoritesDataNotifier());
