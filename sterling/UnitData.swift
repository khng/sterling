//
//  UnitData.swift
//  sterling
//
//  Created by People on 2018-07-14.
//  Copyright © 2018 khng. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalidType()
}

struct UnitData {
    var open: Double?
    var high: Double?
    var low: Double?
    var close: Double?
    
    init(open: Double?, high: Double?, low: Double?, close: Double?) {
        self.open = open
        self.high = high
        self.low = low
        self.close = close
    }
}

extension UnitData {
    init (from dayData: [String:String]) throws {
        guard let open = dayData["1. open"] else {
            throw SerializationError.missing("open")
        }

        guard let high = dayData["2. high"] else {
            throw SerializationError.missing("high")
        }
        
        guard let low = dayData["3. low"] else {
            throw SerializationError.missing("low")
        }
        
        guard let close = dayData["4. close"] else {
            throw SerializationError.missing("close")
        }
        
        guard let openAsDouble = Double(open),
            let highAsDouble = Double(high),
            let lowAsDouble = Double(low),
            let closeAsDouble = Double(close)
            else {
                throw SerializationError.invalidType()
        }
        
        self.open = openAsDouble
        self.high = highAsDouble
        self.low = lowAsDouble
        self.close = closeAsDouble
    }
}

extension UnitData: Equatable {
    static func == (lhs: UnitData, rhs: UnitData) -> Bool {
        return lhs.open == rhs.open &&
            lhs.high == rhs.high &&
            lhs.low == rhs.low &&
            lhs.close == rhs.close
    }
}

extension UnitData: Hashable {
    var hashValue: Int {
        return open!.hashValue ^ high!.hashValue ^ low!.hashValue ^ close!.hashValue &* 16777619
    }
}
