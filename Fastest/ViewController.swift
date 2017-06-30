//
//  ViewController.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let parabolicMotion = ParabolicMotion()
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var numbersDisplayView: NumbersDisplayView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.setImage(UIImage(named:"power-off"), for: UIControlState.normal)
        startButton.setImage(UIImage(named:"power-on"), for: UIControlState.disabled)
    }
    
    @IBAction func startButtonPressed() {
        
        self.startButton.isEnabled = false
        self.parabolicMotion.calculateParabolicMotion { [unowned self] (reach) in
            
            self.numbersDisplayView.animate(tillNumber: reach, completion: { [ unowned self] in
                self.startButton.isEnabled = true
            })
        }
    }
}





