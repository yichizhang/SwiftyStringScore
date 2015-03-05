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
	
	func testDisplayStringFor(#string1:String, string2:String, fuzziness:Double?, options:StringScoreOption) -> String {
		
		var t = "fuzziness = \(fuzziness); options = \(options.rawValue)\n\(string1) AGAINST \(string2)\n"
		var o = NSStringScoreOption.allZeros
		
		if StringScoreOption.FavorSmallerWords == (options & StringScoreOption.FavorSmallerWords) {
			o = o | NSStringScoreOption.FavorSmallerWords
		}
		if StringScoreOption.ReducedLongStringPenalty == (options & StringScoreOption.ReducedLongStringPenalty) {
			o = o | NSStringScoreOption.ReducedLongStringPenalty
		}
		
		var x:CGFloat = 0.0
		var y = 0.0
		var z = 0.0
		if let f = fuzziness {
			x = (string1 as NSString).scoreAgainst(string2, fuzziness: fuzziness, options: o)
		} else {
			x = (string1 as NSString).scoreAgainst(string2)
		}
		y = string1.scoreAgainst(string2, fuzziness: fuzziness, options: options)
		z = string1.score(word: string2, fuzziness: fuzziness)
		
		t = t + "\(x) \t\(y) \t \(z)\n\n"
		
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
		
		let fuzzinessArray = [0.5, 0.7, 1.0]
		let optionsArray = [
			StringScoreOption.None,
			StringScoreOption.FavorSmallerWords,
			StringScoreOption.ReducedLongStringPenalty,
			StringScoreOption.FavorSmallerWords | StringScoreOption.ReducedLongStringPenalty
		]
		
		for fuzziness in fuzzinessArray {
			for option in optionsArray {
				for baseString in baseStrings {
					for string in stringsToTest {
						t = t + testDisplayStringFor(string1: baseString, string2: string, fuzziness: fuzziness, options: option)
						t = t + testDisplayStringFor(string1: baseString, string2: string, fuzziness: nil, options: option)
					}
				}
			}
		}
		
		let doTests = false
		let baseString = baseStrings[0]
		if doTests {
			let numberOfTimes = 1000
			
			let fuzziness = 0.5
			
			var d = NSDate()
			for i in 0..<numberOfTimes{
				for string in stringsToTest {
					let z = (baseString as NSString).scoreAgainst(string, fuzziness: fuzziness, options: NSStringScoreOption.None)
				}
			}
			println( NSDate().timeIntervalSinceDate(d) )
			
			d = NSDate()
			for i in 0..<numberOfTimes{
				for string in stringsToTest {
					let z = baseString.scoreAgainst(string, fuzziness: fuzziness, options: StringScoreOption.None)
				}
			}
			println( NSDate().timeIntervalSinceDate(d) )
			
			d = NSDate()
			for i in 0..<numberOfTimes{
				for string in stringsToTest {
					let z = baseString.score(word: string, fuzziness: fuzziness)
				}
			}
			println( NSDate().timeIntervalSinceDate(d) )
			
			// TEST RESULT
			/*
			NSString+Score (by thetron)
			0.607234001159668
			
			StringScore (ported from NSString+Score by thetron)
			9.52004301548004
			
			StringScore_new (ported from tring_score by joshaven [javascript])
			4.51837503910065
			*/
		}
		
		view.addSubview(textView)
		textView.text = t
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

