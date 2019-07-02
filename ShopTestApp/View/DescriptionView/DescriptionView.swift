//
//  DescriptionView.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit


class DescriptionView : UIView {
    
    convenience init(sender : UIViewController, product : ProductModel) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        configureUI(product: product)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func exitAction() {
        self.removeFromSuperview()
    }
    
    private func configureUI(product : ProductModel) {
        self.backgroundColor = UIColor.white
        
        let priceLabel = UILabel()
        let titleLabel = UILabel()
        let descriptionTV = UITextView()
        let exitView = UIView()
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionTV.font = UIFont.systemFont(ofSize: 18)
        
        titleLabel.text = product.title
        priceLabel.text = String(describing: product.price)
        descriptionTV.text = product.descriptionStr
        descriptionTV.isEditable = false
        
        titleLabel.sizeToFit()
        priceLabel.sizeToFit()
        descriptionTV.sizeToFit()
        
        titleLabel.frame.origin = CGPoint(x: 20, y: 120)
        priceLabel.frame.origin = CGPoint(x: self.frame.width - priceLabel.frame.width - 20, y: 120)
        descriptionTV.frame.origin = CGPoint(x: 20, y: 180)
        exitView.frame = CGRect(x: 20, y: 50, width: 40, height: 40)
        exitView.backgroundColor = UIColor.black
        exitView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitAction)))
        
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(descriptionTV)
        self.addSubview(exitView)
    }
    
}
