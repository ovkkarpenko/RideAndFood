//
//  SideMenuViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 31.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

private let cellIdentifier = "SideMenuCell"

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    let bag = DisposeBag()
    let viewModel = SideMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupSideMenu() {
        titleLabel.text = SideMenuStrings.title.text()
        aboutLabel.text = SideMenuStrings.about("1").text()
        sideMenuView.layer.cornerRadius = 20
        
        closeButton.rx.tap.subscribe(onNext: {
            self.dismissAnimate()
        }).disposed(by: bag)
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

extension SideMenuViewController: UITableViewDelegate {
    
    func dismissAnimate() {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    func presentAnimate(_ vc: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        vc.view.window!.layer.add(transition, forKey: nil)
        vc.present(self, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        TableHelper.shared.setupHeaderView(view: view)
    }
}

