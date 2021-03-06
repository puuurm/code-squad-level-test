//
//  ViewController.swift
//  LevelTest
//
//  Created by yangpc on 2017. 10. 12..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myTableView: UITableView!
    var yearArray = [String]()
    var yearCellNum = [Int]()
    
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
        myTableView.delegate = self
        myTableView.dataSource = self
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
        albulmArray = albulmArray.sorted(by: {return $0.date < $1.date})
        
        var yearSet: Set<String> = []
        for data in albulmArray {
            let yeardata = filterYear(date: data.date)
            yearSet.insert(String(yeardata))
        }
        yearArray = yearSet.sorted(by: {$0 < $1})
        
        for idx in 0..<yearArray.count {
            yearCellNum.append(0)
            for album in albulmArray {
                if yearArray[idx] != filterYear(date: album.date) {continue}
                yearCellNum[idx] += 1
            }
        }
        
        
    }
    
    func filterYear(date: String) -> String {
        let index = date.index(date.startIndex, offsetBy: 5)
        let range = ..<date.index(before: index)
        return String(date[range])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearCellNum[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return yearArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return yearArray[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            cell.backgroundImage.image = albulmArray[row].image
            cell.nameLabel.text = albulmArray[row].title
            cell.dateLabel.text = albulmArray[row].date
        } else {
            let currentAlbum = albulmArray[section * yearCellNum[section-1]+row]
            cell.backgroundImage.image = currentAlbum.image
            cell.nameLabel.text = currentAlbum.title
            cell.dateLabel.text = currentAlbum.date
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.navigationItem.title = "Photo"
        let selectedAlbum = albulmArray[indexPath.row]
        detailViewController.album = selectedAlbum
    }
    
    
}
