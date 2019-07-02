//
//  DBManager.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreData

class DBManager {
    
    public static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public class func saveProduct(model : ProductModel) {
        let productModel = Product(context: context)
        
        productModel.descriptionStr = model.descriptionStr
        productModel.title = model.title
        productModel.price = model.price
        
        do {
            try context.save()
        }
        catch {
            print("Failed to save product")
        }
    }
    
    public class func retrieveProducts() -> [ProductModel] {
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        var result = [Product]()
        var resultForReturn = [ProductModel]()
        
        do {
            result = try context.fetch(request)
        }
        catch {
            print("Failed to retrieve products")
        }
        
        for res in result {
            let model = ProductModel()
            if let desc = res.descriptionStr {
                model.descriptionStr = desc
            }
            model.price = res.price
            if let title = res.title {
                model.title = title
            }
            
            resultForReturn.append(model)
        }
        
        return resultForReturn
    }
    
    public class func deleteProduct(model : ProductModel) {
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        var result = [Product]()
        
        do {
            result = try context.fetch(request)
        }
        catch {
            print("Failed to retrieve products")
        }
        
        for res in result {
            if res.descriptionStr == model.descriptionStr, res.title == model.title, res.price == model.price {
                context.delete(res)
                
                do {
                    try context.save()
                }
                catch {
                    print("Failed to delete")
                }
            }
        }
        
    }
    
    public class func returnDefaultProducts() -> [ProductModel] {
        guard
            let url = Bundle.main.url(forResource: "Data", withExtension: "plist"),
            let list = NSDictionary(contentsOf: url) as? Dictionary<String, Any> else {
                print("no")
                return []
        }
        
        var dictList = [Dictionary<String, Any>]()
        
        dictList.append(list["ItemOne"] as! [String : Any])
        dictList.append(list["ItemTwo"] as! [String : Any])
        dictList.append(list["ItemThree"] as! [String : Any])
        
        var modelList = [ProductModel]()
        
        for item in dictList {
            let model = ProductModel()
            model.descriptionStr = item["description"] as! String
            model.price = item["price"] as! Double
            model.title = item["title"] as! String
            
            modelList.append(model)
        }
        
        
        return modelList
    }
    
}
