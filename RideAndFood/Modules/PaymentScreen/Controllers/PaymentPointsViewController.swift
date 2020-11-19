//
//  PaymentPointsViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

protocol PointsAlertDelegate {
    func newOrder()
    func details()
}

class PaymentPointsViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        view.backgroundColor = .black
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pointsView: UIView = {
        if UserConfig.shared.isShownPointsAlert {
            let view = PaymentPointsView()
            view.delegate = self
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        } else {
            let view = PaymentCongratulationsView()
            view.delegate = self
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }()
    
    private lazy var pointsDetailsView: UIView = {
        let view = PaymentPointsDetailsView()
        view.closeCallback = { [weak self] in
            self?.togglePointsDetailsView(true, dismiss: true)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pointsViewHeightConstraint = pointsView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var pointsDetailsViewHeightConstraint = pointsDetailsView.heightAnchor.constraint(equalToConstant: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        togglePointsView(false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == backgroundView {
            togglePointsView(true, dismiss: true)
        }
    }
    
    func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(pointsView)
        view.addSubview(pointsDetailsView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            pointsViewHeightConstraint,
            pointsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pointsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pointsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pointsDetailsViewHeightConstraint,
            pointsDetailsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pointsDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pointsDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func togglePointsView(_ hide: Bool, dismiss: Bool = false) {
        var animateOption: UIView.AnimationOptions = .curveEaseIn
        
        if hide {
            pointsViewHeightConstraint.constant = 0
        } else {
            animateOption = .curveEaseOut
            pointsViewHeightConstraint.constant = UserConfig.shared.isShownPointsAlert ? 180 : 230
            UserConfig.shared.isShownPointsAlert = true
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: animateOption, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                if dismiss {
                    self?.dismiss(animated: true)
                }
            })
    }
    
    func togglePointsDetailsView(_ hide: Bool, dismiss: Bool = false) {
        var animateOption: UIView.AnimationOptions = .curveEaseIn
        
        if hide {
            pointsDetailsViewHeightConstraint.constant = 0
        } else {
            animateOption = .curveEaseOut
            pointsDetailsViewHeightConstraint.constant = 620
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: ConstantsHelper.baseAnimationDuration.value(),
            options: animateOption, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                if dismiss {
                    self?.dismiss(animated: true)
                }
            })
    }
    
    @objc private func viewSwipe() {
        togglePointsView(true, dismiss: true)
    }
}

extension PaymentPointsViewController: PointsAlertDelegate {
    
    func newOrder() {
        togglePointsView(true, dismiss: true)
    }
    
    func details() {
        togglePointsView(true)
        togglePointsDetailsView(false)
    }
}
