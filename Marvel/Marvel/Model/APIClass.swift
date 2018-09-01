//
//  APIClass.swift
//  Marvel
//
//  Created by Administrator on 25/06/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import Foundation

import CryptoSwift
import SwiftyJSON

class APIClass: NSObject {
    
    var CommicBooks : [commic] = []
    
    fileprivate func commicExtraction(_ subJson: JSON, _ imageSize: String) {
      
        
        if     let thumbnailExtension = subJson["thumbnail"]["extension"].string, let thumbnailPath = subJson["thumbnail"]["path"].string,
            let title = subJson["title"].string,
            let description = subJson["description"].string,
            let imageExtension = subJson["images"][0]["extension"].string,
            let imagePath = subJson["images"][0]["path"].string {
            
            let thumbnailUrl = thumbnailPath + "/" + imageSize + thumbnailExtension
            let imageUrl = imagePath + "/" + imageSize + imageExtension
            DispatchQueue.main.async {
              //  self.CommicBooks.append(url)
                let newComic = commic(thumbnailUrl: thumbnailUrl, title: title, description: description, imageUrl: imageUrl)
                self.CommicBooks.append(newComic)
            }
            
    
        }
        
    }
    

    
    func makeCall() {
        //   var backgroundThumbnails : [String] = []
        let privatekey = "933604fa90349e35cf1246042ba170776cad2e4b"
        let apikey = "4ba1cbace5d7aecc645eed0740dcaf25"
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)\(privatekey)\(apikey)".md5()
        
        //var baseURL = "https://gateway.marvel.com:443"
        
        let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(ts)&apikey=\(apikey)&hash=\(hash)")
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask: URLSessionDataTask?
        
        dataTask = defaultSession.dataTask(with: url!, completionHandler: { (data, resp, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let data = data, let response = resp as? HTTPURLResponse, response.statusCode == 200 {
                    print(data)
                    do {  let json = try JSON(data: data)
                        //  print(json)
                        let imageSize = "portrait_xlarge."
                        
                        for (_,subJson):(String, JSON) in json["data"]["results"] {
                            
                            //  self.thumbnailExtraction(subJson, imageSize)
                            self.commicExtraction(subJson, imageSize)
                            
                        }
                        DispatchQueue.main.async {
                           
                            CommicBook.sharedInstance.commicBooks = self.CommicBooks
                            NotificationCenter.default.post(name: Notification.Name("reloadTabledNotification"), object: nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            
        })
        dataTask?.resume()
        
    }
    
    
}
