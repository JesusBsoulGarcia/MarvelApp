//
//  CharListInteractor.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharListBussinessLogic {
    
    func getCharacters(onPage page: Int, withName name: String?)
}

protocol CharListDataStore {
    
    //Datos necesarios por el interactor
    var data: ListChar? { get set }
}

class CharListInteractor: CharListBussinessLogic, CharListDataStore {
    
    var data: ListChar?
    var presenter: CharListPresentationLogic?
    
    private var repo: CharacterRepository
    
    init() {
        
        repo = CharacterRepositoryImp()
    }
    
    func getCharacters(onPage page: Int, withName name: String?){
        
        let limit = 20
        let offset = (page - 1) * 20
        
        if Provider.connection.isReachable() {
            
            repo.getCharacters(limit: limit, offset: offset, name: name) { response, error in
                
                if let response = response {
                    
                    self.presenter?.dataLoaded(response)
                } else {
                    
                    self.presenter?.serviceError()
                }
            }
        } else {
            
            self.presenter?.connectivityError()
        }
    }
}
