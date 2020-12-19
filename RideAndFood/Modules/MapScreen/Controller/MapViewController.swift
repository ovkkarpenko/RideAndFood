//
//  MapViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        view.showsCompass = false
        view.delegate = mapViewDelegate
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Location"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var locationIVCenterYConstraint = locationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    
    private lazy var statusBarBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cardView: MapCardView = {
        let view = MapCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.taxiAction = taxiButtonPressed
        view.foodAction = foodButtonPressed
        return view
    }()
    
    private lazy var sideMenuView: SideMenuView = {
        let view = SideMenuView()
        view.viewController = self
        view.hideSideMenuCallback = { [weak self] in
            self?.toggleSideMenu(hide: true)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var myLocationButton: UIButton = {
        let button = RoundButton(type: .system)
        button.bgImage = UIImage(named: "MyLocation")
        button.addTarget(self, action: #selector(myLocationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = RoundButton(type: .system)
        button.bgImage = UIImage(named: "MenuButton")
        button.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = RoundButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.tintColor = Colors.getColor(.textBlack)()
        return button
    }()
    
    private lazy var personButton: UIButton = {
        let button = RoundButton(type: .system)
        button.bgImage = UIImage(named: "Person")
        button.addTarget(self, action: #selector(personButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = RoundButton(type: .system)
        button.bgImage = UIImage(named: "CartButton")
        button.addTarget(self, action: #selector(showCart), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.getColor(.tapIndicatorGray)()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        return view
    }()
    
    private lazy var addressInputView: OrderViewDirector = {
        let view = OrderViewDirector(type: .addressInput)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.currentAddress = cuurentPlacemark?.name
        view.delegate = self
        addressDelegate = view
        
        return view
    }()
    
    private lazy var notificationView: NotificationView = {
        let view = NotificationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cartView: CartView = {
        let view = CartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var additionalCardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var selectTariffView: SelectTariffView = {
        let view = SelectTariffView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var taxiConfirmationView = TaxiConfirmationView()
    
    private lazy var dimmerView: DimmerView = {
        let view = DimmerView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideCart)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var taxiArrivingView = TaxiArrivingView()
    private lazy var taxiTripInfoView = TaxiTripInfoView()
    
    // MARK: - Private properties
    
    private let accessManager = AccessLocationManager()
    private let regionInMeters: Double = 100
    private lazy var mapViewDelegate: MapViewDelegate = {
        let delegate = MapViewDelegate()
        delegate.mapViewCenterUpdatedCollback = { [weak self] placemark in
            self?.cuurentPlacemark = placemark
        }
        return delegate
    }()
    
    private var cuurentPlacemark: CLPlacemark? {
        didSet {
            cardView.address = cuurentPlacemark?.name
            addressDelegate?.currentAddressChanged(newAddress: cuurentPlacemark?.name)
        }
    }
    
    private lazy var taxiOrderModelHandler: OrderTaxiModelHandler = OrderTaxiModelHandler()
    
    private lazy var taxiActiveOrderView: TaxiActiveOrderView = {
        let view = TaxiActiveOrderView()
        view.frame = CGRect(x: cardView.frame.origin.x, y: cardView.frame.origin.y, width: cardView.frame.width, height: cardView.frame.height + activeOrderViewPadding)
        
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissActiveOrderViews))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showActiveOrderView))
        swipeGesture.direction = .up
        view.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showExpandedTaxiActiveOrderView))
        view.addGestureRecognizer(tapGesture)
        
        cardView.isTaxiButtonEnable = false
        
        return view
    }()
    
    private lazy var foodActiveOrderView: FoodActiveOrderView = {
        let view = FoodActiveOrderView()
        if isTaxiActiveOrder {
            view.frame = CGRect(x: cardView.frame.origin.x, y: cardView.frame.origin.y, width: cardView.frame.width, height: cardView.frame.height + 2 * activeOrderViewPadding)
        } else {
            view.frame = CGRect(x: cardView.frame.origin.x, y: cardView.frame.origin.y, width: cardView.frame.width, height: cardView.frame.height + activeOrderViewPadding)
        }
        
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissActiveOrderViews))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showActiveOrderView))
        swipeGesture.direction = .up
        view.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showExpandedFoodActiveOrderView))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    private lazy var activeOrderCounterView: UIButton = {
        let view = UIButton(type: .system)
        view.setBackgroundImage(UIImage(named: CustomImagesNames.gradient.rawValue), for: .normal)
        view.isUserInteractionEnabled = false
        view.setTitleColor(Colors.getColor(.buttonWhite)(), for: .normal)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var isActiveOrder: Bool? {
        didSet {
            if let cardViewIndex = view.subviews.firstIndex(of: cardView), taxiOrderModelHandler.getTaxiOrder() != nil {
                myLocationButton.isHidden = true
                locationImageView.isHidden = true
                
                if isFoodActiveOrder && isTaxiActiveOrder {
                    view.insertSubview(taxiActiveOrderView, at: cardViewIndex - 1)
                    view.insertSubview(foodActiveOrderView, at: cardViewIndex - 2)
                    foodActiveOrderView.isLastView = true
                    activeOrderCounterView.setTitle(getActiveOrderCounterString(orderCount: 2), for: .normal)
                    taxiActiveOrderView.show()
                    foodActiveOrderView.show()
                } else if isTaxiActiveOrder {
                    taxiActiveOrderView.isLastView = true
                    view.insertSubview(taxiActiveOrderView, at: cardViewIndex - 1)
                    activeOrderCounterView.setTitle(getActiveOrderCounterString(orderCount: 1), for: .normal)
                    taxiActiveOrderView.show()
                    cardView.isTaxiButtonEnable = false
                } else if isFoodActiveOrder {
                    foodActiveOrderView.isLastView = true
                    view.insertSubview(foodActiveOrderView, at: cardViewIndex - 1)
                    activeOrderCounterView.setTitle(getActiveOrderCounterString(orderCount: 1), for: .normal)
                    foodActiveOrderView.show()
                }
                
                activeOrderCounterView.isHidden = false
                
                let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showActiveOrderView))
                swipeGesture.direction = .up
                cardView.addGestureRecognizer(swipeGesture)
            }
        }
    }
    
    private var isFoodActiveOrder = false
    private var isTaxiActiveOrder = false
    
    private weak var addressDelegate: MapViewCurrentAddressDelegate?
    
    private lazy var sideMenuLeftConstraint = sideMenuView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                                                 constant: sideMenuOffset)
    private lazy var sideMenuShownConstraint = sideMenuView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                                                   constant: -sideMenuPadding)
    private lazy var sideMenuHiddenConstraint = sideMenuView.rightAnchor.constraint(equalTo: view.leftAnchor,
                                                                                    constant: sideMenuOffset)
    
    private lazy var backgroundLeftConstraint = backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                                                 constant: sideMenuOffset)
    private lazy var backgroundShownConstraint = backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor)
    private lazy var backgroundHiddenConstraint = backgroundView.rightAnchor.constraint(equalTo: view.leftAnchor,
                                                                                        constant: sideMenuOffset)
    private lazy var additionalCardViewBottomConstraint = additionalCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                                     constant: additionalCardViewOffset)
    private let padding: CGFloat = 25
    private let sideMenuPadding: CGFloat = 42
    private let activeOrderViewPadding: CGFloat = 10
    private lazy var sideMenuOffset: CGFloat = -500
    private lazy var additionalCardViewOffset: CGFloat = 1000
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        TariffViewController.delegate = self
        PromotionDetailsViewController.delegate = self
        AddAddresViewController.delegate = self
        CartModel.shared.observers.append(self)
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserConfig.shared.settings.language != sideMenuView.currentLanguage {
            sideMenuView.updateTexts()
            cardView.updateTexts()
        }
        
        if (UserConfig.shared.userId > 0) {
            accessManager.requestLocationAccess { [weak self] (coordinate, error) in
                guard let coordinate = coordinate, error == nil else {
                    print(error ?? "location is not available")
                    return
                }
                self?.centerViewOn(coordinate: coordinate)
            }
            
            ServerApi.shared.getSettings { settings, _ in
                if let settings = settings {
                    UserConfig.shared.settings = settings
                }
            }
            checkIfTaxiActiveOrderExists()
            checkIfFoodActiveOrderExists()
            checkCartHasGoods()
        } else {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        locationIVCenterYConstraint.constant = -locationImageView.bounds.height / 2
        cardView.bottomPadding = view.safeAreaInsets.bottom
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.addSubview(mapView)
        view.addSubview(locationImageView)
        view.addSubview(statusBarBlurView)
        view.addSubview(cardView)
        view.addSubview(myLocationButton)
        view.addSubview(menuButton)
        view.addSubview(personButton)
        view.addSubview(cartButton)
        view.addSubview(activeOrderCounterView)
        view.addSubview(backgroundView)
        view.addSubview(sideMenuView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            locationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationIVCenterYConstraint,
            statusBarBlurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarBlurView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarBlurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarBlurView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            myLocationButton.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -padding*5),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            menuButton.topAnchor.constraint(equalTo: statusBarBlurView.bottomAnchor, constant: padding),
            sideMenuView.topAnchor.constraint(equalTo: view.topAnchor),
            sideMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuHiddenConstraint,
            sideMenuLeftConstraint,
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundHiddenConstraint,
            backgroundLeftConstraint,
            personButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            personButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            cartButton.topAnchor.constraint(equalTo: personButton.bottomAnchor, constant: padding),
            cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            activeOrderCounterView.heightAnchor.constraint(equalToConstant: 40),
            activeOrderCounterView.widthAnchor.constraint(equalToConstant: 165),
            activeOrderCounterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activeOrderCounterView.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor)
        ])
    }
    
    private func centerViewOn(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: coordinate,
                                             latitudinalMeters: regionInMeters,
                                             longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    private func lookUpCurrentLocation(location: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void ) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
                completionHandler(nil)
            }
        }
    }
    
    private func toggleSideMenu(hide: Bool) {
        var animationOptions: UIView.AnimationOptions
        if (hide) {
            sideMenuLeftConstraint.constant = self.sideMenuOffset
            sideMenuShownConstraint.isActive = false
            sideMenuHiddenConstraint.isActive = true
            animationOptions = .curveEaseIn
        } else {
            sideMenuHiddenConstraint.isActive = false
            sideMenuShownConstraint.isActive = true
            sideMenuLeftConstraint.constant = 0
            animationOptions = .curveEaseOut
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: animationOptions) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        if (!hide) {
            self.backgroundHiddenConstraint.isActive = false
            self.backgroundShownConstraint.isActive = true
            self.backgroundLeftConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: animationOptions, animations: { [weak self] in
            self?.backgroundView.alpha = hide ? 0 : 0.3
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            if (hide) {
                self.backgroundLeftConstraint.constant = self.sideMenuOffset
                self.backgroundShownConstraint.isActive = false
                self.backgroundHiddenConstraint.isActive = true
            }
        })
    }
    
    private func initializeTaxiOrderView() {
        self.view.addSubview(addressInputView)
        cardView.isHidden = true
        
        (NSLayoutConstraint.activate([addressInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      addressInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor), addressInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.safeAreaInsets.bottom), addressInputView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)]))
        addressInputView.show()
    }
    
    private func initializeSelectTariffView(_ firstTextFieldText: String?, _ secondTextFieldText: String?) {
        backButton.removeFromSuperview()
        personButton.isHidden = true
        selectTariffView.delegate = self
        selectTariffView.firstTextField.textField.text = firstTextFieldText
        selectTariffView.secondTextField.textField.text = secondTextFieldText
        
        view.addSubview(selectTariffView)
        
        NSLayoutConstraint.activate([selectTariffView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      selectTariffView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      selectTariffView.topAnchor.constraint(equalTo: view.topAnchor),
                                      selectTariffView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        view.layoutIfNeeded()
        selectTariffView.show()
    }
    
    @objc private func dismissKeyboard() {
        if self.view.endEditing(false) {
            self.view.endEditing(true)
        }
    }
    
    private func initializeBackButton() {
        menuButton.isHidden = true
        view.addSubview(backButton)
        
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        backButton.topAnchor.constraint(equalTo: statusBarBlurView.bottomAnchor, constant: padding).isActive = true
    }
    
    private func checkCartHasGoods() {
        guard CartModel.getCart().rows.count > 0 else {
            notificationView.removeFromSuperview()
            cartButton.alpha = 0
            return
        }
        guard notificationView.superview == nil else { return }
        notificationView.configure(with: .init(messageText: FoodStrings.haveGoodsInCart.text(),
                                               iconImage: UIImage(named: "CartLight"),
                                               closeBlock: { [weak self] in
                                                UIView.animate(withDuration: 0.3, animations: {
                                                    self?.notificationView.alpha = 0
                                                }) { [weak self] _ in
                                                    self?.notificationView.removeFromSuperview()
                                                }
                                               },
                                               tappedBlock: { [weak self] in
                                                self?.showCart()
                                               }))
        view.insertSubview(notificationView, belowSubview: cardView)
        NSLayoutConstraint.activate([
            notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            notificationView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -2 * padding)
        ])
        UIView.animate(withDuration: 0.3) {
            self.notificationView.alpha = 1
            self.cartButton.alpha = 1
        }
    }
    
    private func checkIfTaxiActiveOrderExists() {
        DispatchQueue.main.asyncAfter(deadline: .now() + generalDelay) { [weak self] in
            guard let self = self else { return }
            if self.taxiOrderModelHandler.getTaxiOrder() != nil {
                self.isTaxiActiveOrder = true
                self.isFoodActiveOrder = true
                self.isActiveOrder = true
            }
        }
    }
    
    private func checkIfFoodActiveOrderExists() {
        
    }
    
    private func showAdditionalCardView() {
        view.addSubview(dimmerView)
        view.addSubview(additionalCardView)
        
        NSLayoutConstraint.activate([
            dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmerView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            additionalCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            additionalCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            additionalCardViewBottomConstraint
        ])
        view.layoutIfNeeded()
        additionalCardViewBottomConstraint.constant = 0
        dimmerView.show()
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideAdditionalCardView() {
        additionalCardViewBottomConstraint.constant = additionalCardViewOffset
        self.dimmerView.hide()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dimmerView.removeFromSuperview()
            self.additionalCardView.removeFromSuperview()
        }
    }
    
    private func showTaxiConfirmationView() {
        guard let order = taxiOrderModelHandler.getTaxiOrder() else { return }
        
        taxiConfirmationView.configure(with: .init(addressFrom: order.from,
                                                   addressTo: order.to) {
                                                    
                                                   } secondaryButtonPressedBlock: { [weak self] in
                                                    self?.hideAdditionalCardView()
                                                   })
        additionalCardView.configure(with: .init(contentView: taxiConfirmationView,
                                                 style: .light,
                                                 paddingTop: 0,
                                                 paddingBottom: 0,
                                                 paddingX: 0,
                                                 didSwipeDownCallback: { [weak self] in
                                                    self?.hideAdditionalCardView()
                                                 }))
        showAdditionalCardView()
    }
    
    private func showTaxiArrivingView() {
        additionalCardView.configure(with: .init(contentView: taxiArrivingView,
                                                 paddingBottom: padding,
                                                 didSwipeDownCallback: { [weak self] in
                                                    self?.hideAdditionalCardView()
                                                 }))
        showAdditionalCardView()
    }
    
    private func showTaxiTripInfoView() {
        guard let order = taxiOrderModelHandler.getTaxiOrder() else { return }
        taxiTripInfoView.configure(with: .init(addressFrom: order.from,
                                               addressTo: order.to,
                                               driverName: "Анатолий (id: 23-87)",
                                               carName: "Белый Opel Astra",
                                               tripTimeInMinutes: 14,
                                               primaryButtonPressedBlock: {
                                                
                                               },
                                               secondaryButtonPressedBlock: {
                                                
                                               }))
        additionalCardView.configure(with: .init(contentView: taxiTripInfoView,
                                                 paddingBottom: 0,
                                                 paddingX: 0,
                                                 didSwipeDownCallback: { [weak self] in
                                                    self?.hideAdditionalCardView()
                                                 }))
        showAdditionalCardView()
    }
    
    @objc private func showCart() {
        cartView.removeFromSuperview()
        let cart = CartModel.getCart()
        cartView = CartView()
        cartView.configure(with: .init(cartRows: cart.rows,
                                       sum: cart.sum,
                                       deliveryTimeInMinutes: Int.random(in: 5...120),
                                       deliveryCost: 0,
                                       shopName: cart.shopName,
                                       backButtonTappedBlock: { [weak self] in
                                        self?.hideCart()
                                       }))
        additionalCardView.configure(with: .init(contentView: cartView,
                                                 style: .light,
                                                 paddingTop: 0,
                                                 paddingBottom: padding,
                                                 paddingX: 0,
                                                 didSwipeDownCallback: { [weak self] in
                                                    self?.hideCart()
                                                 }))
        showAdditionalCardView()
    }
    
    @objc private func hideCart() {
        hideAdditionalCardView()
    }
    
    @objc private func myLocationButtonPressed() {
        guard let coordinate = accessManager.location?.coordinate else { return }
        centerViewOn(coordinate: coordinate)
    }
    
    @objc private func menuButtonPressed() {
        toggleSideMenu(hide: false)
    }
    
    @objc private func taxiButtonPressed() {
        initializeBackButton()
        initializeTaxiOrderView()
    }
    
    @objc private func foodButtonPressed() {
        let foodView = FoodView()
        foodView.currentUserAddress = cardView.address
        foodView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(foodView)

        NSLayoutConstraint.activate([
            foodView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodView.topAnchor.constraint(equalTo: view.topAnchor),
            foodView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func personButtonPressed() {
        let vc = UINavigationController(rootViewController: ProfileViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func backButtonPressed() {
        if let currentView = view.subviews.last as? OrderViewDirector {
            if let type = currentView.orderViewType, type == .addressInput {
                backButton.removeFromSuperview()
                menuButton.isHidden = false
                cardView.isHidden = false
            } else {
                if let indexOfCurrentView = view.subviews.firstIndex(of: currentView) {
                    view.subviews[indexOfCurrentView - 1].isHidden = false
                    addressDelegate = view.subviews[indexOfCurrentView - 1] as? MapViewCurrentAddressDelegate
                }
            }
            
            currentView.dismiss()
        }
    }
    
    @objc private func confirmAddressButtonPressed() {
        if let currentView = view.subviews.last as? OrderViewDirector {
            currentView.dismiss()
            initializeSelectTariffView(currentView.firstTextView.textField.text, currentView.secondTextView.textField.text)
        }
    }
    
    @objc private func showActiveOrderView() {
        if isTaxiActiveOrder && isFoodActiveOrder {
            foodActiveOrderView.showMore(originY: UIScreen.main.bounds.height - taxiActiveOrderView.frame.height - activeOrderViewPadding + padding)
            taxiActiveOrderView.showMore()
        } else if isTaxiActiveOrder {
            taxiActiveOrderView.showMore()
        } else if isFoodActiveOrder {
            foodActiveOrderView.showMore()
        }
    }
    
    @objc private func dismissActiveOrderViews() {
        if isTaxiActiveOrder && isFoodActiveOrder {
            foodActiveOrderView.dismiss()
            taxiActiveOrderView.dismiss()
            foodActiveOrderView.dismiss(padding: padding)
        } else if isTaxiActiveOrder {
            taxiActiveOrderView.dismiss()
        } else if isFoodActiveOrder {
            foodActiveOrderView.dismiss()
        }
    }
    
    @objc private func managedObjectContextObjectsDidChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, inserts.count > 0 {
            checkIfTaxiActiveOrderExists()
            
            // Нужно реализовать БД еды и реализовать эту функцию
            checkIfFoodActiveOrderExists()
        }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updates.count > 0 {
            checkIfTaxiActiveOrderExists()
            
            // Нужно реализовать БД еды и реализовать эту функцию
            checkIfFoodActiveOrderExists()
        }
        
        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, deletes.count > 0 {
            // Здесь нужно будет удалить вьюшки активных заказов и вернуть состояние стартового экрана.
        }
    }
    
    @objc private func showExpandedFoodActiveOrderView() {
        let expandedFoodActiveOrderView = ExpandedActiveOrderView(type: .foodActiveOrderView)
        expandedFoodActiveOrderView.delegate = self
        
        view.addSubview(expandedFoodActiveOrderView)
        
        dismissActiveOrderViews()
        expandedFoodActiveOrderView.show(after: generalDelay)
    }
    
    @objc private func showExpandedTaxiActiveOrderView() {
        let expandedTaxiActiveOrderView = ExpandedActiveOrderView(type: .taxiActiveOrderView)
        expandedTaxiActiveOrderView.delegate = self
        
        view.addSubview(expandedTaxiActiveOrderView)
        
        dismissActiveOrderViews()
        expandedTaxiActiveOrderView.show(after: generalDelay)
    }
}

// MARK: - Extensions
extension MapViewController: OrderViewDelegate {
    func mapButtonTapped(senderType: TextViewType) {
        if senderType == .destinationAddress {
            let destinationAddressFromMapView = OrderViewDirector(type: .destinationAddressFromMap)
            destinationAddressFromMapView.currentAddress = cuurentPlacemark?.name
            addNewOrderView(newSubview: destinationAddressFromMapView)
        }
    }
    
    func locationButtonTapped(senderType: TextViewType) {
        switch senderType {
        case .currentAddress:
            let currentAddressDetailView = OrderViewDirector(type: .currentAddressDetail)
            currentAddressDetailView.currentAddress = cuurentPlacemark?.name
            addNewOrderView(newSubview: currentAddressDetailView)
        case .destinationAddress:
            let destinationAddressDetailView = OrderViewDirector(type: .destinationAddressDetail)
            destinationAddressDetailView.currentAddress = cuurentPlacemark?.name
            addNewOrderView(newSubview: destinationAddressDetailView)
            
        default:
            break
        }
    }
    
    func buttonTapped(senderType: OrderViewType, addressInfo: String?) {
        switch senderType {
        case .addressInput:
            confirmAddressButtonPressed()
            backButtonPressed()
        case .currentAddressDetail:
            backButtonPressed()
        case .destinationAddressDetail:
            // add addressInfo to the post model
            backButtonPressed()
        case .orderPrice:
            break // describe behaviour of order price view's button
        case .confirmationCode:
            break // describe behaviour of confirmation code view's button
        case .destinationAddressFromMap:
            addressInputView.secondTextView.setText(addressInfo)
            backButtonPressed()
        }
    }
    
    private func addNewOrderView(newSubview: OrderViewDirector) {
        dismissKeyboard()
        
        if let currentView = view.subviews.last as? OrderViewDirector {
            currentView.isHidden = true
        }
        
        self.view.addSubview(newSubview)
        newSubview.translatesAutoresizingMaskIntoConstraints = false
        addressDelegate = newSubview
        newSubview.delegate = self
        
        (NSLayoutConstraint.activate([newSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      newSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor), newSubview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.safeAreaInsets.bottom), newSubview.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)]))
        
        newSubview.show()
    }
    
    func shouldShowTranspatentView() {
        if !self.view.contains(transparentView) {
            view.insertSubview(transparentView, at: view.subviews.count - 1)
            
            NSLayoutConstraint.activate([transparentView.topAnchor.constraint(equalTo: view.topAnchor),
                                         transparentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                         transparentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                         transparentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        }
    }
    
    func shouldRemoveTranspatentView() {
        transparentView.removeFromSuperview()
    }
}

extension MapViewController: SelectTariffViewDelegate {
    
    func backSubButtonPressed() {
        menuButton.isHidden = false
        cardView.isHidden = false
        personButton.isHidden = false
    }
    
    func promoCodeButtonPressed(_ dismissCallback: ((String?) -> ())?) {
        let view = TariffPromoCodeView()
        view.promoCodeActivetedView.ifPromoCodeIsValidCallback = dismissCallback
        addNewView(view)
    }
    
    func pointsButtonPressed(_ dismissCallback: ((Int?) -> ())?) {
        let view = TariffPointsView()
        view.dismissCallback = dismissCallback
        addNewView(view)
    }
    
    func orderButtonPressed() {
        let view = LookingForDriverView()
        addNewView(view)
    }
    
    func addNewView(_ view: CustromViewProtocol) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     view.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        view.layoutIfNeeded()
        view.show()
    }
}

extension MapViewController: TariffDelegate {
    func tariffOrderButtonTapped(tariff: TariffModel) {
        toggleSideMenu(hide: true)
        taxiButtonPressed()
    }
}

extension MapViewController: PromotionDetailDelegate {
    func didPromotionSelected(type: PromotionType) {
        toggleSideMenu(hide: true)
        
        switch type {
        case .food:
            foodButtonPressed()
        case .taxi:
            taxiButtonPressed()
        }
    }
}

extension MapViewController: AddAddressViewControllerDelegate {
    func didSelectedAddressAsDestination(address: Address?) {
        if cardView.isTaxiButtonEnable! {
            if !self.view.subviews.contains(addressInputView) {
                taxiButtonPressed()
            }
            
            addressInputView.secondTextView.setText(address?.address)
        } else {
            // show alert taxi already ordered
        }
    }
}

// MARK: - ICartChangesObserver

extension MapViewController: ICartChangesObserver {
    func cartUpdated() {
        DispatchQueue.main.async {
            self.checkCartHasGoods()
        }
    }
}

extension MapViewController: ExpandedActiveOrderViewDelegate {
    func cancelButtonTapped() {
        print("Cancel button tapped")
    }
    
    func reportProblemButtonTapped() {
        if let controller = UIStoryboard.init(name: "SupportService", bundle: nil)
            .instantiateViewController(withIdentifier: "SupportID") as? UINavigationController {
            
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            present(controller, animated: true)
        }
    }
    
    func addDeliveryButtonTapped() {
        foodButtonPressed()
    }
}
