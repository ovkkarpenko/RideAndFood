//
//  SelectAddressMapViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 11.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class SelectAddressMapViewController: UIViewController {
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Location"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        view.showsCompass = false
        view.delegate = mapViewDelegate
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var selectAddressView: SelectAddressView = {
        let view = SelectAddressView()
        view.selectAddressCallback = { [weak self] address in
            self?.addressCallback?(address)
            self?.navigationController?.popViewController(animated: true)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (BaseUserDefaultsManager().isAuthorized) {
            accessManager.requestLocationAccess { [weak self] (coordinate, error) in
                guard let coordinate = coordinate, error == nil else {
                    print(error ?? "location is not available")
                    return
                }
                self?.centerViewOn(coordinate: coordinate)
            }
        }
    }
    
    private let regionInMeters: Double = 100
    private let accessManager = AccessLocationManager()
    
    var addressCallback: ((String) -> ())?
    
    private lazy var mapViewDelegate: MapViewDelegate = {
        let delegate = MapViewDelegate()
        delegate.mapViewCenterUpdatedCallback = { [weak self] placemark in
            self?.cuurentPlacemark = placemark
        }
        return delegate
    }()
    
    private var cuurentPlacemark: CLPlacemark? {
        didSet {
            selectAddressView.address = cuurentPlacemark?.name
        }
    }
    
    func centerViewOn(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: coordinate,
                                             latitudinalMeters: regionInMeters,
                                             longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func setupLayout() {
        view.addSubview(mapView)
        view.addSubview(selectAddressView)
        view.addSubview(locationImageView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            selectAddressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectAddressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectAddressView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            selectAddressView.heightAnchor.constraint(equalToConstant: 150),
            
            locationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
