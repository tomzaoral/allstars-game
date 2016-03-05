//
//  ViewController.swift
//  allstars-game
//
//  Created by Tomas Zaoral on 05/03/16.
//  Copyright © 2016 STRV Hackaton. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
	@IBOutlet weak var playground: UIView!
    @IBOutlet weak var crosshair: UIImageView!
	@IBOutlet weak var scoreView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: "move:")
        self.playground.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: "fire")
        self.view.addGestureRecognizer(tap)
        
        let kill = NSBundle.mainBundle().pathForResource("kill", ofType: "mp3")!
        let killUrl = NSURL(fileURLWithPath: kill)
        do { killSoundPlayer = try AVAudioPlayer(contentsOfURL: killUrl, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        
        killSoundPlayer.numberOfLoops = 0
        killSoundPlayer.prepareToPlay()
        
        let monsterKill = NSBundle.mainBundle().pathForResource("monsterKill", ofType: "mp3")!
        let monsterKillUrl = NSURL(fileURLWithPath: monsterKill)
        do { monsterSoundPlayer = try AVAudioPlayer(contentsOfURL: monsterKillUrl, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        monsterSoundPlayer.prepareToPlay()
        monsterSoundPlayer.play()
        
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        
    }
    
    var killSoundPlayer = AVAudioPlayer()
    var monsterSoundPlayer = AVAudioPlayer()
    
    var monsters: [Monster] = []
    
    var lastPosition: CGPoint = CGPoint(x: 960, y: 540)
    
    var scoreValue: Int = 0 {
        didSet {
            scoreView.text = "\(scoreValue)"
        }
    }
    
    func move(sender: UIPanGestureRecognizer) {
        
        if sender.state == .Ended {
            
            lastPosition = crosshair.center
            
        } else if sender.state == .Changed {
            
            let translation = sender.translationInView(self.playground)
            
            let newX = max(min(lastPosition.x + translation.x, playground.frame.width), 0)
            let newY = max(min(lastPosition.y + translation.y, playground.frame.height), 0)
            
            crosshair.center = CGPoint(x: newX, y: newY)
            
        }
        
    }
    
    func fire() {		
        let crosshairPosition = crosshair.center
        
        let index = monsters.indexOf { CGRectContainsPoint($0.imageView!.frame, crosshairPosition) }
        
        if let i = index {
            let monster = monsters[i]
            
            killSoundPlayer.play()
            
            scoreValue++
			
			UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
				monster.imageView!.alpha = 0
				}, completion: { (_) -> Void in
					
					monster.imageView!.frame = self.getCoords()
					monster.imageView!.image = UIImage(named: "monster_\(arc4random_uniform(3) + 1)")
					
					UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
						monster.imageView!.alpha = 1
						}, completion: nil)
					
			})
		}
    }
    
    func addMonster() {
        if monsters.count > 5 { return }
        
        let imageview = UIImageView(image: UIImage(named: "monster_\(arc4random_uniform(3) + 1)"))
        
        imageview.frame = getCoords()
        
        playground.insertSubview(imageview, belowSubview: crosshair)
        
        let monster = Monster()
        monster.imageView = imageview
        
        monsters.append(monster)
    }
    
    func getCoords() ->CGRect {
        let randomY = arc4random_uniform(UInt32(playground.frame.height - 200)) + 1
        let randomX = arc4random_uniform(UInt32(playground.frame.width - 200)) + 1
        
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

