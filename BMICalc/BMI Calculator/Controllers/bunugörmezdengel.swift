//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Toygun Çil on 4.07.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit //foundation importunu sildik çünkü UIKit onu da kapsıyor.

class SecondViewController: UIViewController {
    
    var bmiValue = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        let label = UILabel()
        label.text = bmiValue
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.addSubview(label)
    }
}
