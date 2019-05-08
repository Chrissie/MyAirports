//
//  MapViewController.swift
//  MyAirportsApp
//
//  Created by Christiaan Paans on 20/10/2018.
//  Copyright © 2018 Christiaan Paans. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    var airport: Airport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.title = airport.municipality + airport.flag
        initializeMapInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initializeMapInformation() {
        let initialLocation = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        //let annotation = AirportMapInfo(airport: airport, coordinate: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude))
        let thisCoordinate = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
        DispatchQueue.main.async {
            for info in AirportFactory.getInstance().airportsMapInfo {
                if thisCoordinate.distance(from: CLLocation(latitude: info.coordinate.latitude, longitude: info.coordinate.longitude)) < 600000 {
                    if self.mapView.annotations.count < 30 {
                          self.mapView.addAnnotation(info)
                    }
                }
            }
        }
        
  
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? AirportMapInfo else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    /*U
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
   */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
