//
//  TabBarView.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit


class TabBarView : UIView {
    
    var sender = UIViewController()
    
    convenience init(sender : UIViewController) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        self.sender = sender
        self.configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func selectBuy() {
        if sender is SellVC {
            sender.performSegue(withIdentifier: "goToBuy", sender: sender)
        }
    }
    
    @objc private func selectSell() {
        if sender is BuyVC {
            sender.performSegue(withIdentifier: "goToSell", sender: sender)
        }
    }
    
    private func configureUI() {
        let sellButton = UIButton()
        let buyButton = UIButton()
        
        self.backgroundColor = UIColor.black
        
        buyButton.frame = CGRect(x: 0, y: 0, width: self.frame.width / 2 - 0.5, height: 79)
        sellButton.frame = CGRect(x: self.frame.width / 2 + 0.5, y: 0, width: self.frame.width / 2 - 0.5, height: 79)
        
        buyButton.backgroundColor = UIColor.white
        sellButton.backgroundColor = UIColor.white
        
        sellButton.setTitle("Sell", for: UIControl.State())
        buyButton.setTitle("Buy", for: UIControl.State())
        
        if sender is SellVC {
            sellButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        else if sender is BuyVC {
            buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        sellButton.setTitleColor(UIColor.black, for: UIControl.State())
        buyButton.setTitleColor(UIColor.black, for: UIControl.State())
        
        sellButton.addTarget(self, action: #selector(selectSell), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(selectBuy), for: .touchUpInside)
        
        self.addSubview(sellButton)
        self.addSubview(buyButton)
    }
    
}
