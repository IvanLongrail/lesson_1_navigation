//
//  ViewController2.swift
//  lesson_1_navigation
//
//  Created by Иван longrail on 05/03/2019.
//  Copyright © 2019 Иван longrail. All rights reserved.
//

import UIKit

class AuthorizationVC: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var repeateButton: UIButton!
    
    var result: ResultsHandlersData?
    
    override func viewDidLoad() {
        resultLabel.text = result?.ofAuthorization.getMessage()
        view.backgroundColor = result?.ofAuthorization.backgroundColor
        if result?.ofAuthorization.getState() != .correctData {
            repeateButton.setTitle("Fix", for: .normal)
        }
    }
    
}
