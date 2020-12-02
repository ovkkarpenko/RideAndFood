//
//  TaxiOrderView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 12.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import MapKit

class OrderView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var firstTextView: CustomTextView!
    @IBOutlet weak var secondTextView: CustomTextView!
    @IBOutlet weak var additionalViewContainer: UIView!
    @IBOutlet weak var button: CustomButton!
    @IBOutlet weak var tapIndicator: UIView!
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var addressLabelPanelView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var labelImage: UIButton!
    @IBOutlet weak var strokeImage: UIImageView!
    
    static let ORDER_VIEW = "OrderView"
    
    weak var delegate: OrderViewDelegate?
    
    private lazy var backViewBottomConstraintWithKeyboard = backView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    
    lazy var tableView: UITableView = {
        UITableView()
    }()
    
    private var savedAddresses: [AddressModel]?
//    var buttonAction: (()->(OrderViewType))?
    var orderViewType: OrderViewType?
    
    var currentAddress: String? {
        willSet {
            if firstTextView.isAddressListener {
                firstTextView.setText(newValue)
            }
            
            if secondTextView.isAddressListener {
                secondTextView.setText(newValue)
            }
            
            if !addressLabelPanelView.isHidden {
                addressLabel.text = newValue
            }
        }
    }
    
    private var isFirstTextFieldFilled = false {
        didSet {
            if secondTextView.isHidden {
                button.isEnabled = isFirstTextFieldFilled
            } else {
                button.isEnabled = isFirstTextFieldFilled && isSecondTextFieldFilled ? true : false
                strokeImage.isHidden = isFirstTextFieldFilled && isSecondTextFieldFilled ? false : true
            }
            
        }
    }
    private var isSecondTextFieldFilled = false {
        didSet {
            if firstTextView.isHidden {
                button.isEnabled = isSecondTextFieldFilled
            } else {
                button.isEnabled = isSecondTextFieldFilled && isFirstTextFieldFilled ? true : false
                strokeImage.isHidden = isSecondTextFieldFilled && isFirstTextFieldFilled ? false : true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(OrderView.ORDER_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        setKeyboardObserver()
        designGeneralViewElements()
    }
    
    deinit {
        removeKeyboardObservation()
    }
    
    //MARK: -- private methods
    private func customizeTapIndicator() {
        tapIndicator.layer.cornerRadius = 2
        tapIndicator.backgroundColor = Colors.getColor(.tapIndicatorGray)()
    }
    
    private func customizePanelView() {
        let cornerRadius: CGFloat = 20
        
        panelView.layer.masksToBounds = false
        panelView.layer.cornerRadius = cornerRadius
        panelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        panelView.backgroundColor = Colors.getColor(.buttonWhite)()
        panelView.layer.shadowColor = Colors.getColor(.shadowColor)().cgColor
        panelView.layer.shadowOpacity = 1
        panelView.layer.shadowOffset = CGSize(width: 0, height: -10)
        panelView.layer.shadowRadius = cornerRadius
        panelView.layer.shadowPath = UIBezierPath(rect: panelView.bounds).cgPath
        panelView.layer.shouldRasterize = true
        panelView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func customizeAdditionalViewContainer() {
        additionalViewContainer.layer.borderColor = Colors.getColor(.tableViewBorderGray)().cgColor
        additionalViewContainer.layer.borderWidth = 0.5
    }
    
    private func runAdditionalViewContainerTransitionAnimation(state: Bool) {
        UIView.transition(with: additionalViewContainer, duration: generalAnimationDuration, options: .curveLinear) { [weak self] in
            guard let self = self else { return }
            self.additionalViewContainer.isHidden = state
        }
    }
    
    private func setGestureRecognizers() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeGesture.direction = .down
        self.addGestureRecognizer(swipeGesture)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func getSavedAddresses() {
        let request = RequestModel<AddressModel>(path: addressPath, method: .get)
        let networker = Networker()
        
        networker.makeRequest(request: request) { [weak self] (results: [AddressModel]?, error: RequestErrorModel?) in
            guard let self = self else { return }
            
            if let results = results {
                self.savedAddresses = results
            }
            
            if let error = error {
                print(error.message)
            }
        }
    }
    
    private func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservation() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
    
        delegate?.shouldShowTranspatentView()
        tapIndicator.backgroundColor = Colors.getColor(.tapIndicatorOnDark)()
        backViewBottomConstraintWithKeyboard.constant = -keyboardSize.height
        backViewBottomConstraintWithKeyboard.isActive = true
        
        UIView.animate(withDuration: generalAnimationDuration) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        delegate?.shouldRemoveTranspatentView()
        backViewBottomConstraintWithKeyboard.isActive = false
        tapIndicator.backgroundColor = Colors.getColor(.tapIndicatorGray)()
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func buttonTapped() {
        if let orderViewType = orderViewType {
            delegate?.shouldRemoveTranspatentView()
            delegate?.buttonTapped(senderType: orderViewType, addressInfo: firstTextView.textField.text)
        }
    }
    
    // MARK: -- public methods
    
    func designGeneralViewElements() {
        button.customizeButton(type: .blueButton)
        button.isEnabled = false
        customizeTapIndicator()
        customizePanelView()
        setGestureRecognizers()
    }
    
    func addTableView() {
        additionalViewContainer.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: additionalViewContainer.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: additionalViewContainer.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: additionalViewContainer.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: additionalViewContainer.bottomAnchor).isActive = true
    }
    
    func show() {
        self.backView.layer.frame.origin.y = UIScreen.main.bounds.height
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut, .allowAnimatedContent]) { [weak self] in
            guard let self = self else { return }
            self.backView.layer.frame.origin.y = UIScreen.main.bounds.height -
                self.backView.frame.height
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveLinear]) { [weak self] in
            guard let self = self else { return }
            self.backView.layer.frame.origin.y += self.backView.frame.height
           
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}

// MARK: - Extensions
extension OrderView: CustomTextViewDelegate {
    func isTextFieldFilled(state: Bool, senderType: TextViewType) {
        switch senderType {
        case .currentAddress:
            isFirstTextFieldFilled = state
        case .destinationAddress:
            isSecondTextFieldFilled = state
        default:
            button.isEnabled = state
        }
    }
    
    func isDestinationAddressSelected(state: Bool) {
        if savedAddresses != nil, savedAddresses!.count != 0 {
            customizeAdditionalViewContainer()
            addTableView()
            runAdditionalViewContainerTransitionAnimation(state: !state)
        }
    }
    
    func mapButtonTapped(senderType: TextViewType) {
        delegate?.mapButtonTapped(senderType: senderType)
    }
    
    func locationButtonTapped(senderType: TextViewType) {
        delegate?.locationButtonTapped(senderType: senderType)
    }
}

extension OrderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedAddresses == nil ? 0 : savedAddresses!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AddressesTableView")
        cell.detailTextLabel?.textColor = Colors.getColor(.textGray)()
        cell.imageView?.tintColor = Colors.getColor(.disableGray)()
        cell.imageView?.image = UIImage(named: "Clock")
        
        if let addresses = savedAddresses {
            if let name = addresses[indexPath.row].name, let address = addresses[indexPath.row].address {
                cell.textLabel?.text = name
                cell.detailTextLabel?.text = address
            }

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let addresses = savedAddresses {
            if let address = addresses[indexPath.row].address {
                secondTextView.textField.text = address
                runAdditionalViewContainerTransitionAnimation(state: true)
            }
        }
    }
}

extension OrderView: MapViewCurrentAddressDelegate {
    func currentAddressChanged(newAddress: String?) {
        currentAddress = newAddress
    }
}
