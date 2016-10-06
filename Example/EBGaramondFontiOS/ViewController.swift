//
//  ViewController.swift
//  EBGaramondFontiOS
//
//  Created by Johann Wilfling on 10/06/2016.
//  Copyright (c) 2016 Johann Wilfling. All rights reserved.
//

import UIKit

import EBGaramondFontiOS

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "This is EB Garamond 08 Regular."
        label.font = UIFont.ebGaramond08RegularFontWithSize(17.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

