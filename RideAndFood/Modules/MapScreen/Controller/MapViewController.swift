//
//  MapViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import MapKit

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
    
    private lazy var taxiActiveOrderView: TaxiActiveOrderView = {
        // здесь нужно проверять, есть ли активный заказ еды и тогда отступ фрейма делать от еды. То же самое нужно делать для вьюшки еды. И тап индикатор тоже в зависимости от того последняя ли это вьюшка ставится.
        let taxiActiveOrderView = TaxiActiveOrderView()
        taxiActiveOrderView.frame = CGRect(x: cardView.frame.origin.x, y: cardView.frame.origin.y, width: cardView.frame.width, height: cardView.frame.height + 10)
        return taxiActiveOrderView
    }()
    
    private var activeOrders: Int? {
        didSet {
            if let cardViewIndex = view.subviews.firstIndex(of: cardView) {
                myLocationButton.isHidden = true
                locationImageView.isHidden = true
                
                taxiActiveOrderView.isLastView = true
                view.insertSubview(taxiActiveOrderView, at: cardViewIndex - 1)
                taxiActiveOrderView.show()
                
                let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showActiveOrderView))
                swipeGesture.direction = .up
                cardView.addGestureRecognizer(swipeGesture)
            }
        }
    }
    
    @objc private func showActiveOrderView() {
        taxiActiveOrderView.showMore()
    }
    
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

    private let padding: CGFloat = 25
    private let sideMenuPadding: CGFloat = 42
    private lazy var sideMenuOffset: CGFloat = -500
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        TariffViewController.delegate = self
        PromotionDetailsViewController.delegate = self
        AddAddresViewController.delegate = self
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
            myLocationButton.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -padding*3.5),
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
            personButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
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
    
    @objc private func myLocationButtonPressed() {
        guard let coordinate = accessManager.location?.coordinate else { return }
        centerViewOn(coordinate: coordinate)
    }
    
    @objc private func menuButtonPressed() {
        toggleSideMenu(hide: false)
    }
    
    @objc private func taxiButtonPressed() {
        activeOrders = 1
//        initializeBackButton()
//        initializeTaxiOrderView()
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
            break // describe behaviour of address input view's button
        case .currentAddressDetail:
            // add addressInfo to the post model
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
        if !self.view.subviews.contains(addressInputView) {
            taxiButtonPressed()
        }
        
        addressInputView.secondTextView.setText(address?.address)
    }
}
