//
//  OrdersHistoryViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources

class OrdersHistoryViewModel {
    
    var doneOrders: [OrderHistoryModel] = []
    
    var doneOrdersPublishSubject = PublishSubject<[SectionModel<String, OrderHistoryModel>]>()
    var cenceledOrdersPublishSubject = PublishSubject<[SectionModel<String, OrderHistoryModel>]>()
    
    func fetchData(_ completion: (([OrderHistoryModel]) -> ())? = nil) {
        
        ServerApi.shared.getOrdersHistory(status: "done") { [weak self] orders, _ in
            
            if let orders = orders {
                self?.doneOrders = orders
                self?.doneOrdersPublishSubject.onNext([SectionModel(model: "", items: orders)])
                
                DispatchQueue.main.async {
                    completion?(orders)
                }
            }
        }
        
        ServerApi.shared.getOrdersHistory(status: "canceled") { [weak self] orders, _ in
            
            if let orders = orders {
                self?.cenceledOrdersPublishSubject.onNext([SectionModel(model: "", items: orders)])
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, OrderHistoryModel>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, OrderHistoryModel>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OrdersHistoryCollectionViewCell
                
                let date = NSDate(timeIntervalSince1970: Double(item.createdAt))
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMMM, HH:mm"
                
                cell.createdAtLabel.text = formatter.string(from: date as Date)
                cell.priceLabel.text = "\(item.price) \(OrdersHistoryStrings.rub.text())"
                
                if item.status == "canceled" {
                    cell.initCanceledView(cancellationReason: "Без указания причины")
                }
                
                if item.type == "taxi" {
                    cell.typeLabel.text = OrdersHistoryStrings.taxi.text()
                    cell.serviceTypeLabel.text = OrdersHistoryStrings.taxiService.text()
                    cell.imageView.image = UIImage(named: "car")
                    cell.imageViewBottomConstraint.constant = -20
                } else if item.type == "food" {
                    cell.typeLabel.text = OrdersHistoryStrings.food.text()
                    cell.serviceTypeLabel.text = OrdersHistoryStrings.foodService.text()
                    cell.imageView.image = UIImage(named: "packet")
                }
                
                return cell
            }
        )
    }
}
