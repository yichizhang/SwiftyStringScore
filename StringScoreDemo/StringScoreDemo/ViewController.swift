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
	lazy var textView:UITextView = {
		let tv = UITextView(frame: self.view.bounds)
		
		return tv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		var t = ""
		let f = 1.0
		let b = "Melbourne Dingo Harry"
		for s in stringsToTest {
			t = t + "\(s) _scoreAgainst_ \(b)\n"
			let y = (s as NSString).scoreAgainst(b, fuzziness: f, options: .None)
			let z = s.scoreAgainst(b, fuzziness: f, options: .None)
			
			t = t + "\(y) \t \(z)\n\n"
		}
		
		for s in stringsToTest {
			t = t + "\(b) _scoreAgainst_ \(s)\n"
			let y = (b as NSString).scoreAgainst(s, fuzziness: f, options: .None)
			let z = b.scoreAgainst(s, fuzziness: f, options: .None)
			
			t = t + "\(y) \t \(z)\n\n"
		}
		
		view.addSubview(textView)
		textView.text = t
		
		println( ( StringScoreOption.FavorSmallerWords ).rawValue ) // = 1
		println( ( StringScoreOption.ReducedLongStringPenalty ).rawValue ) // = 2
		println( ( StringScoreOption.FavorSmallerWords | StringScoreOption.ReducedLongStringPenalty ).rawValue ) // = 3
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

