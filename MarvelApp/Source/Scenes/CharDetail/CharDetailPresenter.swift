//
//  CharDetailPresenter.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit
import MarvelClient

protocol CharDetailPresentationLogic {
    
    //Métodos para la lógica de presentación de los datos
    func dataLoaded(_ data: CharactersResponse)
    func serviceError()
    func connectivityError()
}

class CharDetailPresenter: CharDetailPresentationLogic {
    
    var viewController: CharDetailDisplayLogic?
    
    func dataLoaded(_ data: CharactersResponse) {
        
        var charData: DetailChar!
        if let char = data.data?.results?.first {
            
            charData = DetailChar(from: char)
            viewController?.show(charData)
        }
    }
    
    func serviceError() {
        
        viewController?.callError(.service)
    }
    
    func connectivityError() {
        
        viewController?.callError(.connection)
    }
}
