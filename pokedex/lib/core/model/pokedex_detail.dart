class PokedexDetail {
  PokedexDetail({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });
  late final List<Abilities> abilities;
  late final int baseExperience;
  late final List<Forms> forms;
  late final List<GameIndices> gameIndices;
  late final int height;
  late final List<dynamic> heldItems;
  late final int id;
  late final bool isDefault;
  late final String locationAreaEncounters;
  late final List<Moves> moves;
  late final String name;
  late final int order;
  late final List<dynamic> pastTypes;
  late final Species species;
  late final Sprites sprites;
  late final List<Stats> stats;
  late final List<Types> types;
  late final int weight;
  
  PokedexDetail.fromJson(Map<String, dynamic> json){
    abilities = List.from(json['abilities']).map((e)=>Abilities.fromJson(e)).toList();
    baseExperience = json['base_experience'];
    forms = List.from(json['forms']).map((e)=>Forms.fromJson(e)).toList();
    gameIndices = List.from(json['game_indices']).map((e)=>GameIndices.fromJson(e)).toList();
    height = json['height'];
    heldItems = List.castFrom<dynamic, dynamic>(json['held_items']);
    id = json['id'];
    isDefault = json['is_default'];
    locationAreaEncounters = json['location_area_encounters'];
    moves = List.from(json['moves']).map((e)=>Moves.fromJson(e)).toList();
    name = json['name'];
    order = json['order'];
    pastTypes = List.castFrom<dynamic, dynamic>(json['past_types']);
    species = Species.fromJson(json['species']);
    sprites = Sprites.fromJson(json['sprites']);
    stats = List.from(json['stats']).map((e)=>Stats.fromJson(e)).toList();
    types = List.from(json['types']).map((e)=>Types.fromJson(e)).toList();
    weight = json['weight'];
  }

  @override
  String toString() {
    return "$id $name $height\n";
  }
}

class Abilities {
  Abilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
  late final Ability ability;
  late final bool isHidden;
  late final int slot;
  
  Abilities.fromJson(Map<String, dynamic> json){
    ability = Ability.fromJson(json['ability']);
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }
}

class Ability {
  Ability({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Ability.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class Forms {
  Forms({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Forms.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class GameIndices {
  GameIndices({
    required this.gameIndex,
    required this.version,
  });
  late final int gameIndex;
  late final Version version;
  
  GameIndices.fromJson(Map<String, dynamic> json){
    gameIndex = json['game_index'];
    version = Version.fromJson(json['version']);
  }
}

class Version {
  Version({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Version.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class Moves {
  Moves({
    required this.move,
    required this.versionGroupDetails,
  });
  late final Move move;
  late final List<VersionGroupDetails> versionGroupDetails;
  
  Moves.fromJson(Map<String, dynamic> json){
    move = Move.fromJson(json['move']);
    versionGroupDetails = List.from(json['version_group_details']).map((e)=>VersionGroupDetails.fromJson(e)).toList();
  }
}

class Move {
  Move({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Move.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class VersionGroupDetails {
  VersionGroupDetails({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });
  late final int levelLearnedAt;
  late final MoveLearnMethod moveLearnMethod;
  late final VersionGroup versionGroup;
  
  VersionGroupDetails.fromJson(Map<String, dynamic> json){
    levelLearnedAt = json['level_learned_at'];
    moveLearnMethod = MoveLearnMethod.fromJson(json['move_learn_method']);
    versionGroup = VersionGroup.fromJson(json['version_group']);
  }
}

class MoveLearnMethod {
  MoveLearnMethod({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  MoveLearnMethod.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class VersionGroup {
  VersionGroup({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  VersionGroup.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class Species {
  Species({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Species.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}

class Sprites {
  Sprites({
    required this.backDefault,
     this.backFemale,
    required this.backShiny,
     this.backShinyFemale,
    required this.frontDefault,
     this.frontFemale,
    required this.frontShiny,
     this.frontShinyFemale,
    required this.other,
  });
  late final String backDefault;
  late final Null backFemale;
  late final String backShiny;
  late final Null backShinyFemale;
  late final String frontDefault;
  late final Null frontFemale;
  late final String frontShiny;
  late final Null frontShinyFemale;
  late final Other other;
  
  Sprites.fromJson(Map<String, dynamic> json){
    backDefault = json['back_default'];
    backFemale = null;
    backShiny = json['back_shiny'];
    backShinyFemale = null;
    frontDefault = json['front_default'];
    frontFemale = null;
    frontShiny = json['front_shiny'];
    frontShinyFemale = null;
    other = Other.fromJson(json['other']);
  }

}

class Other {
  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
  });
  late final DreamWorld dreamWorld;
  late final Home home;
  late final OfficialArtwork officialArtwork;
  
  Other.fromJson(Map<String, dynamic> json){
    dreamWorld = DreamWorld.fromJson(json['dream_world']);
    home = Home.fromJson(json['home']);
    officialArtwork = OfficialArtwork.fromJson(json['official-artwork']);
  }
}

class DreamWorld {
  DreamWorld({
    required this.frontDefault,
     this.frontFemale,
  });
  late final String frontDefault;
  late final Null frontFemale;
  
  DreamWorld.fromJson(Map<String, dynamic> json){
    frontDefault = json['front_default'];
    frontFemale = null;
  }
}

class Home {
  Home({
    required this.frontDefault,
     this.frontFemale,
    required this.frontShiny,
     this.frontShinyFemale,
  });
  late final String frontDefault;
  late final Null frontFemale;
  late final String frontShiny;
  late final Null frontShinyFemale;
  
  Home.fromJson(Map<String, dynamic> json){
    frontDefault = json['front_default'];
    frontFemale = null;
    frontShiny = json['front_shiny'];
    frontShinyFemale = null;
  }
}

class OfficialArtwork {
  OfficialArtwork({
    required this.frontDefault,
  });
  late final String frontDefault;
  
  OfficialArtwork.fromJson(Map<String, dynamic> json){
    frontDefault = json['front_default'];
  }
}

class Stats {
  Stats({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });
  late final int baseStat;
  late final int effort;
  late final Stat stat;
  
  Stats.fromJson(Map<String, dynamic> json){
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = Stat.fromJson(json['stat']);
  }

}

class Stat {
  Stat({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Stat.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }

}

class Types {
  Types({
    required this.slot,
    required this.type,
  });
  late final int slot;
  late final Type type;
  
  Types.fromJson(Map<String, dynamic> json){
    slot = json['slot'];
    type = Type.fromJson(json['type']);
  }
}

class Type {
  Type({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;
  
  Type.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}