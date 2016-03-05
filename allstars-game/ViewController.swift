//
//  ViewController.swift
//  allstars-game
//
//  Created by Tomas Zaoral on 05/03/16.
//  Copyright © 2016 STRV Hackaton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var crosshair: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pan = UIPanGestureRecognizer(target: self, action: "move:")
        self.view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func move(sender: UIPanGestureRecognizer) {
//        if sender.state == .Began {
//            
//        }
        
//        if sender.state == .Ended {
//            
//        }
        
        if sender.state == .Changed {
            let locatedPoint = sender.translationInView(self.view)
            crosshair.center.x
        
            if 0...view.frame.height ~= locatedPoint.y && 0...view.frame.width ~= locatedPoint.x {
                crosshair.center = locatedPoint
            }
        }
        
        

        
    }


}

