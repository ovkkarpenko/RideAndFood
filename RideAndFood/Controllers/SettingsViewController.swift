//
//  SettingsViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 19.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

private let cellIdentifier = "SettingCell"

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = SettingsStrings.title.text()
        setupTable()
    }
    
    func setupTable() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(TableItem.self)
            .subscribe(onNext: { item in
                item.completion?(self)
                if let segue = item.segue {
                    self.performSegue(withIdentifier: segue, sender: nil)
                }
            }).disposed(by: bag)
        
        viewModel.fetchItems(userId: 33)
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        TableHelper.shared.setupHeaderView(view: view)
    }
}
