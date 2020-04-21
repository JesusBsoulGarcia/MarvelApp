//
//  CharDetailInteractor.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharDetailBussinessLogic {
    
    //Métodos disponibles para el viewController
    func loadDetail()
}

protocol CharDetailDataStore {
    
    //Datos necesarios por el interactor
    var data: ListChar? { get set }
}

class CharDetailInteractor: CharDetailBussinessLogic, CharDetailDataStore {
    
    var data: ListChar?
    var presenter: CharDetailPresentationLogic?
    
    private var repo: CharacterRepository
    
    init() {
        
        repo = CharacterRepositoryImp()
    }
    
    func loadDetail() {
        
        if Provider.connection.isReachable() {
        repo.getCharacter(id: data?.id ?? -1) { response, error in
            
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
