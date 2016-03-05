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
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "addMonster", userInfo: nil, repeats: true)
        
        

    }
    
    var monsters: [Monster] = []
	
	var lastPosition: CGPoint = CGPoint(x: 960, y: 540)
    
    func move(sender: UIPanGestureRecognizer) {
        
        if sender.state == .Ended {
			
			lastPosition = crosshair.center
			
        } else if sender.state == .Changed {
			
            let translation = sender.translationInView(self.view)
			
			let newX = max(min(lastPosition.x + translation.x, view.frame.width), 0)
			let newY = max(min(lastPosition.y + translation.y, view.frame.height), 0)
			
			crosshair.center = CGPoint(x: newX, y: newY)

		}
        
    }
    
    func addMonster() {
        if monsters.count > 5 { return }
        
        let imageview = UIImageView(image: UIImage(named: "monster_\(arc4random_uniform(3) + 1)"))
        
        let randomHeight = arc4random_uniform(UInt32(view.frame.height - 200)) + 1
        let randomWidth = arc4random_uniform(UInt32(view.frame.width - 200)) + 1

        imageview.frame = CGRect(origin: CGPoint(x: Int(randomWidth), y: Int(randomHeight)), size: CGSize(width: 200, height: 200))
        
        
        view.insertSubview(imageview, belowSubview: crosshair)
        
        let monster = Monster()
        monster.imageView = imageview
        
        monsters.append(monster)
    }


}

class Monster {
    
    var imageView: UIImageView?
    
}

