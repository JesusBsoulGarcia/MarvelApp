//
//  String+Additions.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

extension String {
    
    var md5: String {
        
        return HMAC.hash(self, algo: .MD5)
    }
}
