import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../model/pokedex_list.dart';
import '../model/pokedex_detail.dart';
import '../../utils/constants.dart';

class PokeDataModel extends Model {
  Uri uri = Uri.parse(Network.api);
  bool _isloading = false;
  bool get isloading => _isloading;
  late PokedexList _pokedexList;
  final List<PokedexDetail> _pokedexDetail = [];

  PokedexList get allPokedex {
    return _pokedexList;
  }

  Future<void> fetchPokemons() {
    _isloading = true;
    notifyListeners();
    return http.get(uri).then<void>((http.Response response) {
      final dynamic fetchedRes = json.decode(response.body);
      final PokedexList pokedexList;
      if (fetchedRes == null) {
        _isloading = false;
        notifyListeners();
        return;
      }

      pokedexList = PokedexList.fromMap(fetchedRes);

      for (var dex in pokedexList.results) {
        http.get(Uri.parse(dex.url)).then((http.Response response) {
          final dynamic fetchedDetailRes = json.decode(response.body);
          final PokedexDetail pokedexDetail;
          if (fetchedDetailRes == null) {
            _isloading = false;
            notifyListeners();
          }
          pokedexDetail = PokedexDetail.fromJson(fetchedDetailRes);
          _pokedexDetail.add(pokedexDetail);
          print(pokedexDetail);
        });
      }
      _isloading = false;
      notifyListeners();
      return;
    }).catchError((onError) {
      _isloading = false;
      notifyListeners();
    }).timeout(const Duration(seconds: Network.timeOut), onTimeout: () {
      _isloading = false;
      notifyListeners();
      return;
    });
  }
}
