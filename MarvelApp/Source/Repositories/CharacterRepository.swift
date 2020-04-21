//
//  File.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import MarvelClient

protocol CharacterRepository {
    
    func getCharacters(limit: Int, offset: Int, name: String?, result: @escaping (CharactersResponse?, Error?) -> Void)
    func getCharacter(id: Int, result: @escaping (CharactersResponse?, Error?) -> Void)
}

final class CharacterRepositoryImp: CharacterRepository {
    
    private var apiClient: APIClient
        
    init() {
        
        apiClient = getAPIClient()
    }
    
    func getCharacters(limit: Int, offset: Int, name: String?, result: @escaping (CharactersResponse?, Error?) -> Void) {
        
        let request = MarvelClient.Characters.GetCharacterList.Request(limit: limit, offset: offset, nameStartsWith: name)
        apiClient.makeRequest(request) { response in
            
            switch (response.result) {
                
            case .success(let data):
                
                if let data = data.response as? CharactersResponse {
                    
                    result(data, nil)
                } else {
                    
                    result(nil, nil)
                }
                
            case .failure(let error):
                
                result(nil, error)
            }
        }
    }
    
    func getCharacter(id: Int, result: @escaping (CharactersResponse?, Error?) -> Void) {
        
        let request = MarvelClient.Characters.GetCharacterDetail.Request(charId: "\(id)")
        apiClient.makeRequest(request) { response in
            
            switch (response.result) {
                
            case .success(let data):
                
                if let data = data.response as? CharactersResponse {
                    
                    result(data, nil)
                } else {
                    
                    result(nil, nil)
                }
                
            case .failure(let error):
                
                result(nil, error)
            }
        }
    }
}
