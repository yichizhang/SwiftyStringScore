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
		"You Better Take Cover",
		"Sience 1997",
		"Alice lives in Wonderland",
		"Alice has a Dingo",
		"Alice has a Dingo. Alice lives in Wonderland. Harry Hayes does not live in Wonderland",
		"AHADALIWHHDNLIW",
		"😄😅😆"
	]
	lazy var textView:UITextView = {
		let tv = UITextView(frame: self.view.bounds)
		tv.editable = false
		return tv
	}()
	
	func testDisplayStringFor(#string:String, word:String, fuzziness:Double? = nil) -> String {
		
		var t = "fuzziness = \(fuzziness).\n\(string) \nAGAINST \n \(word)\n"
		
		var z = 0.0
		z = string.score(word: word, fuzziness: fuzziness)
		
		t = t + "\(z)\n\n"
		
		return t
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		var t = ""
		let baseStrings = [
			"😄😅😆 Alice has a Dingo. Alice lives in Wonderland. Harry Hayes does not live in Wonderland, but he made a documentary called You Better Take Cover.",
			"Alice has a Dingo. Alice lives in Wonderland. Harry Hayes does not live in Wonderland, but he made a documentary called You Better Take Cover.",
			"Alice has a Dingo. Alice lives in Wonderland. Harry Hayes 😄 😅 😆 does not live in Wonderland, but he made a documentary called You Better Take Cover.",
			]
		
		let fuzzinessArray = [NSNull(), 0.5, 0.7, 1.0]
		
		for fuzziness in fuzzinessArray {
			for baseString in baseStrings {
				for string in stringsToTest {
					if fuzziness.isKindOfClass(NSNull.self){
						t = t + testDisplayStringFor(string: baseString, word: string)
					} else if let f = fuzziness as? Double {
						t = t + testDisplayStringFor(string: baseString, word: string, fuzziness: f)
					}
				}
			}
		}
		
		view.addSubview(textView)
		textView.text = t
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

