//
//  SettingsPersonalDataViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

private let cellIdentifier = "SettingsPersonalDataCell"

class SettingsPersonalDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    let viewModel = SettingsPersonalDataViewModel()
    
    var userId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchItems()
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
    }
}

extension SettingsPersonalDataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        TableHelper.shared.setupHeaderView(view: view)
    }
}
