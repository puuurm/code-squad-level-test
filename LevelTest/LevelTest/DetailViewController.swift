//
//  DetailViewController.swift
//  LevelTest
//
//  Created by yangpc on 2017. 10. 12..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var album: Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundImage.image = album.image
        nameLabel.text = album.title
        dateLabel.text = album.date
    }
}

