//
//  UnitDataTests.swift
//  sterlingTests
//
//  Created by People on 7/26/18.
//  Copyright © 2018 khng. All rights reserved.
//

import Quick
import Nimble

@testable import sterling

class UnitDataTests: QuickSpec {
    
    override func spec() {
        describe("UnitData") {
            context("when sent a valid dayData") {
                let validData = ["1. open":"1.0", "2. high":"2.0", "3. low":"3.0", "4. close":"4.0"]
                
                it("should create a UnitData") {
                    expect { try UnitData(from: validData) }.toNot(beNil())
                }
            }
            context("when data sent has missing values") {
                it("should throw missing open error") {
                    let missingOpenData = ["2. high":"2.0", "3. low":"3.0", "4. close":"4.0"]
                    
                    expect { try UnitData(from: missingOpenData) }.to(throwError(SerializationError.missing("open")))
                }
                it("should throw missing high error") {
                    let missingHighData = ["1. open":"1.0", "3. low":"3.0", "4. close":"4.0"]

                    expect { try UnitData(from: missingHighData) }.to(throwError(SerializationError.missing("high")))
                }
                it("should throw missing low error") {
                    let missingLowData = ["1. open":"1.0", "2. high":"2.0", "4. close":"4.0"]
                    
                    expect { try UnitData(from: missingLowData) }.to(throwError(SerializationError.missing("low")))
                }
                it("should throw missing close error") {
                    let missingCloseData = ["1. open":"1.0", "2. high":"2.0", "3. low":"3.0"]
                    
                    expect { try UnitData(from: missingCloseData) }.to(throwError(SerializationError.missing("close")))
                }
            }
            context("when data sent cannot be casted to Double") {
                it("should throw invalid type error") {
                    let invalidTypeData = ["1. open":"onepointone", "2. high":"2.0", "3. low":"3.0", "4. close":"4.0"]

                    expect { try UnitData(from:invalidTypeData) }.to(throwError(SerializationError.invalidType()))
                }
            }
        }
    }
    
}
