//
//  TariffViewController.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TariffViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TariffStrings.getString(.storyboardTitle)()
    }
    
    @IBAction func backToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
