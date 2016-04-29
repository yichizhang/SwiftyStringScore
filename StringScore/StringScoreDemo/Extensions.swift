//
//  Extensions.swift
//  StringScoreDemo
//
//  Created by Yichi on 6/03/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import Foundation

extension Double
{
    func yz_toString() -> String
    {
        return NSString(format: "%.3f", self) as String
    }
}