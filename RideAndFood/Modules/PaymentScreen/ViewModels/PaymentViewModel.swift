//
//  PaymentViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import Foundation

class PaymentViewModel {
    
    var bindCardCallback: (() -> ())?
    var loadedCardsCallback: (() -> ())?
    
    var items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func fetchItems() {
        ServerApi.shared.getPaymentCards(completion: { [weak self] cards, _ in
            guard let self = self else { return }
            
            if let cards = cards, cards.count != 0 {
                self.loadedCardsCallback?()
                self.items.onNext(self.getMenu(cards))
            } else {
                self.items.onNext(self.getMenu())
            }
        })
    }
    
    func dataSource(cellIdentifier: String) -> RxTableViewSectionedReloadDataSource<SectionModel<String, TableItem>> {
        
        return RxTableViewSectionedReloadDataSource<SectionModel<String, TableItem>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier)!
                TableHelper.shared.setupCell(cell, item: item)
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
    }
    
    private func getMenu() -> [SectionModel<String, TableItem>] {
        return [
            SectionModel(model: "", items: [
                TableItem(
                    title: PaymentStrings.cash.text(),
                    cellTypes: [
                        .radio(UserConfig.shared.paymentType == .cash),
                        .icon(UIImage(named: "cash", in: Bundle.init(path: "Images/Icons"), with: .none))
                    ],
                    completion: { [weak self] _ in
                        guard let self = self else { return }
                        UserConfig.shared.paymentType = .cash
                        self.items.onNext(self.getMenu())
                    }),
                TableItem(
                    title: PaymentStrings.card.text(),
                    cellTypes: [
                        .icon(UIImage(named: "card", in: Bundle.init(path: "Images/Icons"), with: .none)),
                        .default()],
                    completion: { [weak self] _ in
                        self?.bindCardCallback?()
                    }),
                TableItem(
                    title: PaymentStrings.applePay.text(),
                    cellTypes: [
                        .radio(UserConfig.shared.paymentType == .applePay),
                        .icon(UIImage(named: "applePay", in: Bundle.init(path: "Images/Icons"), with: .none))
                    ],
                    completion: { [weak self] _ in
                        guard let self = self else { return }
                        UserConfig.shared.paymentType = .applePay
                        self.items.onNext(self.getMenu())
                    }),
            ]),
            
            SectionModel(model: " ", items: [
                TableItem(
                    title: PaymentStrings.points.text(),
                    cellTypes: [.icon(UIImage(named: "points", in: Bundle.init(path: "Images/Icons"), with: .none)), .default()],
                    completion: { rootVC in
                        let vc = PaymentPointsViewController()
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        rootVC.present(vc, animated: true)
                    })
            ])
        ]
    }
    
    private func getMenu(_ cards: [PaymentCard]) -> [SectionModel<String, TableItem>] {
        var cardsSection = SectionModel(model: "", items: [
            TableItem(
                title: PaymentStrings.cash.text(),
                cellTypes: [
                    .radio(UserConfig.shared.paymentType == .cash),
                    .icon(UIImage(named: "cash", in: Bundle.init(path: "Images/Icons"), with: .none))
                ],
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UserConfig.shared.paymentType = .cash
                    self.items.onNext(self.getMenu(cards))
                })
        ])
        
        cards.forEach { card in
            cardsSection.items.append(TableItem(
                                        title: PaymentStrings.cardCellTitle(card.number).text(),
                                        cellTypes: [
                                            .radio(
                                                UserConfig.shared.paymentType == .card &&
                                                    UserConfig.shared.paymentCardId == card.id
                                            ),
                                            .icon(UIImage(named: "visa", in: Bundle.init(path: "Images/Icons"), with: .none))
                                        ],
                                        completion: { _ in
                                            UserConfig.shared.paymentType = .card
                                            UserConfig.shared.paymentCardId = card.id ?? 0
                                            self.items.onNext(self.getMenu(cards))
                                        }))
        }
        
        cardsSection.items.append(TableItem(
                                    title: PaymentStrings.applePay.text(),
                                    cellTypes: [
                                        .radio(UserConfig.shared.paymentType == .applePay),
                                        .icon(UIImage(named: "applePay", in: Bundle.init(path: "Images/Icons"), with: .none))
                                    ],
                                    completion: { [weak self] _ in
                                        guard let self = self else { return }
                                        UserConfig.shared.paymentType = .applePay
                                        self.items.onNext(self.getMenu(cards))
                                    }))
        
        return [
            cardsSection,
            SectionModel(model: " ", items: [
                TableItem(
                    title: PaymentStrings.addCard.text(),
                    cellTypes: [.default()],
                    completion: { [weak self] _ in
                        self?.bindCardCallback?()
                    }),
                
                TableItem(
                    title: PaymentStrings.points.text(),
                    cellTypes: [
                        .icon(UIImage(named: "points", in: Bundle.init(path: "Images/Icons"), with: .none)),
                        .default()
                    ],
                    completion: { rootVC in
                        let vc = PaymentPointsViewController()
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        rootVC.present(vc, animated: true)
                    })
            ])
        ]
    }
}
