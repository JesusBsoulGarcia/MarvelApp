//
//  ListChar.swift
//  MarvelApp
//
//  Created by Jesus on 20/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import MarvelClient

struct ListChar {
    
    public var id: Int?
    public var name: String?
    public var thumbnail: ListThumbnail?
    
    init(from response: CharData) {
        
        id = response.id
        name = response.name
        thumbnail = ListThumbnail(from: response.thumbnail)
    }
}

struct ListThumbnail {
    
    public var `extension`: String?
    public var path: String?
    
    init(from response: CharThumbnail?) {
        
        if let response = response {
            
            `extension` = response.extension
            path = response.path
        }
    }
}
