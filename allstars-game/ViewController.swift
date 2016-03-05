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
	
	var lastPosition: CGPoint = CGPoint(x: 960, y: 540)
    
    func move(sender: UIPanGestureRecognizer) {
		
        if sender.state == .Began {
            
        }
        
        if sender.state == .Ended {
			lastPosition = crosshair.center
        }
		
        if sender.state == .Changed {
            let translation = sender.translationInView(self.view)
			
			let newX = lastPosition.x + translation.x
			let newY = lastPosition.y + translation.y
        
//            if 0...view.frame.height ~= newX && 0...view.frame.width ~= newY {
                crosshair.center = CGPoint(x: newX, y: newY)
//            }
        }
        
    }


}

