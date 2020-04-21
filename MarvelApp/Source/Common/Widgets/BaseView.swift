//
//  BaseView.swift
//  MarvelApp
//
//  Created by Jesus on 20/04/2020.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        
        let contentView = loadViewFromNib()
        
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView)
        onViewLoaded()
    }
    
    func loadViewFromNib() -> UIView {
        
        let retValue: UIView
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            
            retValue = view
        } else {
            
            retValue = UIView()
        }
        
        return retValue
    }
    
    open func onViewLoaded() {}
}

internal extension BaseView {
    
    func applyBlur(color: UIColor = .clear, andAlpha alpha: CGFloat = 0.7, effect: UIBlurEffect = UIBlurEffect(style: .dark)) {
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            
            self.backgroundColor = color
            let blurEffect = effect
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = alpha
            self.insertSubview(blurEffectView, at: 0)
        } else {
            
            self.backgroundColor = UIColor(white: 1, alpha: 0.7)
        }
    }
}
