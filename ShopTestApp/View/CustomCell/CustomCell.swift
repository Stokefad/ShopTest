//
//  CustomCell.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let priceLabel = UILabel()
    let titleLabel = UILabel()
    let buyButton = UIButton()
    
    var buyActionClosure = {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
     //   super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func buyAction() {
        buyActionClosure()
    }
    
    public func configureUI(product : ProductModel, action : @escaping () -> ()) {
        
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        
        titleLabel.text = product.title
        priceLabel.text = String(describing: product.price)
        buyButton.setTitle("Buy", for: UIControl.State())
        buyButton.backgroundColor = UIColor.red
        buyButton.setTitleColor(UIColor.white, for: UIControl.State())
        
        titleLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        priceLabel.frame.origin = CGPoint(x: self.frame.width - priceLabel.frame.width - 20, y: 10)
        buyButton.frame.size = CGSize(width: 40, height: 30)
        buyButton.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        buyButton.addTarget(self, action: #selector(buyAction), for: .touchUpInside)
        
        self.buyActionClosure = action
        
        if titleLabel.superview == nil, priceLabel.superview == nil, buyButton.superview == nil {
            self.addSubview(titleLabel)
            self.addSubview(priceLabel)
            self.addSubview(buyButton)
        }
    }

}
