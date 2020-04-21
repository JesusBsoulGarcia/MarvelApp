//
//  AuthManager.swift
//  MarvelApp
//
//  Created by Jesus on 16/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import Alamofire
import MarvelClient

func getAPIClient() -> APIClient {
    
    let apiClient = APIClient.default
    apiClient.sessionManager = getSessionManager()
    return apiClient
}

fileprivate func getSessionManager() -> Alamofire.SessionManager {
    
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = nil
    configuration.httpShouldUsePipelining = true
    
    let handler = MarvelAuthManager()
    let manager = Alamofire.SessionManager(
        configuration: configuration,
        serverTrustPolicyManager: nil)
    
    manager.adapter = handler
    
    return manager
}

fileprivate final class MarvelAuthManager: RequestAdapter {
    
    private let whiteList = Array<String>()
    
    private var notificationCenter: NotificationCenter {
        
        NotificationCenter.default
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var urlRequest = urlRequest
        
        let timeStamp = NSDate().timeIntervalSince1970
        let apiKey = Constants.Marvel.publicKey
        let hash = "\(timeStamp)\(Constants.Marvel.privateKey)\(apiKey)".md5
        
        let newQS: String
        if urlRequest.url?.query?.isEmpty ?? true {
            
            newQS = "?hash=\(hash)&apikey=\(apiKey)&ts=\(timeStamp)"
        } else {
            
            newQS = "&hash=\(hash)&apikey=\(apiKey)&ts=\(timeStamp)"
        }
        let newURL = URL(string: "\(urlRequest.url?.absoluteString ?? "")\(newQS)")
        urlRequest.url = newURL
        
        return urlRequest
    }
}
