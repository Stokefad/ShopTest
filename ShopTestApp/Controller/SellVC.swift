//
//  ViewController.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SellVC: UIViewController {

    @IBOutlet weak var tabbarContainerView: UIView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var priceTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabbarContainerView.addSubview(TabBarView(sender: self))
    }

    
    private func validateInfo() -> Bool {
        guard let priceText = priceTF.text else {
            return false
        }
        
        guard let title = titleTF.text else {
            return false
        }
        
        if title == "" {
            return false
        }
        
        if descriptionTV.text == "" {
            return false
        }
    
        if priceText == "" {
            return false
        }
        
        if Double(priceText) == nil {
            return false
        }
        
        return true
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if validateInfo() {
            sendInfoToManager()
           // self.performSegue(withIdentifier: "goToBuy", sender: self)
        }
        else {
            showErrorView()
        }
    }
    
    private func sendInfoToManager() {
        var productList = [ProductModel]()
        let product = ProductModel()
        product.descriptionStr = descriptionTV.text
        product.price = Double(priceTF.text!)!
        product.title = titleTF.text!
        productList.append(product)
        SellBuyManager.shared.sellBRToSave.accept(productList)
    }
    
    private func showErrorView() {
        let controller = UIAlertController(title: "Invalid info", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}

