//
//  OrdersHistoryViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class OrdersHistoryViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "OrdersHistoryScreenBackground")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = OrdersHistoryStrings.emptyTitle.text()
        label.font = .systemFont(ofSize: 26)
        label.isHidden = true
        label.alpha = 0
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var completedCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width-padding*2, height: 125)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.alpha = 0
        collectionView.isHidden = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OrdersHistoryCollectionViewCell.self, forCellWithReuseIdentifier: OrdersHistoryCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var cenceledCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width-padding*2, height: 155)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.alpha = 0
        collectionView.isHidden = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OrdersHistoryCollectionViewCell.self, forCellWithReuseIdentifier: OrdersHistoryCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            OrdersHistoryStrings.completedButton.text(),
            OrdersHistoryStrings.cenceledButton.text()
        ])
        
        segmentedControl.alpha = 0
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeStatusType(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = OrdersHistoryStrings.title.text()
        
        setupUI()
        setupCollectionView()
    }
    
    private let bag = DisposeBag()
    private let viewModel = OrdersHistoryViewModel()
    
    private let padding: CGFloat = 20
    
    private lazy var completedCollectionViewTrailingAnchorConstraint = completedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
    private lazy var completedCollectionViewLeadingAnchorConstraint = completedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
    private lazy var cenceledCollectionViewLeadingAnchorConstraint = cenceledCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width)
    
    func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
        view.addSubview(completedCollectionView)
        view.addSubview(cenceledCollectionView)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: padding),
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: padding+100),
            
            completedCollectionViewLeadingAnchorConstraint,
            completedCollectionViewTrailingAnchorConstraint,
            completedCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: padding),
            completedCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            
            cenceledCollectionViewLeadingAnchorConstraint,
            cenceledCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            cenceledCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: padding),
            cenceledCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        ])
    }
    
    func setupCollectionView() {
        completedCollectionView.rx
            .modelSelected(OrderHistoryModel.self)
            .subscribe(onNext: { item in
                
            }).disposed(by: bag)
        
        viewModel.doneOrdersPublishSubject
            .bind(to: completedCollectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: OrdersHistoryCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
        
        viewModel.cenceledOrdersPublishSubject
            .bind(to: cenceledCollectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: OrdersHistoryCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
        
        viewModel.fetchData { [weak self] orders in
            
            DispatchQueue.main.async {
                if orders.count == 0 {
                    self?.backgroundImage.isHidden = false
                    self?.titleLabel.isHidden = false
                    
                    UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value(), animations: {
                        self?.backgroundImage.alpha = 1
                        self?.titleLabel.alpha = 1
                    })
                } else {
                    self?.segmentedControl.isHidden = false
                    self?.completedCollectionView.isHidden = false
                    self?.cenceledCollectionView.isHidden = false
                    
                    UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value(), animations: {
                        self?.segmentedControl.alpha = 1
                        self?.completedCollectionView.alpha = 1
                        self?.cenceledCollectionView.alpha = 1
                    })
                }
            }
        }
    }
    
    private func toggle(hide: Bool) {
        if hide {
            completedCollectionViewLeadingAnchorConstraint.constant = -view.frame.width*2
            completedCollectionViewTrailingAnchorConstraint.constant = -view.frame.width
            cenceledCollectionViewLeadingAnchorConstraint.constant = padding
        } else {
            completedCollectionViewLeadingAnchorConstraint.constant = padding
            completedCollectionViewTrailingAnchorConstraint.constant = -padding
            cenceledCollectionViewLeadingAnchorConstraint.constant = view.frame.width
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: hide ? .curveEaseIn : .curveEaseOut,
            animations: { [weak self] in
                self?.view.layoutIfNeeded()
            })
    }
    
    @objc private func changeStatusType(_ sender: UISegmentedControl) {
        toggle(hide: sender.selectedSegmentIndex == 1)
    }
}

extension OrdersHistoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.cellForItem(at: indexPath)?.
    }
}
