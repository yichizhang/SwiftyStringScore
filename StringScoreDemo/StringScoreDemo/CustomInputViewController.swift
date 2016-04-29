//
//  CustomInputViewController.swift
//  StringScoreDemo
//
//  Created by YICHI ZHANG on 21/02/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import UIKit
import StringScore_Swift

class CustomInputViewController: UIViewController, UITextViewDelegate
{

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var fuzzinessSlider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!

    func commonInit()
    {
        self.title = "Custom Input"
        self.tabBarItem = UITabBarItem(title: self.title, image: DemoStyleKit.imageOf(string: "B"), tag: 1)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        searchTextField.text = "Alice 😄 😅 "

        sourceTextView.text = "Alice has a Dingo. 😄 😅 😆 Alice lives in Wonderland."
        sourceTextView.delegate = self

        searchTextField.addTarget(self, action: #selector(controlValueChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
        fuzzinessSlider.addTarget(self, action: #selector(controlValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTouched(_:))))

        updateStringScore()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Slider value changed
    func controlValueChanged(sender: AnyObject)
    {
        updateStringScore()
    }

    // MARK: Background touched
    func backgroundTouched(sender: AnyObject)
    {
        sourceTextView.resignFirstResponder()
        searchTextField.resignFirstResponder()
    }

    // MARK: Update
    func updateStringScore()
    {
        if let sourceText = sourceTextView.text, searchText = searchTextField.text {
            let score = sourceText.score(searchText, fuzziness: Double(fuzzinessSlider.value))
            resultLabel.text = score.yz_toString()
        }
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView)
    {
        updateStringScore()
    }
}

