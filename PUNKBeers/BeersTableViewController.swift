//
//  BeersTableViewController.swift
//  PUNKBeers
//
//  Created by André Couto on 20/11/17.
//  Copyright © 2017 André Couto. All rights reserved.
//

import UIKit
import Kingfisher

class BeersTableViewController: UITableViewController {

    var beers: [Beer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let vc = segue.destination as! ViewController
         vc.beer = beers[tableView.indexPathForSelectedRow!.row]
    }
    
    func loadBeers() {
        REST.loadBeers { (beers: [Beer]?) in
            if let beers = beers {
                self.beers = beers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBeers()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeerTableViewCell
   
        let beer = beers[indexPath.row]
     
        cell.lbName.text = beer.name
        cell.lbContent.text =  "Teor alcoólico: \(beer.alcoholContent)"
        let resource = ImageResource(downloadURL: URL(string: beer.image)!, cacheKey: beer.image)
        cell.ivBeer.kf.setImage(with: resource)
        
        return cell
    }
    
}
