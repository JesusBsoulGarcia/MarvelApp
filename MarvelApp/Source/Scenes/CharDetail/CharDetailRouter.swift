//
//  CharDetailRouter.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharDetailRoutingLogic {
    
    //Métodos para enrutar la vista
}

protocol CharDetailDataPassing {
    
    //Métodos que contiene los datos necesarios que se pasen a esta vista
    
    var dataStore: CharDetailDataStore? { get set }
}

class CharDetailRouter: NSObject, CharDetailRoutingLogic, CharDetailDataPassing {
    
    weak var viewController: CharDetailViewController?
    var dataStore: CharDetailDataStore?
}
