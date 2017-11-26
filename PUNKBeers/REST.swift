//
//  REST.swift
//  PUNKBeers
//
//  Created by André Couto on 20/11/17.
//  Copyright © 2017 André Couto. All rights reserved.
//

import Foundation
import UIKit

class REST {
    
    static let basePath = "https://api.punkapi.com/v2/beers"
    
    static let configuration: URLSessionConfiguration = {
        
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 45.0
        config.httpMaximumConnectionsPerHost = 5
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
    
    static func loadBeers(onComplete: @escaping ([Beer]?) -> Void) {
        
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("erro!!!")
                onComplete(nil)
            } else {
                
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                        
                        var beers: [Beer] = []
                        for item in json {
                          
                            let id = item["id"] as! Int
                            let name = item["name"] as! String
                            let tagline = item["tagline"] as! String
                            let abv = item["abv"] as! Double
                            let ibu : Double?
                            if let ibu_r = item["ibu"] as? Double
                            {
                                ibu = ibu_r
                            }
                            else {
                                ibu = nil
                            }
                            let description = item["description"] as! String
                            let image_url = item["image_url"] as! String
                            
                            let beer = Beer(id: id, name: name, tagLine: tagline,alcoholContent: abv,bitternessScale: ibu, description: description, image: image_url)
                            
                            beers.append(beer)
                        }
                        onComplete(beers)
                        
                    } catch {
                        print(error.localizedDescription)
                        onComplete(nil)
                    }
                    
                    
                } else {
                    print("Erro no servidor:", response.statusCode)
                    onComplete(nil)
                }
            
            }
            
        }
        dataTask.resume()
    }
    
    static func downloadImage(url: String, onComplete: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {
            onComplete(nil)
            return
        }
        
        session.downloadTask(with: url) { (imageURL: URL?, response: URLResponse?, error: Error?) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let imageURL = imageURL {
                
                let imageData = try! Data(contentsOf: imageURL)
                let image = UIImage(data: imageData)
                onComplete(image)
                
            } else {
                onComplete(nil)
            }
            
            }.resume()
        
    }
    
    
}
