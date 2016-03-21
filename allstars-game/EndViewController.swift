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
	
	var resultTime: Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = "\(resultTime!) s"
    }
    
    @IBAction func playAgainButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
