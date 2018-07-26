//
//  LandingViewController.swift
//  sterling
//
//  Created by People on 2018-07-09.
//  Copyright © 2018 khng. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var networkService: NetworkServiceProtocol!
    
    func configure(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
