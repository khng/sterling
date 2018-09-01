//
//  LandingViewController.swift
//  sterling
//
//  Created by People on 2018-07-09.
//  Copyright © 2018 khng. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var networkService: NetworkServiceProtocol!
    
    func configure(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.hidesWhenStopped = true
        activitySpinner.startAnimating()
        networkService.fetchData { (unitDataDictionary) in
            print(unitDataDictionary)
            self.activitySpinner.stopAnimating()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
