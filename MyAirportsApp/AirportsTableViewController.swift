//
//  AirportsTableViewController.swift
//  2018-sqlite
//
//  Created by Diederich Kroeske on 18/09/2018.
//  Copyright © 2018 Diederich Kroeske. All rights reserved.
//

import UIKit

class AirportsTableViewController: UITableViewController {
    
    var airports : [Airport] = []
    var airport_countries : [String] = []
    var sections2d : [Int:[Airport]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.airports = AirportFactory.getInstance().getAllAirports(force: true)
            self.airport_countries = AirportFactory.getInstance().airportCountries
            self.tableView.reloadData()
            /*
            for countryindex in 0...self.airport_countries.count-1 {
                self.sections2d[countryindex] = []
                for airport in self.airports {
                    if airport.iso_country == self.airport_countries[countryindex] {
                        self.sections2d[countryindex]!.append(airport)
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
             */
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    func getAirportsByIcaoCode(icao: String) {
//        const query = " SELECT * FROM airports WHERE icao=\"(icao)\""
//    }

    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections2d[section]![0].iso_country
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return airport_countries.count
        return 1
        //return sections2d.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return airports.count
        //return dictionary[airport_countries[section]]!.count
        //return sections2d[section]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportCell", for: indexPath) as! AirportTableViewCell
        let section = indexPath.section
        let row = indexPath.row
        
        if let port : Airport = airports[row] {
            cell.airportNameLabel?.text = port.name
            cell.airportIcaoLabel?.text = port.flag
        }
        
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let detailVC = segue.destination as! MapViewController
            detailVC.airport = self.airports[selectedRow]
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
