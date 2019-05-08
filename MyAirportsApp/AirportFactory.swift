//
//  AirportFactory.swift
//  2018-sqlite
//
//  Created by Diederich Kroeske on 18/09/2018.
//  Copyright © 2018 Diederich Kroeske. All rights reserved.
//

import Foundation
import MapKit

// volgens: https://cocoacasts.com/what-is-a-singleton-and-how-to create-one-in-swift

class AirportFactory {
    
    var airports: [Airport] = []
    var airportsMapInfo: [AirportMapInfo] = []
    var airportCountries: [String] = []
    
    private static var sharedAirportFactory: AirportFactory = {
        let factory = AirportFactory()
        return factory;
    }()
    
    class func getInstance() -> AirportFactory {
        return sharedAirportFactory
    }
    
    var db : OpaquePointer? = nil
    
    //
    init() {
        
        //
        let bundlePathUrl = Bundle.main.url(forResource: "airports", withExtension: "sqlite")
        let docPathUrl = getDocumentsDirectory().appendingPathComponent("airports.sqlite")
        
        // Copy db file als deze niet bestaat
        if !FileManager.default.fileExists(atPath: docPathUrl.path) {
            try! FileManager.default.copyItem(at: bundlePathUrl!, to: docPathUrl)
        }
        
        // Open vanaf de document directory de db
        if sqlite3_open(docPathUrl.path, &db) != SQLITE_OK {
            print("Error opening database!!")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0];
    }
    
    // Get all airports from db
    func getAllAirports(force: Bool) -> [Airport] {
        
        if( !force ) {
            return self.airports
        } else {
        
            let query = "SELECT * FROM airports order by name"
            var statement: OpaquePointer?
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error query: \(errmsg)")
            }
            
            // Construct airports
            self.airports.removeAll();
            while sqlite3_step(statement) == SQLITE_ROW {
                let icoa = String(cString: sqlite3_column_text(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let longitude = sqlite3_column_double(statement, 2)
                let latitude = sqlite3_column_double(statement, 3)
                let elevation = sqlite3_column_double(statement, 4)
                let iso_country = String(cString: sqlite3_column_text(statement, 5))
                let municipality = String(cString: sqlite3_column_text(statement, 6))
                self.airports.append(Airport(name: name, icao: icoa, latitude: latitude, longitude: longitude, elevation: elevation, iso_country: iso_country, municipality: municipality));
            }
            
            for airport in self.airports {
                airportsMapInfo.append(AirportMapInfo(airport: airport,
                coordinate: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)))
            }

            
            let country_query = "SELECT DISTINCT(iso_country) FROM airports"
            self.airportCountries.removeAll()
            var country_statement: OpaquePointer?
            if sqlite3_prepare_v2(db, country_query, -1, &country_statement, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error query: \(errmsg)")
            }
            while sqlite3_step(country_statement) == SQLITE_ROW {
                self.airportCountries.append(String(cString: sqlite3_column_text(country_statement, 0)))
            }
            
            return self.airports;
        }
    }
}
