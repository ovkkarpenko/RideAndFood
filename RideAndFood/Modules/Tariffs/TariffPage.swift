//
//  TariffPage.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Kingfisher

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
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet var iconButtons: [UIButton]!
    @IBOutlet var advantageLabels: [UILabel]!
    @IBOutlet var advantageView: [UIView]!
    
    
    private var tariffModel: TariffModel!
    private var tariffId: Int!
    private var labelCornerRadius: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    convenience init(tariffModel: TariffModel) {
        self.init()
        self.tariffModel = tariffModel
        if let id = tariffModel.id {
            self.tariffId = id
        }
        
        setColoredIndicatorViewParameters()
        setTariffNameLabelsParameters()
        setAttributedTextToCarsLabel()
        setCarImage()
        setAboutTariffLabelParameters()
        setDescriptionTextViewParameters()
        setIconButtonsParameters()
        setAdvantageLabelsParameters()
        setAdvantageViewParameters()
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(TariffPage.TARIF_PAGE_NIB, owner: self, options: nil)
        tariffContentView.frame = bounds
        tariffContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(tariffContentView)
    }
    
    private func setColoredIndicatorViewParameters() {
        switch tariffId {
        case TariffId.premium.rawValue:
            self.coloredIndicatorView.backgroundColor = Colors.getColor(.tariffPurple)()
        case TariffId.business.rawValue:
            self.coloredIndicatorView.backgroundColor = Colors.getColor(.tariffGold)()
        default:
            self.coloredIndicatorView.backgroundColor = Colors.getColor(.tariffGreen)()
        }
    }
    
    private func setTariffNameLabelsParameters() {
        setLabelState(label: &standartLabel, color: Colors.getColor(.disableGray)(), text: TariffStrings.getString(.standart)())
        setLabelState(label: &premiumLabel, color: Colors.getColor(.disableGray)(), text: TariffStrings.getString(.premium)())
        setLabelState(label: &businessLabel, color: Colors.getColor(.disableGray)(), text: TariffStrings.getString(.business)())
        
        switch tariffId {
        case TariffId.premium.rawValue:
            setLabelState(label: &premiumLabel, color: Colors.getColor(.tariffPurple)())
        case TariffId.business.rawValue:
            setLabelState(label: &businessLabel, color: Colors.getColor(.tariffGold)())
        default:
            setLabelState(label: &standartLabel, color: Colors.getColor(.tariffGreen)())
        }
    }
    
    private func setLabelState(label: inout UILabel, color: UIColor, text: String? = nil) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = labelCornerRadius
        label.backgroundColor = color
        label.textColor = Colors.getColor(.buttonWhite)()
        
        if let text = text {
            label.text = text
        }
    }
    
    private func setAttributedTextToCarsLabel() {
        let cars = NSMutableAttributedString(string: TariffStrings.getString(.cars)(), attributes: [NSAttributedString.Key.foregroundColor : Colors.getColor(.textGray)()])
        if let carsString = tariffModel.cars {
            cars.append(NSAttributedString(string: carsString, attributes: [NSAttributedString.Key.foregroundColor : Colors.getColor(.textBlack)()]))
        }
        carsLabel.attributedText = cars
    }
    
    private func setCarImage() {
        if let imageUrlPart = tariffModel.icon {
            downloadImage(with: baseUrl + imageUrlPart) { [weak self] (iconImage) in
                guard let self = self else { return }
                guard let iconImage = iconImage else { return }
                self.carImageView.image = iconImage
            }
        }
    }
    
    private func setAboutTariffLabelParameters() {
        aboutTariffLabel.text = TariffStrings.getString(.aboutTariff)()
        aboutTariffLabel.textColor = Colors.getColor(.textBlack)()
    }
    
    private func setDescriptionTextViewParameters() {
        if let description = tariffModel.description {
            descriptionTextView.textColor = Colors.getColor(.textGray)()
            descriptionTextView.text = description
        }
    }
    
    private func setIconButtonsParameters() {
        let color: UIColor
        
        switch tariffId {
        case TariffId.premium.rawValue:
            color = Colors.getColor(.tariffPurple)()
        case TariffId.business.rawValue:
            color = Colors.getColor(.tariffGold)()
        default:
            color = Colors.getColor(.tariffGreen)()
        }
        
        for i in 0..<iconButtons.count {
            if let advantage = tariffModel.advantages {
                if let iconUrlPart = advantage[i]?.icon {
                    downloadImage(with: baseUrl + iconUrlPart) { [weak self] (iconImage) in
                        guard let self = self else { return }
                        guard let iconImage = iconImage else { return }
                        self.iconButtons[i].tintColor = color
                        self.iconButtons[i].setImage(iconImage, for: .normal)
                    }
                }
            }
        }
    }
    
    private func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void){
        guard let url = URL.init(string: urlString) else {
            return  imageCompletionHandler(nil)
        }
        
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(nil)
            }
        }
    }
    
    private func setAdvantageLabelsParameters() {
        for i in 0..<advantageLabels.count {
            if let advantage = tariffModel.advantages {
                if let advantageText = advantage[i]?.name {
                    advantageLabels[i].text = advantageText
                }
            }
        }
    }
    
    private func setAdvantageViewParameters() {
        for view in advantageView {
            view.layer.masksToBounds = false
            view.layer.cornerRadius = generalCornerRaduis
            view.layer.shadowColor = Colors.getColor(.shadowColor)().cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = generalCornerRaduis
            view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
