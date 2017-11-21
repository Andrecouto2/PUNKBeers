//
//  Beer.swift
//  PUNKBeers
//
//  Created by André Couto on 20/11/17.
//  Copyright © 2017 André Couto. All rights reserved.
//

import Foundation

class Beer {
    
    var id: Int
    var name: String
    var tagLine: String
    var alcoholContent: Double
    var bitternessScale: Double?
    var description: String
    var image: String
    
    init(id: Int, name: String, tagLine: String, alcoholContent: Double, bitternessScale: Double?, description: String, image: String) {
        self.id = id
        self.name = name
        self.tagLine = tagLine
        self.alcoholContent = alcoholContent
        self.bitternessScale = bitternessScale
        self.description = description
        self.image = image
    }
    
}
