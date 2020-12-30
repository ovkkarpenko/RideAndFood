//
//  MapViewDelegate.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    
    var mapViewCenterUpdatedCallback: ((CLPlacemark?) -> Void)?
    weak var mapViewController: MapViewController?
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        lookUpCurrentLocation(location: CLLocation(latitude: mapView.centerCoordinate.latitude,
                                                   longitude: mapView.centerCoordinate.longitude))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let state = mapViewController?.state else { return nil }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
            ?? MKAnnotationView()
        switch state {
        case .main:
            return annotationView
        case .selectFromAddress, .selectToAddress:
            if let annotation = annotation as? FromAnnotation {
                annotationView.image = annotation.image
            } else if let annotation = annotation as? ToAnnotation {
                annotationView.image = annotation.image
            } else {
                annotationView.image = nil
            }
        case .orderTaxi:
            if let annotation = annotation as? ToAnnotation {
                annotationView.image = annotation.image
            } else if let annotation = annotation as? FromAnnotation {
                annotationView.image = annotation.image
            } else {
                annotationView.image = nil
            }
        case .searchForTaxi, .waitForTaxi:
            if let annotation = annotation as? FromAnnotation {
                annotationView.image = annotation.image
            } else if let annotation = annotation as? CarAnnotation {
                annotationView.image = annotation.image
            } else {
                annotationView.image = nil
            }
        case .trip:
            if let annotation = annotation as? ToAnnotation {
                annotationView.image = annotation.image
            } else if let annotation = annotation as? CarAnnotation {
                annotationView.image = annotation.image
            } else {
                annotationView.image = nil
            }
        }
        annotationView.centerOffset = CGPoint(x: 0,
                                              y: -(annotationView.image?.size.height ?? 0) / 2)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = ColorHelper.primary.color()
        renderer.lineWidth = 4
        return renderer
    }
    
    private func lookUpCurrentLocation(location: CLLocation) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let mapViewCenterUpdatedCallback = self?.mapViewCenterUpdatedCallback else { return }
            if error == nil {
                let firstLocation = placemarks?[0]
                mapViewCenterUpdatedCallback(firstLocation)
            }
            else {
                mapViewCenterUpdatedCallback(nil)
            }
        }
    }
}

protocol MapViewCurrentAddressDelegate: class{
    func currentAddressChanged(newAddress: String?)
}
