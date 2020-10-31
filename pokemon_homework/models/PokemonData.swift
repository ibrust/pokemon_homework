//
//  PokemonData.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

import UIKit

var page_offset = 0
var page_size = 27
var max_pokemon = 151

var sprite_images = [UIImage?](repeating: nil, count: max_pokemon)
var pokemon_previous_next_and_results = Pokemon_Previous_Next_And_Results()
var array_of_abilities_moves_id_sprites_types = [Pokemon_Abilities_Moves_ID_Sprites_Types?](repeating: nil, count: max_pokemon)

// code for handling first request for the list of pokemon
struct Pokemon_Previous_Next_And_Results: Codable {
    var next: String? = ""
    var previous: String? = ""
    var results = [Pokemon_Name_And_URL](repeating: Pokemon_Name_And_URL(), count: max_pokemon)
}

struct Pokemon_Name_And_URL: Codable {
    var name: String? = ""
    var url: String? = ""       // url used for the 2nd request - to get more detailed pokemon data
}

// code for handling second request for the individual data on a pokemon
struct Pokemon_Ability_Name_And_URL: Codable {
    var name: String? = ""
    var url: String? = ""
}

struct Pokemon_Ability: Codable {
    var ability: Pokemon_Ability_Name_And_URL? = Pokemon_Ability_Name_And_URL()
    var is_hidden: Bool? = true
    var slot: Int? = 0
}

struct Pokemon_Move: Codable {
    var name: String? = ""
    var url: String? = ""
}

struct Pokemon_Moves: Codable {
    var move: Pokemon_Move? = Pokemon_Move()
}

struct Pokemon_Sprite: Codable {
    var front_default: String? = ""         // this is the URL to fetch the sprite image from 
}

struct Types: Codable {
    var slot: Int? = 0
    var type: Type
}
struct Type: Codable {
    var name: String? = ""
    var url: String? = ""
}

struct Pokemon_Abilities_Moves_ID_Sprites_Types: Codable {
    var abilities: [Pokemon_Ability] = []
    var id: Int? = 0
    var moves: [Pokemon_Moves] = []
    var sprites: Pokemon_Sprite = Pokemon_Sprite()
    var types: [Types] = []
}











