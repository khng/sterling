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
        
        var request = URLRequest(url: URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo")!)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, err in
            do {
                let results: NSDictionary = try JSONSerialization.jsonObject(with: data!) as! NSDictionary
                let resultsDictionary = results.value(forKey: "Time Series (Daily)") as! NSDictionary
                let resultsKeys = resultsDictionary.allKeys as! Array<String>
                
                for resultKey in resultsKeys {
                    let dayData = resultsDictionary.value(forKey: resultKey) as! Dictionary<String, String>
                    var open: Double? = nil
                    var high: Double? = nil
                    var low: Double? = nil
                    var close: Double? = nil
                    
                    for (key, value) in dayData {
                        let valueAsDouble = Double(value)!
                        switch key {
                        case "1. open":
                            open = valueAsDouble
                        case "2. high":
                            high = valueAsDouble
                        case "3. low":
                            low = valueAsDouble
                        case "4. close":
                            close = valueAsDouble
                        default:
                            _ = valueAsDouble
                        }
                    }
                    let unitData = UnitData(open: open, high: high, low: low, close: close)
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
