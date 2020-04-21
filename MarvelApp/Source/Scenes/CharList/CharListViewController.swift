//
//  CharListViewController.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

protocol CharListDisplayLogic {
    
    func totalResults(_ maxResults: Int?)
    func addData(_ data: [ListChar])
    func callError(_ error: CallError)
}

class CharListViewController: UIViewController {
    
    var interactor: CharListBussinessLogic?
    var router: (NSObjectProtocol & CharListRoutingLogic & CharListDataPassing)?
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblPagesLoaded: UILabel!
    @IBOutlet weak var tblCharacters: UITableView!
    
    
    private var currentPageDefault: Int = 1
    private var currentPageSearch: Int = 1
    private var maxResults = 0
    private var isSearching: Bool {
        
        get {
            
            !(txtSearch.text?.isEmpty ?? true)
        }
    }
    private var currentPage: Int {
        
        get {
            
            isSearching ? currentPageSearch : currentPageDefault
        }
    }
    
    private var loading: LoadingView!
    
    private var datasource: [ListChar] = Array()
    private var firstLoad: Bool = true
    
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
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        if firstLoad {
            
            firstLoad = !firstLoad
            loading = LoadingView()
            interactor?.getCharacters(onPage: currentPage, withName: txtSearch.text)
            loading.show()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        router?.handleSegue(segue)
    }
}

extension CharListViewController: CharListDisplayLogic {
    
    func totalResults(_ maxResults: Int?) {
        
        self.maxResults = maxResults ?? 0
        lblPagesLoaded.text = "\(datasource.count) de \(self.maxResults)"
    }
    
    func addData(_ data: [ListChar]) {
        
        var indexPaths = [IndexPath]()
        for i in datasource.count ..< datasource.count + data.count {
            
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        datasource.append(contentsOf: data)
        
        tblCharacters.beginUpdates()
        self.tblCharacters.insertRows(at: indexPaths, with: .none)
        tblCharacters.endUpdates()
        
        loading.dismiss()
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

private extension CharListViewController {

	func setup() {
        
        let viewController = self
        let interactor = CharListInteractor()
        let presenter = CharListPresenter()
        let router = CharListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func configure() {
        
        txtSearch.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        tblCharacters.register(UINib(nibName: Constants.Cell.charCell, bundle: nil), forCellReuseIdentifier: Constants.Cell.charCell)
        tblCharacters.estimatedRowHeight = 64
        tblCharacters.tableFooterView = UIView()
        txtSearch.delegate = self
    }
    
    @objc func textChanged() {
        
        reset()
        loading.show()
        interactor?.getCharacters(onPage: currentPage, withName: txtSearch.text)
    }
    
    func addPage() {
        
        if isSearching {
            
            currentPageSearch += 1
        } else {
            
            currentPageDefault += 1
        }
    }
    
    func reset() {
        
        datasource.removeAll()
        tblCharacters.reloadData()
        lblPagesLoaded.text = ""
        currentPageDefault = 1
        currentPageSearch = 1
    }
}

extension CharListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tblCharacters.dequeueReusableCell(withIdentifier: Constants.Cell.charCell) as? CharacterCell {
            
            cell.bind(datasource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension CharListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == datasource.count - 2 && datasource.count < maxResults {
            
            addPage()
            interactor?.getCharacters(onPage: currentPage, withName: txtSearch.text)
            loading.show()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        router?.dataStore?.data = datasource[indexPath.row]
        router?.showDetail()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        64
    }
}

extension CharListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return !loading.isShowing
    }
}
