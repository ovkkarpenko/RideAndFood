//
//  FromAnnotation.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 30.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import MapKit

class FromAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var image = UIImage(named: "Location")
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func setCoordinate(coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.3) {
            self.coordinate = coordinate
        }
    }
}
