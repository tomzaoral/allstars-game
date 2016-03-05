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
        
        let pan = UIPanGestureRecognizer(target: self, action: "move:")
        self.view.addGestureRecognizer(pan)
    }
	
	var lastPosition: CGPoint = CGPoint(x: 960, y: 540)
    
    func move(sender: UIPanGestureRecognizer) {
        
        if sender.state == .Ended {
			
			lastPosition = crosshair.center
			
        } else if sender.state == .Changed {
			
            let translation = sender.translationInView(self.view)
			
			let newX = max(min(lastPosition.x + translation.x, 1920), 0)
			let newY = max(min(lastPosition.y + translation.y, 1080), 0)
			
			crosshair.center = CGPoint(x: newX, y: newY)

		}
        
    }


}

