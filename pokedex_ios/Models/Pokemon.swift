import Foundation


struct GenerationResponse: Codable {
    let id: Int
    let name: String
    let pokemonSpecies: [PokemonSpecies]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case pokemonSpecies = "pokemon_species"
    }
}

struct PokemonSpecies: Codable {
    let name: String
    let url: String
    var id: String { name }
}

struct PokemonListResponse: Codable {
    let results: [PokemonResult]
}

struct PokemonResult: Codable {
    let name: String
    let url: String
}

struct PokemonDetailResponse: Codable {
    let id: Int
    let weight: Int
    let height: Int
    let stats: [Stat]
    let types: [Types]
    let sprites: Sprites
    let species: NamedAPIResource
}

struct Types: Codable {
    let slot: Int
    let type: NamedAPIResource
}

struct Stat: Codable {
    let baseStat: Int
    let stat: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct Sprites: Codable {
    let other: OtherSprites
}

struct OtherSprites: Codable {
    let officialArtwork: ArtSprites
    let home: ArtSprites
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case home
    }
}

struct ArtSprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

struct PokemonSpeciesDetailResponse: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: NamedAPIResource
    let version: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}
