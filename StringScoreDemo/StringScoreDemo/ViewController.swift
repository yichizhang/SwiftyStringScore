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
		tv.editable = false
		return tv
	}()
	
	func testDisplayStringFor(#string1:String, string2:String, fuzziness:Double, options:StringScoreOption) -> String {
		
		var t = "fuzziness = \(fuzziness); options = \(options.rawValue)\n\(string1) AGAINST \(string2)\n"
		var o = NSStringScoreOption(rawValue: options.rawValue)
		
		let y = (string1 as NSString).scoreAgainst(string2, fuzziness: fuzziness, options: o)
		let z = string1.scoreAgainst(string2, fuzziness: fuzziness, options: options)
		
		t = t + "\(y) \t \(z)\n\n"
		
		return t
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		var t = ""
		let baseString = "Melbourne Dingo Harry"
		
		let fuzzinessArray = [0.5, 1.0, 2.0]
		let optionsArray = [
			StringScoreOption.None,
			StringScoreOption.FavorSmallerWords,
			StringScoreOption.ReducedLongStringPenalty,
			StringScoreOption.FavorSmallerWords | StringScoreOption.ReducedLongStringPenalty
		]
		for fuzziness in fuzzinessArray {
			for option in optionsArray {
				for string in stringsToTest {
					t = t + testDisplayStringFor(string1: string, string2: baseString, fuzziness: fuzziness, options: option)
					t = t + testDisplayStringFor(string1: baseString, string2: string, fuzziness: fuzziness, options: option)
				}
			}
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

