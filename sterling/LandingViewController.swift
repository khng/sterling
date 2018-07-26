//
//  LandingViewController.swift
//  sterling
//
//  Created by People on 2018-07-09.
//  Copyright © 2018 khng. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var unitDataDictionary: [Date : UnitData] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiUrl = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo")
        
        var request = URLRequest(url: apiUrl!)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, err in
            do {
                let results = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let resultsDictionary = results["Time Series (Daily)"] as! [String:Any]
                let resultsKeys = resultsDictionary.keys
                
                for resultKey in resultsKeys {
                    let dayData = resultsDictionary[resultKey] as! [String:String]
                    
                    let unitData = try UnitData(from: dayData)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
                    let date = dateFormatter.date(from: resultKey)
                    self.unitDataDictionary[date!] = unitData
                }
            } catch {}
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
