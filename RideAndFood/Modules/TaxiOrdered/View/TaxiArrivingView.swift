//
//  TaxiArrivingView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiArrivingView: UIView {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular12.font()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carNumberView: UIView = {
        let view = CarNumberView(number: "К 009 РВ", regionNumber: "779")
        let carNumberView = view.subviews.first?.subviews.first ?? view
        carNumberView.backgroundColor = ColorHelper.controlBackground.color()
        carNumberView.translatesAutoresizingMaskIntoConstraints = false
        return carNumberView
    }()
    
    private lazy var callButton = TaxiCircleButtonView()
    
    private lazy var onMyWayButton = TaxiCircleButtonView()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [callButton, onMyWayButton])
        stackView.spacing = 90
        onMyWayButton.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Private properties
    
    private var timer: Timer?
    
    private var numberOfSeconds = 150 {
        didSet {
            updateSeconds()
        }
    }
    
    private lazy var titles: [TitleModel] = [
        .init(title: "\(TaxiStrings.paidWaiting.text()) ",
              seconds: 3,
              description: TaxiStrings.paidWaitingDescription.text(),
              secondsColor: ColorHelper.error.color()),
        .init(title: "\(TaxiStrings.waiting.text()) ",
              seconds: 3,
              description: TaxiStrings.waitingDesctiption.text()),
        .init(title: TaxiStrings.waitingForYou.text(),
              titleColor: ColorHelper.notification.color(),
              actionBlock: { [weak self] in
                self?.onMyWayButton.isHidden = false
        }),
        .init(title: TaxiStrings.almostThere.text()),
        .init(title: "\(TaxiStrings.onTheWay.text()) ", seconds: 3)
    ]
    
    private lazy var currentTitle: TitleModel? = titles.popLast()
    
    private var timeString: NSAttributedString {
        let minutes = Int(numberOfSeconds / 60)
        let seconds = numberOfSeconds - minutes * 60
        let string = String(format: "\(minutes):%02d", seconds)
        return NSAttributedString(string: string,
                                  attributes: [.foregroundColor : currentTitle?.secondsColor as Any,
                                               .font: FontHelper.semibold26.font() as Any])
    }
    
    private lazy var titleAttributedString = NSMutableAttributedString()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Deinitializer
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        updateTitle()
        carNameLabel.text = "Белый Opel Astra"
        callButton.configure(with: .init(image: UIImage(named: "Phone"),
                                         title: TaxiStrings.call.text(), buttonTappedBlock: {
                                            
                                         }))
        onMyWayButton.configure(with: .init(image: UIImage(named: "onMyWay"),
                                            title: TaxiStrings.onMyWay.text(),
                                            buttonTappedBlock: { [weak self] in
                                                self?.onMyWayButtonTapped()
                                            }))
        layoutIfNeeded()
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(carNameLabel)
        addSubview(carNumberView)
        addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            carNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            carNameLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                              constant: 12),
            carNumberView.centerXAnchor.constraint(equalTo: centerXAnchor),
            carNumberView.topAnchor.constraint(equalTo: carNameLabel.bottomAnchor,
                                               constant: 6),
            buttonsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: carNumberView.bottomAnchor,
                                                  constant: 25),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func runTimer(seconds: Int) -> Void {
        timer?.invalidate()
        numberOfSeconds = seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.numberOfSeconds -= 1
            if self?.numberOfSeconds == 0 {
                timer.invalidate()
                self?.updateTitle()
            }
        })
    }
    
    private func updateTitle() {
        guard let title = titles.popLast() else { return }
        currentTitle = title
        titleAttributedString = NSMutableAttributedString(string: title.title,
                                                          attributes: [
                                                            .font: FontHelper.semibold26.font() as Any,
                                                            .foregroundColor : title.titleColor as Any
                                                          ])
        descriptionLabel.text = title.description
        title.actionBlock?()
        if let seconds = title.seconds {
            titleAttributedString.append(timeString)
            titleLabel.attributedText = titleAttributedString
            runTimer(seconds: seconds)
        } else {
            titleLabel.attributedText = titleAttributedString
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.updateTitle()
            }
        }
    }
    
    private func updateSeconds() {
        guard let titleString = currentTitle?.title else { return }
        titleAttributedString.replaceCharacters(in: .init(location: titleString.count,
                                                          length: titleAttributedString.length - titleString.count),
                                                with: timeString)
        titleLabel.attributedText = titleAttributedString
    }
    
    @objc private func onMyWayButtonTapped() {
        onMyWayButton.isHidden = true
    }
    
    struct TitleModel {
        let title: String
        let seconds: Int?
        let description: String?
        let titleColor: UIColor?
        let secondsColor: UIColor?
        let actionBlock: (() -> Void)?
        
        init(title: String,
             seconds: Int? = nil,
             description: String? = nil,
             titleColor: UIColor? = ColorHelper.primaryText.color(),
             secondsColor: UIColor? = ColorHelper.notification.color(),
             actionBlock: (() -> Void)? = nil) {
            self.title = title
            self.seconds = seconds
            self.description = description
            self.titleColor = titleColor
            self.secondsColor = secondsColor
            self.actionBlock = actionBlock
        }
    }
}
