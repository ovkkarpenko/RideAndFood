//
//  ProductDetailModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ProductDetailModel {
    
    let name: String
    let composition: NSAttributedString
    var producer: NSAttributedString
    let country: NSAttributedString
    let imageUrl: URL?
    let price: String
    let closeBlock: () -> Void
    
    init(model: ProductDetail, closeBlock: @escaping () -> Void) {
        name = "\(model.name) \(model.weight) \(model.unit)"
        
        let compositionTitle = ProductDetailsStrings.composition.text()
        let compositionString = NSMutableAttributedString(string: "\(compositionTitle): \(model.composition)",
                                                          attributes: [.font: FontHelper.regular15.font() as Any])
        compositionString.addAttribute(.foregroundColor,
                                       value: ColorHelper.secondaryText.color() as Any,
                                       range: .init(location: compositionTitle.count + 2,
                                                    length: model.composition.count))
        composition = compositionString
        let producerTitle = ProductDetailsStrings.producer.text()
        let producerString = NSMutableAttributedString(string: "\(producerTitle): \(model.producing)",
                                                       attributes: [.font: FontHelper.regular15.font() as Any])
        producerString.addAttribute(.foregroundColor,
                                       value: ColorHelper.secondaryText.color() as Any,
                                       range: .init(location: producerTitle.count + 2,
                                                    length: model.producing.count))
        self.producer = producerString
        
        let countryTitle = ProductDetailsStrings.country.text()
        let countryString = NSMutableAttributedString(string: "\(countryTitle): \(model.country)",
                                                      attributes: [.font: FontHelper.regular15.font() as Any])
        countryString.addAttribute(.foregroundColor,
                                       value: ColorHelper.secondaryText.color() as Any,
                                       range: .init(location: countryTitle.count + 2,
                                                    length: model.country.count))
        self.country = countryString
        
        self.imageUrl = URL(string: "\(baseUrl)\(model.image)")
        self.price = "\(model.price)"
        self.closeBlock = closeBlock
    }
}
