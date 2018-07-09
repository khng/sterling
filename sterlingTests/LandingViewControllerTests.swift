//
//  LandingViewControllerTests.swift
//  sterlingTests
//
//  Created by People on 2018-07-09.
//  Copyright © 2018 khng. All rights reserved.
//

import Quick
import Nimble

@testable import sterling

class LandingViewControllerTests: QuickSpec {
    
    override func spec() {
        var subject: LandingViewController!
        
        beforeEach {
            subject = LandingViewController()
        }
        
        describe("LandingViewController") {
            it("View has loaded") {
                expect(subject.view).toNot(beNil())
            }
        }
        
    }
    
}
