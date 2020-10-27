//
//  ViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 19.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func buttonPressed() {
        let storyboard = UIStoryboard(name: "SupportService", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SupportID")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
