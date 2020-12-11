//
//  TitledButtonsStackView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 10.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TitledButtonsStackView: UIStackView {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var buttonsStackView = ButtonsStackView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private properties
    
    private func setupLayout() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(buttonsStackView)
        axis = .vertical
        spacing = 27
    }
}

// MARK: - ConfigurableView

extension TitledButtonsStackView: IConfigurableView {
    func configure(with model: TitledButtonsStackViewModel) {
        buttonsStackView.configure(with: model.buttonsStackViewModel)
        titleLabel.textColor = model.titleColor
        titleLabel.text = model.title
    }
}

struct TitledButtonsStackViewModel {
    let buttonsStackViewModel: ButtonsStackViewModel
    let titleColor: UIColor?
    let title: String?
}
