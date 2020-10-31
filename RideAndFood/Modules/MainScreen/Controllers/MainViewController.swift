//
//  MainViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 31.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var sideMenuButton: UIButton!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupSideMenu() {
        sideMenuButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { _ in
                
                if let vc = UIStoryboard.init(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuViewController {
                    
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.presentAnimate(self)
                }
            }.disposed(by: bag)
    }
}
