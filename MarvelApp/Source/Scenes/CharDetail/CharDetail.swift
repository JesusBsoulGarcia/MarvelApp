//
//  CharDetail.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharDetailDisplayLogic {}

class CharDetailViewController: UIViewController {
    
    var interactor: CharDetailBussinessLogic?
    var router: (NSObjectProtocol & CharDetailRoutingLogic & CharDetailDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
}

extension CharDetailViewController: CharDetailDisplayLogic {}

private extension CharDetailViewController {

	private func setup() {
        
        let viewController = self
        let interactor = CharDetailInteractor()
        let presenter = CharDetailPresenter()
        let router = CharDetailRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}