//
//  ComicCell.swift
//  MarvelApp
//
//  Created by Jesus on 20/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    func bind(_ data: String) {
        
        lblTitle.text = data
    }
}
