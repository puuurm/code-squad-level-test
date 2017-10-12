//
//  ViewController.swift
//  LevelTest
//
//  Created by yangpc on 2017. 10. 12..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var albulmArray = [Album]()
    let jsonString = """
        [{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20150116\"},
        {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20160505\"},
        {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20141212\"},
        {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20140301\"},
        {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20150101\"},
        {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20150707\"},
        {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20140815\"},
        {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20161231\"},
        {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20150102\"},
        {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20141225\"}]
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let data = jsonString.data(using: .utf8, allowLossyConversion: true) {
            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for objs in jsonData {
                        let currentObj = Album(json: objs)
                        albulmArray.append(currentObj!)
                    }
                    albulmArray = albulmArray.sorted(by: {return $0.title < $1.title})
                                    } else {
                    print("caanot create a object from the JSON")
                }
            } catch { print("Error is: \(error)") }
        } else {
            print("cannot make data")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

