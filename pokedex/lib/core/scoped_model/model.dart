import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../data/local/local_store.dart';
import '../model/pokedex_list.dart';
import '../model/pokedex_detail.dart';
import '/utils/constants.dart';
import '/utils/api_response.dart';
import '../exception/pokedex_exception.dart';

class PokeDataModel extends Model {
  final int _limit = 20;
  final int _offset = 0;
  late Uri uri;
  late PokedexList _pokedexList;
  final List<PokedexDetail> _pokedexDetail = [];
  late ApiResponse<List<PokedexDetail>> pokedexResponse;

  List<PokedexDetail> get allPokedex => List.from(_pokedexDetail);

  final Set<PokedexDetail> _favourites = {};

  List<PokedexDetail> get favourites => List.from(_favourites);

  int get favouriteCount => favourites.length;

  PokedexList get pokedexList => _pokedexList;

  // final Set<dynamic> _allFavUrls = {};
  late Preferences _prefs;

  bool _isFav = false;
  bool get isFav => _isFav;
  final Map<dynamic, dynamic> _favDexMap = {};

  void isFavouritePokedex(id) {
    if (_favDexMap.containsKey(id)) {
      _isFav = true;
      notifyListeners();
      return;
    }
    _isFav = false;
    notifyListeners();
  }

  PokeDataModel() {
    uri = Uri.parse("${Network.baseApi}?offset=$_offset&limit=$_limit");
  }

  bool runningBatch = false;

  Future<void> loadNextBatch() async {
    if (!runningBatch) {  //  run next if the current is done
      runningBatch = true;
      pokedexResponse = ApiResponse.loading(Network.fetchBatchMsg);
      notifyListeners();
      await fetchPokemons(Uri.parse(_pokedexList.next), true);
      runningBatch = false;
    }
  }

  Future<void> fetchPokemons(Uri uri, [bool nextBatch = false]) async {
    var results = await _fetchResults(uri, nextBatch);
    await _fetchResultsDetail(results, nextBatch);
  }

  void addFavourite(PokedexDetail pokedex) {
    String url = "${Network.baseApi}${pokedex.id}";
    // _allFavUrls.add(url);
    _favDexMap[pokedex.id] = url;
    _favourites.add(pokedex);

    _prefs.setFav(_favDexMap);
    notifyListeners();
  }

  void removeFavourite(PokedexDetail pokedex) {
    _favDexMap.remove(pokedex.id);
    _favourites.remove(pokedex);
    _prefs.setFav(_favDexMap);
    notifyListeners();
  }

  setPreferences(Preferences pref) {
    _prefs = pref;
  }

  getFavourites() {
    _getFavFromUrl(_prefs.getFav()!.values.toList());
    _favDexMap.addAll(_prefs.getFav()!);
    notifyListeners();
  }

  Future<void> _getFavFromUrl(List<dynamic> results) async {
    results.forEach((dex) async {
      var response =
          await http.get(Uri.parse(dex)).then((http.Response response) {
        final dynamic fetchedRes = json.decode(response.body);
        if (fetchedRes == null) {
          return;
        }
        return fetchedRes;
      }).catchError((onError) {
        return;
      }).timeout(const Duration(seconds: Network.timeOut), onTimeout: () {
        return;
      });
      _favourites.add(PokedexDetail.fromJson(response));
      _pokedexDetail.sort((a, b) => a.id.compareTo(b.id));
    });
  }

  Future<List<Result>> _fetchResults(uri, nextBatch) {
    if (nextBatch) {
      pokedexResponse = ApiResponse.nextLoading(Network.fetchBatchMsg);
      pokedexResponse = ApiResponse.completed(allPokedex);
    } else {
      pokedexResponse = ApiResponse.loading(Network.fetchMsg);
    }
    notifyListeners();
    return http.get(uri).then<List<Result>>((http.Response response) {
      final dynamic fetchedRes = json.decode(response.body);
      if (fetchedRes == null) {
        pokedexResponse = ApiResponse.error(
            FetchException(statusCodeMsg(response.statusCode)).toString());
        notifyListeners();
        return [];
      }
      _pokedexList = PokedexList.fromMap(fetchedRes);
      return _pokedexList.results;
    }).catchError((onError) {
      requestError(onError.toString());
      return [];
    }).timeout(const Duration(seconds: Network.timeOut), onTimeout: () {
      timeOut();
      return [];
    });
  }

  Future<void> _fetchResultsDetail(List<Result> results, nextBatch) async {
    pokedexResponse = ApiResponse.loading(Network.fetchDetailMsg);
    notifyListeners();
    results.forEach((dex) async {
      var response =
          await http.get(Uri.parse(dex.url)).then((http.Response response) {
        final dynamic fetchedDetailRes = json.decode(response.body);
        if (fetchedDetailRes == null) {
          pokedexResponse = ApiResponse.error(
              FetchException(statusCodeMsg(response.statusCode)).toString());
          notifyListeners();
          return;
        }
        return fetchedDetailRes;
      }).catchError((onError) {
        requestError(onError.toString());
        return;
      }).timeout(const Duration(seconds: Network.timeOut), onTimeout: () {
        timeOut();
        return;
      });
      _pokedexDetail.add(PokedexDetail.fromJson(response));
      _pokedexDetail.sort((a, b) => a.id.compareTo(b.id));
      pokedexResponse = ApiResponse.completed(_pokedexDetail);
      notifyListeners();
    });
  }

  void timeOut() {
    pokedexResponse =
        ApiResponse.error(TimeoutException(Network.timeOutMsg).toString());
    notifyListeners();
  }

  void requestError(error) {
    pokedexResponse = ApiResponse.error(RequestException(error).toString());
    notifyListeners();
  }

  String statusCodeMsg(int code) {
    switch (code) {
      case 400:
        return Network.error400;
      default:
        return Network.errorUnknown;
    }
  }
}
