//
//  DetailChar.swift
//  MarvelApp
//
//  Created by Jesus on 20/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import MarvelClient

struct DetailChar {
    
    public var name: String?
    public var description: String?
    public var comics: [String] = Array()
    
    init(from response: CharData) {
        
        name = response.name
        description = response.description
        response.comics?.items?.forEach {
            
            comics.append($0.name ?? "")
        }
    }
}
