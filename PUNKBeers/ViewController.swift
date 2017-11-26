//
//  ViewController.swift
//  PUNKBeers
//
//  Created by André Couto on 20/11/17.
//  Copyright © 2017 André Couto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTagLine: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbAlcoholContent: UILabel!
    @IBOutlet weak var lbBitternessScale: UILabel!
    @IBOutlet weak var ivBeer: UIImageView!
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Beer!!!";
        
        if (beer != nil) {
            lbName.text = beer.name
            lbTagLine.text = beer.tagLine
            lbDescription.text = beer.description
            lbAlcoholContent.text =  "Teor alcoólico: \(beer.alcoholContent)"
           
            if let ibu = beer.bitternessScale {
                lbBitternessScale.text = "Escala de amargor: \(ibu)"
            } else {
                lbBitternessScale.isHidden = true
            }
        }
        
        REST.downloadImage(url:
        beer.image) { (image: UIImage?) in
            
            DispatchQueue.main.async {
                self.ivBeer.image = image
            }
    
        }
    }

}

