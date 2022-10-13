class Network {
  static const String baseApi = "https://pokeapi.co/api/v2/pokemon/";
  static const int timeOut = 60;
  static const String fetchMsg = "Fetching pokedex index...";
  static const String fetchBatchMsg = "Fetching Batch index...";
  static const String fetchDetailMsg = "Fetching pokedex detail index...";
  static const String timeOutMsg = "$timeOut seconds limit has passed.";
  static const String error400 = "400";
  static const String errorUnknown = "Something went wrong";
}

class AppInfo {
  static const String title = "Pokedex";
  static const String favouritesTitle = "Your Pokedex";
  static const String noFavourites = "No Favourites";
  static const String bottomNavFav = "Favourites";
  static const String bottomNavAllPokedex = "Pokedex";
}

class AppRoutes {
  static const String splash = "/";
  static const String home = "/home";
  static const String detail = "/detail";
}
