//
//  TariffViewController.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 07.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TariffViewController: UIViewController {
    @IBOutlet weak var orderButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TariffStrings.getString(.storyboardTitle)()
        setOrderButtonParameters()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func order(_ sender: Any) {
        // some order logic
    }
    
    private func setOrderButtonParameters() {
        orderButton.customizeButton(type: .blueButton)
        orderButton.setTitle(TariffStrings.getString(.orderTaxiButton)(), for: .normal)
    }
    
}
