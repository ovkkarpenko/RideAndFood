//
//  SettingsLanguageViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

private let cellIdentifier = "SettingLanguageCell"

class SettingsLanguageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    let viewModel = SettingsLanguageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(TableItem.self)
            .subscribe(onNext: { [weak self] item in
                self?.viewModel.selectLanguage(checkedItem: item)
            }).disposed(by: bag)
        
        viewModel.fetchItems()
    }
}
