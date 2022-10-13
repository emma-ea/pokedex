# pokedex

pokedex app

Pokedex app uses scoped model package to handle all state data of the application. From there API Requests are made using the http package. Favourite pokemons are cached by storing the URLs of the pokemon endpoints and fetched when the user runs the app.

## Dependencies

### Network requests

http: ^0.13.5

### State management

scoped_model: ^2.0.0

### UI

flutter_svg: ^1.1.5

cached_network_image: ^3.2.2

### Local Cache

hive: ^2.2.3

hive_flutter: ^1.1.0

### Internet Connectivity

connectivity_plus: ^2.3.9

### Service Locator

get_it: ^7.2.0
