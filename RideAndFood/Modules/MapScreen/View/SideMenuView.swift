//
//  SideMenuView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SideMenuView: UIView {
    
    var viewController: UIViewController?
    var hideSideMenuCallback: (() -> ())?
    
    // MARK: - UI
    
    private lazy var closeButton: UIButton = {
        let button = RoundButton(type: .system)
        button.tintColor = .black
        button.alpha = 0.3
        button.bgImage = UIImage(systemName: "xmark.circle.fill")
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = SideMenuStrings.title.text()
        label.font = .systemFont(ofSize: 26)
        label.textColor = ColorHelper.primaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.text = SideMenuStrings.about("1").text()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(sideMenuSwipe))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(TableItem.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self,
                      let vc = self.viewController else { return }
                
                item.completion?(vc)
                if let segue = item.segue {
                    vc.performSegue(withIdentifier: segue, sender: nil)
                }
            }).disposed(by: bag)
        
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private let bag = DisposeBag()
    private let viewModel = SideMenuViewModel()
    
    private let cellIdentifier = "SideMenuCell"
    private let paddingVertical: CGFloat = 40
    private let paddingHorizontal: CGFloat = 15
    
    // MARK: - Lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(menuTableView)
        addSubview(aboutLabel)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: paddingVertical),
            closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingHorizontal),
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingHorizontal),
            menuTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            menuTableView.leftAnchor.constraint(equalTo: leftAnchor),
            menuTableView.rightAnchor.constraint(equalTo: rightAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: aboutLabel.topAnchor, constant: -180),
            aboutLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingVertical),
            aboutLabel.leftAnchor.constraint(equalTo: menuTableView.leftAnchor, constant: paddingHorizontal)
        ])
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
    }
    
    @objc private func closeButtonPressed() {
        hideSideMenuCallback?()
    }
    
    @objc private func sideMenuSwipe() {
        hideSideMenuCallback?()
    }
}

extension SideMenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
