//
//  CharListPresenter.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit
import MarvelClient

protocol CharListPresentationLogic {
    
    //Métodos para la lógica de presentación de los datos
    func dataLoaded(_ data: CharactersResponse)
    func serviceError()
    func connectivityError()
}

class CharListPresenter: CharListPresentationLogic {
    
    var viewController: CharListDisplayLogic?
    
    func dataLoaded(_ data: CharactersResponse) {
        
        var tableData: [ListChar] = Array()
        data.data?.results?.forEach { charData in
            
            tableData.append(ListChar(from: charData))
        }
        
        viewController?.addData(tableData)
        viewController?.totalResults(data.data?.total)
    }
    
    func serviceError() {
        
        viewController?.callError(.service)
    }
    
    func connectivityError() {
        
        viewController?.callError(.connection)
    }
}
