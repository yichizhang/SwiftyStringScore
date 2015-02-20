//
//  ViewController.swift
//  StringScoreDemo
//
//  Created by YICHI ZHANG on 21/02/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		println( ("xxxxxxxx" as NSString).scoreAgainst( "xxxx" ) )
		
		println( ( StringScoreOption.FavorSmallerWords ).rawValue ) // = 1
		println( ( StringScoreOption.ReducedLongStringPenalty ).rawValue ) // = 2
		println( ( StringScoreOption.FavorSmallerWords | StringScoreOption.ReducedLongStringPenalty ).rawValue ) // = 3
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

