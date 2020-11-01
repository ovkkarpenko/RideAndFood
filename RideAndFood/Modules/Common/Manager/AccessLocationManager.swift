//
//  AccessLocationManager.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation
import CoreLocation

class AccessLocationManager: NSObject {
    
    // MARK: - Private properties
    
    private var locationManager: CLLocationManager?
    private var locationDetectedCollback: ((CLLocationCoordinate2D?, Error?) -> Void)?
    
    // MARK: - Public properties
    
    var location: CLLocation? {
        locationManager?.location
    }
    
    // MARK: - Public properties
    
    func requestLocationAccess(completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager?.pausesLocationUpdatesAutomatically = true
            locationDetectedCollback = completion
        } else {
            completion(nil, LocationError.locationServicesNotEnabled)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension AccessLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("DENIED LOCATION")
        @unknown default:
            print("SOMETHING WENT WRONG")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationDetectedCollback = locationDetectedCollback else { return }
        if let coordinate = locations.last?.coordinate {
            locationDetectedCollback(coordinate, nil)
            self.locationDetectedCollback = nil
        } else {
            locationDetectedCollback(nil, LocationError.locationServicesNotEnabled)
        }
    }
}
