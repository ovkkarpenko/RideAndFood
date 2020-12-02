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

    private var selectedTariff: TariffModel?
    static weak var delegate: TariffDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TariffStrings.getString(.storyboardTitle)()
        setOrderButtonParameters()
        TariffPageViewController.tariffPageDelegate = self
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func order(_ sender: Any) {
        if let selectedTariff = selectedTariff {
            TariffViewController.delegate?.tariffOrderButtonTapped(tariff: selectedTariff)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setOrderButtonParameters() {
        orderButton.customizeButton(type: .blueButton)
        orderButton.setTitle(TariffStrings.getString(.orderTaxiButton)(), for: .normal)
    }
}

extension TariffViewController: TariffPageDelegate {
    func selectedTariff(tariff: TariffModel) {
        selectedTariff = tariff
    }
}
