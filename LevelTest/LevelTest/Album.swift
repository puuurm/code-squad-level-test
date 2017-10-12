//
//  Album.swift
//  LevelTest
//
//  Created by yangpc on 2017. 10. 12..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class Album: NSObject {
    let title: String
    let image: UIImage
    let date: String
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let imageName = json["image"] as? String,
            let image = UIImage(named: imageName),
            let date = json["date"] as? String else {
                return nil
        }
        self.title = title
        self.image = image
        self.date = date
    }
} 
