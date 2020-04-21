//
//  CharDetailViewController.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharDetailDisplayLogic {
    
    func show(_ data: DetailChar)
    func callError(_ error: CallError)
}

class CharDetailViewController: UIViewController {
    
    var interactor: CharDetailBussinessLogic?
    var router: (NSObjectProtocol & CharDetailRoutingLogic & CharDetailDataPassing)?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var tblComics: UITableView!
    
    var datasource: [String] = Array()
    
    private var loading: LoadingView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configure()
        loading.show()
        interactor?.loadDetail()
    }
}

extension CharDetailViewController: CharDetailDisplayLogic {
    
    func show(_ data: DetailChar) {
        
        loading.dismiss()
        lblTitle.text = data.name
        lblDescription.text = data.description
        datasource = data.comics
        tblComics.reloadData()
    }
    
    func callError(_ error: CallError) {
        
        loading.dismiss()
        switch error {
        case .connection:
            
            showConectivityError()
        case .service:
            
            showServiceError()
        }
    }
}

private extension CharDetailViewController {

	func setup() {
        
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
    
    func configure() {
        
        loading = LoadingView()
        tblComics.register(UINib(nibName: Constants.Cell.comicCell, bundle: nil), forCellReuseIdentifier: Constants.Cell.comicCell)
        tblComics.tableFooterView = UIView()
    }
}

extension CharDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tblComics.dequeueReusableCell(withIdentifier: Constants.Cell.comicCell) as? ComicCell {
            
            cell.bind(datasource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension CharDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
}
