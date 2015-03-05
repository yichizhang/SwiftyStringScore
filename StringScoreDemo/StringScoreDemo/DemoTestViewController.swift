//
//  DemoTestViewController.swift
//  StringScoreDemo
//
//  Created by YICHI ZHANG on 21/02/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import UIKit

class DemoTestViewController: UIViewController {

	let stringsToTest = [
		"axl", "ow", "e", "h", "he", "hel", "hell", "hello",
		"hello worl", "hello world",
		"hello wor1",
		"h", "H",
		"HiMi", "Hills", "Hillsd"
	]
	
	lazy var textView:UITextView = {
		let tv = UITextView(frame: self.view.bounds)
		tv.editable = false
		return tv
	}()
	
	func commonInit(){
		self.title = "Test"
		self.tabBarItem = UITabBarItem(title: self.title, image: DemoStyleKit.imageOf(string: "C"), tag: 2)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		commonInit()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	override init() {
		super.init()
		commonInit()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		var t = ""
		let baseStrings = [
			"hello world",
			"He",
			"Hello",
			"Hillsdale Michigan"
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
		
		let searchPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
		let documentPath = searchPaths[0] as String
		let p = documentPath.stringByAppendingPathComponent("33333.txt")
		
		t.writeToFile(p, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
		
		println(p)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func testDisplayStringFor(#string:String, word:String, fuzziness:Double? = nil) -> String {
		
		var t = ""
		
		var z = 0.0
		z = string.score(word: word, fuzziness: fuzziness)
		
		t = t + "\"\(string)\".score(word: \"\(word)\""
		if let fuzziness = fuzziness {
			t = t + ", fuzziness:\(fuzziness)"
		}
		t = t + ")\t// ->\(z)\n"
		
		return t
	}
}

