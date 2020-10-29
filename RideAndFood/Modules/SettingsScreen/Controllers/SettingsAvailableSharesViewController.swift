//
//  AvailableSharesViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

private let cellIdentifier = "SettingsAvailableSharesCell"

class SettingsAvailableSharesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    let viewModel = SettingsAvailableSharesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = PromotionsStrings.title.text()
        setupTable()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PromotionsViewController,
           let promotionType = sender as? PromotionType {
            vc.promotionType = promotionType
        }
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(TableItem.self)
            .subscribe(onNext: { item in
                item.completion?(self)
                if let segue = item.segue {
                    self.performSegue(withIdentifier: segue, sender: PromotionType.init(rawValue: item.title))
                }
            }).disposed(by: bag)
    }
}
