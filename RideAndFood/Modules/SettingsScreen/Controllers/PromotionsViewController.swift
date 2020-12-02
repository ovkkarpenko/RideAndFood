//
//  PromotionsViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import UIKit

private let cellIdentifier = "PromotionCell"

class PromotionsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let bag = DisposeBag()
    let viewModel = PromotionsViewModel()
    
    var promotionType: PromotionType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PromotionDetailsViewController,
           let promotion = sender as? Promotion {
            vc.promotion = promotion
        }
    }
    
    func setupCollection() {
        viewModel.items
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        collectionView.rx.modelSelected(Promotion.self)
            .subscribe(onNext: { [weak self] item in
                self?.performSegue(withIdentifier: "PromotionDetailsSegue", sender: item)
            }).disposed(by: bag)
        
        if let promotionType = promotionType {
            viewModel.fetchItems(promotionType)
        }
    }
}
