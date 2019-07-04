//
//  BuyVC.swift
//  ShopTestApp
//
//  Created by Igor-Macbook Pro on 02/07/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class BuyVC: UIViewController, UITableViewDelegate {
  
    @IBOutlet weak var tabbarContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let dBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        tabbarContainer.addSubview(TabBarView(sender: self))
        self.driveTV()
        self.selectCell()
    }

    private func configureTV() {
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(returnTVHeight(string: SellBuyManager.shared.sellBRToRetrieve.value[indexPath.row].title) + 20)
    }
    
}

// rx tableview

extension BuyVC {
    private func driveTV() {
        SellBuyManager.shared.sellBRToRetrieve.asDriver().drive(tableView.rx.items(cellIdentifier: "CustomCell", cellType: CustomCell.self)) { row, data, cell in
            cell.configureUI(product: data, action: {
                SellBuyManager.shared.getBuySignal(data: data)
            })
            } .disposed(by: dBag)
    }
    
    private func selectCell() {
        tableView.rx.itemSelected.subscribe({ indexPath in
            if let indexPath = indexPath.element {
                self.view.addSubview(DescriptionView(sender: self, product: SellBuyManager.shared.sellBRToRetrieve.value[indexPath.row]))
            }
        }).disposed(by: dBag)
    }
}

// cell sizer

extension BuyVC {
    private func returnTVHeight(string : String) -> Double {
        
        let descriptionTV = UITextView()
        
        descriptionTV.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.3, height: 10000)
        descriptionTV.font = UIFont.systemFont(ofSize: 17)
        
        descriptionTV.text = string
        descriptionTV.sizeToFit()
        
        return Double(descriptionTV.frame.height)
    }
}
