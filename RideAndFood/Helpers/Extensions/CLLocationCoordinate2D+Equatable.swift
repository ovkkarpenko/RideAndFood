//
//  CLLocationCoordinate2D+Equatable.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 30.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
