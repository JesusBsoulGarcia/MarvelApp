//
//  UIViewController+Additions.swift
//  MarvelApp
//
//  Created by Jesus on 21/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

enum CallError {
    
    case service
    case connection
}
extension UIViewController {
    
    func showError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showConectivityError() {
        
        showError(title: "Conectividad", message: "Parece que no hay conexión a internet en este momento")
    }
    
    func showServiceError() {
        
        showError(title: "Servicio", message: "Parece que algo fue mal en la llamada a servicio")
    }
}
