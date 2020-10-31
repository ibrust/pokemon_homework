//
//  NetworkManager.swift
//  pokemon_homework
//
//  Created by Field Employee on 10/29/20.
//

//
//  NetworkManager.swift
//  networking_homework
//
//  Created by Field Employee on 10/27/20.
//

import UIKit

public final class NetworkManager{
    static var shared = NetworkManager()
    var session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch_list_of_pokemon(_ url: String, completion: @escaping () -> () ){
        guard let url_obj = URL(string:url) else{return}
        session.dataTask(with: url_obj) { (data, response, error) in
            if let _ = error{return}
            guard let data = data else{return}
            
            do {
                let json_response = try JSONDecoder().decode(Pokemon_Previous_Next_And_Results.self, from: data)
                
                for index in page_offset..<(page_offset + page_size) {
                    pokemon_previous_next_and_results.results[index] = json_response.results[index]
                }
                pokemon_previous_next_and_results.previous = json_response.previous
                pokemon_previous_next_and_results.next = json_response.next
                completion()
            } catch let json_error {print("error unserializing json in fetch_list_of_pokemon: ", json_error)}
            return
        }.resume()
    }
    
    func fetch_single_pokemons_data(url: String, index: Int, completion: @escaping () -> () ){
        guard let url_obj = URL(string:url) else{return}
        session.dataTask(with: url_obj) { (data, response, error) in
            if let _ = error{return}
            guard let data = data else{return}
            
            do {
                let json_response = try JSONDecoder().decode(Pokemon_Abilities_Moves_ID_Sprites_Types.self, from: data)
                array_of_abilities_moves_id_sprites_types[index] = json_response
                completion()
            } catch let json_error{print("error unserializing json in fetch_single_pokemons_data: ", json_error)}
            return
        }.resume()
    }
    
    
    func fetch_single_image(url: String, completion: @escaping (UIImage?) -> () ){
        guard let url_obj = URL(string:url) else{return}
        session.dataTask(with: url_obj) { (data, response, error) in
            if let _ = error{print("ERROR");return}
            guard let data = data else{print("ERROR");return}
            
            completion(UIImage(data: data))
            return
        }.resume()
    }
}

