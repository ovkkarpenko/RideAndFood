//
//  CarAnnotation.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 28.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var image = UIImage(named: "Car")
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func setCoordinate(coordinate: CLLocationCoordinate2D, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 2) {
                self.coordinate = coordinate
            }
        } else {
            self.coordinate = coordinate
        }
    }
}
