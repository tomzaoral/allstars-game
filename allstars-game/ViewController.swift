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
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: "move:")
        self.view.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: "fire")
        self.view.addGestureRecognizer(tap)
        
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        
    }
    
    var monsters: [Monster] = []
    
    var lastPosition: CGPoint = CGPoint(x: 960, y: 540)
    
    var scoreValue: Int = 0 {
        didSet {
//            score.text = "\(scoreValue)"
        }
    }
    
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
    
    func fire() {
        let crosshairPosition = crosshair.center
        
        let index = monsters.indexOf { CGRectContainsPoint($0.imageView!.frame, crosshairPosition) }
        
        if let i = index {
            let monster = monsters[i]
            
            scoreValue++
            
            monster.imageView?.frame = getCoords()
            
            monster.imageView?.image = UIImage(named: "monster_\(arc4random_uniform(3) + 1)")
            
        }
        
    }
    
    func addMonster() {
        if monsters.count > 5 { return }
        
        let imageview = UIImageView(image: UIImage(named: "monster_\(arc4random_uniform(3) + 1)"))
        
        imageview.frame = getCoords()
        
        view.insertSubview(imageview, belowSubview: crosshair)
        
        let monster = Monster()
        monster.imageView = imageview
        
        monsters.append(monster)
    }
    
    func getCoords() ->CGRect {
        let randomY = arc4random_uniform(UInt32(view.frame.height - 200)) + 1
        let randomX = arc4random_uniform(UInt32(view.frame.width - 200)) + 1
        
        let newCoords = CGRect(origin: CGPoint(x: Int(randomX), y: Int(randomY)), size: CGSize(width: 200, height: 200))
        
        var intersect = false
        for m in monsters {
            let monsterCoords = m.imageView?.frame
            
            
            if CGRectIntersectsRect(newCoords, monsterCoords!) {
                intersect = true
            }
        }
        
        if intersect {
            return getCoords()
        } else {
            return newCoords
        }
    }
    
    
}

class Monster {
    
    var imageView: UIImageView?
    
}

