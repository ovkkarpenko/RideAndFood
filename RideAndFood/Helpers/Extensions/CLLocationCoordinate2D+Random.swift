//
//  CLLocationCoordinate2D+Random.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 30.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D {
    var randomAround: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude
                                * Double.random(in: 0.9999...1.0001),
                               longitude: self.longitude
                                * Double.random(in: 0.9999...1.0001))
    }
}
