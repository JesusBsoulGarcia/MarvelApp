//
//  LoadingView.swift
//  MarvelApp
//
//  Created by Jesus on 20/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class LoadingView: BaseView {

    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    var isShowing: Bool = false
    private var keyWindow: UIWindow?
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        configure()
    }
    
    convenience init() {
        
        let keyWindow: UIWindow?
        if #available(iOS 13.0, *) {
            
            keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            
            keyWindow = UIApplication.shared.keyWindow
        }
        
        self.init(frame: keyWindow?.frame ?? CGRect.zero)
        self.keyWindow = keyWindow
    }
    
    func show() {
        
        if !isShowing {
            
            keyWindow?.addSubview(self)
        }
        isShowing = true
    }
    
    func dismiss() {
        
        self.removeFromSuperview()
        isShowing = false
    }
}

private extension LoadingView {
    
    func configure() {
        
        applyBlur()
        aiLoading.startAnimating()
    }
}
