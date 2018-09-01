//
//  CommicBook.swift
//  Marvel
//
//  Created by Administrator on 25/06/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import Foundation


struct commic {
    var thumbnailUrl : String
    var title : String
    var description : String
    var imageUrl : String
}

class CommicBook {
    
    static let sharedInstance = CommicBook()
    private init() {
        
        let api = APIClass()
        api.makeCall()
    }
    var commicBooks = [commic]()
    
}

