//
//  ViewController.swift
//  StringScoreDemo
//
//  Created by YICHI ZHANG on 21/02/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let stringsToTest = [
		"Dingo in Wonderland",
		"Melbourne Dingo",
		"You Better Take Cover by Harry Hayes",
		"Sience 1997; Melbourne Dingo Harry; Crazy Cat",
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let f = 1.0
		for s in stringsToTest {
			
			println( (s as NSString).scoreAgainst("Melbourne Dingo Harry", fuzziness: f, options: NSStringScoreOption.None) )
			println( ("Melbourne Dingo Harry" as NSString).scoreAgainst(s, fuzziness: f, options: NSStringScoreOption.None) )
		}
		
		for s in stringsToTest {
			
			println( s.scoreAgainst("Melbourne Dingo Harry", fuzziness: f, options: StringScoreOption.None) )
			println( "Melbourne Dingo Harry".scoreAgainst(s, fuzziness: f, options: StringScoreOption.None) )
		}
		
		println( ( StringScoreOption.FavorSmallerWords ).rawValue ) // = 1
		println( ( StringScoreOption.ReducedLongStringPenalty ).rawValue ) // = 2
		println( ( StringScoreOption.FavorSmallerWords | StringScoreOption.ReducedLongStringPenalty ).rawValue ) // = 3
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

