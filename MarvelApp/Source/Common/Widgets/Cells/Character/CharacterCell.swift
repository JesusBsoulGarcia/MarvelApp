//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Jesus on 20/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {

    @IBOutlet weak var imvPortrait: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        imvPortrait.kf.indicatorType = .activity
    }
    
    func bind(_ object: ListChar) {
        
        if let path = object.thumbnail?.path, let ext = object.thumbnail?.extension {
            
            imvPortrait.kf.setImage(with: URL(string: "\(path).\(ext)"))
        } else {
            
            imvPortrait.image = nil
        }
        
        lblName.text = object.name
    }
}
