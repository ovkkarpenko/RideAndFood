//
//  PromotionDetailsViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class PromotionDetailsViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promotionIsOverLabel: UILabel!
    @IBOutlet weak var promotionIsOverHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let bag = DisposeBag()
    let viewModel = PromotionDetailsViewModel()
    static weak var delegate: PromotionDetailDelegate?
    
    var promotion: Promotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPromotion()
    }
    
    func setupUI() {
        actionButton.layer.cornerRadius = 15
        promotionIsOverLabel.text = PromotionsStrings.promotionIsOver.text()
        
        closeButton.rx
            .controlEvent(.touchUpInside)
            .subscribe { [weak self] _ in
                self?.dismiss(animated: true)
            }.disposed(by: bag)
    }
    
    func setupPromotion() {
        if let promotion = promotion {
            titleLabel.text = promotion.title
            actionButton.setTitle(promotion.type == PromotionType.food
                                    ? PromotionsStrings.buttonFoodTitle.text()
                                    : PromotionsStrings.buttonTaxiTitle.text(), for: .normal)
            
            actionButton.rx
                .tap
                .subscribe { [weak self] _ in
                    guard let self = self else { return }
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    PromotionDetailsViewController.delegate?.didPromotionSelected(type: promotion.type)
                }.disposed(by: bag)
            
            if promotion.media.count >= 2,
               let url = URL(string: baseUrl + promotion.media[0].url) {
                imageView.imageByUrl(from: url)
            }
            
            viewModel.item.subscribe(onNext: { [weak self] promotionDetails in
                guard let self = self else { return }
                let now = Date()
                
                if let date = promotionDetails.dateTo,
                   let isOver = promotionDetails.timeTo == nil
                    ? DateTimeHelper.shared.stringToDate(format: "yyyy-MM-dd", date: date)
                    : DateTimeHelper.shared.stringToDate(format: "yyyy-MM-dd HH:mm:ss", date: "\(date) \(promotionDetails.timeTo!)"),
                   now > isOver {
                    
                    DispatchQueue.main.async {
                        self.promotionIsOverHeightConstraint.constant = 40
                    }
                }
                
                DispatchQueue.main.async {
                    self.detailsLabel.text = promotionDetails.description
                }
            }).disposed(by: bag)
            
            viewModel.fetchItem(promotionId: promotion.id)
        }
    }
}
