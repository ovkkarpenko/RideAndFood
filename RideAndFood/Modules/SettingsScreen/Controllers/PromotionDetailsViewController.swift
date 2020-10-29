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
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let bag = DisposeBag()
    let viewModel = PromotionsViewModel()
    
    var promotion: Promotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        if let promotion = promotion {
            titleLabel.text = promotion.title
            
            if promotion.media.count >= 2,
               let url = URL(string: ServerConfig.shared.baseUrl + promotion.media[0].url) {
                imageView.imageByUrl(from: url)
            }
        }
    }
}
