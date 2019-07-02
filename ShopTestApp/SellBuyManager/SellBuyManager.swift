//
//  SellBuyManager.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SellBuyManager {
    
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    public static var shared = SellBuyManager()
    
    init() {
        SellBuyManager.products = DBManager.retrieveProducts()
        SellBuyManager.products.append(contentsOf: DBManager.returnDefaultProducts())
        getSellSignal()
        sellBRToRetrieve.accept(SellBuyManager.products)
    }
    
    let dBag = DisposeBag()
    
    let sellBRToSave = BehaviorRelay(value: [ProductModel]())
    let sellBRToRetrieve = BehaviorRelay(value: [ProductModel]())
    
    fileprivate static var products = [ProductModel]()
    
    fileprivate func getSellSignal() {
        sellBRToSave.subscribe { (product) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                if let element = product.element {
                    if element.count > 0 {
                        SellBuyManager.products.append(contentsOf: element)
                        DBManager.saveProduct(model: element[0])
                        SellBuyManager.shared.sellBRToRetrieve.accept(SellBuyManager.products)
                    }
                }
            })
        } .disposed(by: dBag)
    }
    
    
    public func getBuySignal(data : ProductModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            self.serialQueue.sync {
                DBManager.deleteProduct(model: data)
                for i in 0 ... SellBuyManager.products.count - 1 {
                    if SellBuyManager.products[i] === data {
                        SellBuyManager.products.remove(at: i)
                        break
                    }
                }
                SellBuyManager.shared.sellBRToRetrieve.accept(SellBuyManager.products)
            }
        }
    }
    
}
