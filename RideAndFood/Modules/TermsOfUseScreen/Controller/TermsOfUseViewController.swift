//
//  TermsOfUseViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TermsOfUseViewController: UIViewController {
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.background.color()
    }
    
    private func setupNavigationController() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .cancel,
                                                  target: self,
                                                  action: #selector(dismissSelf))
        navigationItem.title = TermsOfUseStrings.title.text()
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
