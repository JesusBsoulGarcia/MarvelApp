//
//  ConnectionManager.swift
//  MarvelApp
//
//  Created by Jesus on 21/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import MarvelClient
import Alamofire

protocol ConnectionManager {
    
    func start()
    func stop()
    func isReachable() -> Bool
}

class ConnectionManagerImp: ConnectionManager {
    
    static let sharedInstance = ConnectionManagerImp()
    private var reachability: Alamofire.NetworkReachabilityManager?

    private var reachable: Bool = true
    
    init() {
        
        reachability = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        reachability?.listener = { status in
            
            self.reachable = status != .notReachable && status != .unknown
        }
    }
    
    func start() {
        
        reachability?.startListening()
    }
    
    func stop() {
        
        reachability?.stopListening()
    }
    
    func isReachable() -> Bool {
        
        return self.reachable
    }
}
