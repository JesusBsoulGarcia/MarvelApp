//
//  CharListRouter.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharListRoutingLogic {
    
    //Métodos para enrutar la vista
    func showDetail()
    func handleSegue(_ segue: UIStoryboardSegue)
}

protocol CharListDataPassing {
    
    //Métodos que contiene los datos necesarios que se pasen a esta vista
    
    var dataStore: CharListDataStore? { get set }
}

class CharListRouter: NSObject, CharListRoutingLogic, CharListDataPassing {
    
    weak var viewController: CharListViewController?
    var dataStore: CharListDataStore?
    
    func showDetail() {
        
        viewController?.performSegue(withIdentifier: Constants.Segues.listToDetail, sender: self)
    }
    
    func handleSegue(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == Constants.Segues.listToDetail, let detail = segue.destination as? CharDetailViewController {
            
            detail.router?.dataStore?.data = dataStore?.data
        }
    }
}
