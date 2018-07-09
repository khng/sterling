//
//  OCHL.swift
//  sterling
//
//  Created by People on 2018-07-14.
//  Copyright © 2018 khng. All rights reserved.
//

import Foundation

// [date: unitdata, date: unitdata]

class UnitData {
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

extension UnitData: Equatable {
    static func == (lhs: UnitData, rhs: UnitData) -> Bool {
        return      lhs.open == rhs.open &&
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
