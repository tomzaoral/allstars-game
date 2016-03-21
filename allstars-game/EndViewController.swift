//
//  EndViewController.swift
//  allstars-game
//
//  Created by Lukas Machalik on 05/03/16.
//  Copyright © 2016 STRV Hackaton. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

	@IBOutlet weak var timeLabel: UILabel!
	
	var resultTime: Double?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let resultTime = resultTime {
            timeLabel.text = String(format: "%.2f s", arguments: [resultTime])
        } else {
            assert(false, "No result time!")
            timeLabel.text = "? s"
        }
    }
    
    @IBAction func playAgainButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
