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
    
    private lazy var personButton: UIButton = {
        let button = RoundButton(type: .system)
        button.bgImage = UIImage(named: "Person")
//        button.addTarget(self, action: #selector(personButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.getColor(.tapIndicatorGray)()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        return view
    }()
    
    private lazy var taxiOrderView: TaxiOrderView = {
        setKeyboardObserver()
        return TaxiOrderView(input: 1)
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
        }
    }
    
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
    private lazy var taxiOrderViewBottomConstraint = taxiOrderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.safeAreaInsets.bottom)
    private lazy var taxiOrderViewTopConstraintWithoutKeyboard = taxiOrderView.topAnchor.constraint(equalTo: myLocationButton.bottomAnchor, constant: 10)
    private lazy var taxiOrderViewTopConstraintKeyboard = taxiOrderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
    
    private let padding: CGFloat = 25
    private let sideMenuPadding: CGFloat = 42
    private lazy var sideMenuOffset: CGFloat = -500
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    deinit {
        // MARK: - TODO: Should move it to taxiOrderView dissapearance. Cos keyboard is
        removeKeyboardObservation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (BaseUserDefaultsManager().isAuthorized && UserConfig.shared.userId != 0) {
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
            myLocationButton.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -padding),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            menuButton.topAnchor.constraint(equalTo: statusBarBlurView.bottomAnchor, constant: padding),
            sideMenuView.topAnchor.constraint(equalTo: view.topAnchor),
            sideMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuHiddenConstraint,
            sideMenuLeftConstraint,
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundHiddenConstraint,
            backgroundLeftConstraint
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
        view.addSubview(transparentView)
        view.addSubview(taxiOrderView)
        transparentView.isHidden = true
        cardView.isHidden = true
        
        NSLayoutConstraint.activate([transparentView.topAnchor.constraint(equalTo: view.topAnchor),
                                     transparentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     transparentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     transparentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        taxiOrderView.translatesAutoresizingMaskIntoConstraints = false
        (NSLayoutConstraint.activate([taxiOrderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      taxiOrderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      taxiOrderViewBottomConstraint, taxiOrderViewTopConstraintWithoutKeyboard]))
        
    }
    
    private func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservation() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func myLocationButtonPressed() {
        guard let coordinate = accessManager.location?.coordinate else { return }
        centerViewOn(coordinate: coordinate)
    }
    
    @objc private func menuButtonPressed() {
        toggleSideMenu(hide: false)
    }
    
    @objc private func taxiButtonPressed() {
        initializeTaxiOrderView()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        transparentView.isHidden = false
        taxiOrderView.setTapIndicatorColor(color: Colors.getColor(.tapIndicatorOnDark)())
        taxiOrderViewBottomConstraint.constant = -keyboardSize.height
        taxiOrderViewTopConstraintWithoutKeyboard.isActive = false
        taxiOrderViewTopConstraintKeyboard.isActive = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        taxiOrderViewBottomConstraint.constant = view.safeAreaInsets.bottom
        transparentView.isHidden = true
        taxiOrderViewTopConstraintWithoutKeyboard.isActive = true
        taxiOrderViewTopConstraintKeyboard.isActive = false
        taxiOrderView.setTapIndicatorColor(color: Colors.getColor(.tapIndicatorGray)())
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
