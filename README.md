# Pokedex

**Pokedex**

a Flutter application that allows interacting with Pokemons.

#### Pages

- Splash Screen
   - shown while application is starting.
- All Pokemons
   - fetch the Pokemons from this API: https://pokeapi.co
   - uses pagination since there are lots of Pokemons to be listed coming from API.
- Favourites
   - When a Pokemon is marked as favourite by clicking **Mark as favourite** button on the **Pokemon details page**, it is shown on this tab.
   - The number of Pokemons marked as favourite, are shown near the tab text.
   - Pokemons that are marked as favourite are persisted and the data is stored on disk. So, after a Pokemon is marked as favourite, it is still shown under **Favourites** tab even after application is closed and started again.
- Pokemon details page
   - use of **SliverAppBar** is used for implementing the app bar of this page.
   - calculating BMI use this formula: **weight / (height^2)** without caring any units.
   - calculating **Avg. Power** under **Base stats**, use this formula: **(Hp + Attack + Defense + Special Attack + Special Defense + Speed) / 6**
   - **Remove from favourites** button removes the related Pokemon from the list shown on **Favourites** tab.
