//
//  NetworkService.swift
//  sterling
//
//  Created by People on 7/26/18.
//  Copyright © 2018 khng. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData()
}

class NetworkService: NetworkServiceProtocol {
    var unitDataDictionary: [Date : UnitData] = [:]

    func fetchData() {
        var apiUrl: URL!
        apiUrl = getUrlWith()
   
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(error ?? "Did not receive data")
                return
            }
            
            do {
                guard let results = try JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                    print("Invalid JSON structure")
                    return
                }
                
                guard let resultsDictionary = results["Time Series (Daily)"] as? [String:Any] else {
                    print("Invalid inner JSON structure")
                    return
                }
                let resultsKeys = resultsDictionary.keys
                
                for resultKey in resultsKeys {
                    guard let dayData = resultsDictionary[resultKey] as? [String:String] else {
                        print("Invalid JSON")
                        return
                    }
                    
                    let unitData = try UnitData(from: dayData)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
                    let date = dateFormatter.date(from: resultKey)
                    self.unitDataDictionary[date!] = unitData
                }
            } catch {
                print("Could not parse JSON")
                return
            }
        }.resume()
    }
    
    func getUrlWith(symbol: String = "MSFT") -> URL {
        let baseUrl = "https://www.alphavantage.co/"
        let queryUrl = "query?function=TIME_SERIES_DAILY&symbol=\(symbol)&apikey=demo"
        return URL(string: baseUrl + queryUrl)!
    }
    
}
