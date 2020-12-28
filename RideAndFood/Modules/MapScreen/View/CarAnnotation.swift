//
//  CarAnnotation.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 28.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
