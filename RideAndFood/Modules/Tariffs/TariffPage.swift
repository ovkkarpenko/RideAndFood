//
//  TariffPage.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TariffPage: UIView {
    static let TARIF_PAGE_NIB = "TariffPage"
    
    @IBOutlet var tariffContentView: UIView!
    @IBOutlet weak var coloredIndicatorView: UIView!
    @IBOutlet weak var standartLabel: UILabel!
    @IBOutlet weak var premiumLabel: UILabel!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var carsLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var aboutTariffLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var iconButtons: [UIButton]!
    @IBOutlet var advantageLabels: [UILabel]!
    @IBOutlet weak var orderButton: CustomButton!
    
    private var tariffModel: TariffModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(tariffModel: TariffModel) {
        self.init()
        self.tariffModel = tariffModel
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(TariffPage.TARIF_PAGE_NIB, owner: self, options: nil)
        tariffContentView.frame = bounds
        tariffContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(tariffContentView)
    }
}
