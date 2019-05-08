//
//  Airport.swift
//  MyAirportsApp
//
//  Created by Christiaan Paans on 19/10/2018.
//  Copyright © 2018 Christiaan Paans. All rights reserved.
//

import Foundation
import MapKit

class Airport {
    
    
    let name: String
    let icao: String
    let latitude: Double
    let longitude: Double
    let elevation: Double
    let iso_country: String
    let municipality: String
    let flag: String!
    
    init(name: String, icao: String, latitude: Double, longitude: Double, elevation: Double,
        iso_country: String, municipality: String) {
        self.name = name
        self.icao = icao
        self.latitude = latitude
        self.longitude = longitude
        self.elevation = elevation
        self.iso_country = iso_country
        self.municipality = municipality
        
        let base : UInt32 = 127397
        var s = ""
        for v in iso_country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        self.flag = String(s)
    }
}

class AirportMapInfo: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(airport: Airport, coordinate: CLLocationCoordinate2D) {
        self.title = airport.name
        self.locationName = airport.icao + ", " + airport.municipality + airport.flag
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
