//
//  Provider.swift
//  MarvelApp
//
//  Created by Jesus on 21/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

class Provider {

    class var connection: ConnectionManager {
        
        ConnectionManagerImp.sharedInstance
    }
}
