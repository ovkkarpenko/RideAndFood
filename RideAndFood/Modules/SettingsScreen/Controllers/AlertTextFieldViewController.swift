//
//  AlertTextFieldViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class AlertTextFieldViewController: UIViewController {
    
    @IBOutlet weak var button: AlertButton!
    @IBOutlet weak var textField: AlertTextField!
    @IBOutlet weak var alertView: UIView!
    
    let bag = DisposeBag()
    
    var buttonTitle: String?
    var placeholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlert()
    }
    
    func setupAlert() {
        button.setTitle(buttonTitle ?? "", for: .normal)
        textField.placeholder = placeholder ?? ""
        alertView.layer.cornerRadius = 20
        
        textField.rx
            .controlEvent(.editingChanged)
            .withLatestFrom(textField.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.button.buttonState = !text.isEmpty
            }).disposed(by: bag)
    }
    
    static func show(_ vc: UIViewController, buttonTitle: String, placeholder: String) {
        if let alert = UIStoryboard(name: "Settings", bundle: nil)
            .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
            
            alert.buttonTitle = buttonTitle
            alert.placeholder = placeholder
            alert.modalPresentationStyle = .popover
            vc.present(alert, animated: true)
        }
    }
}
