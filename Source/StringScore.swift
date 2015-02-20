//
//  StringScore.swift
//  StringScoreDemo
//
//  Created by YICHI ZHANG on 21/02/2015.
//  Copyright (c) 2015 YICHI ZHANG. All rights reserved.
//

import Foundation

struct StringScoreOption : RawOptionSetType, BooleanType {
	private let value: UInt
	init(nilLiteral: ()) { value = 0 }
	init(rawValue value: UInt) { self.value = value }
	var boolValue: Bool { return value != 0 }
	var rawValue: UInt { return value }
	static var allZeros: StringScoreOption { return self(rawValue: 0) }
	
	static var None: StringScoreOption { return self(rawValue: 0b0000) }
	static var FavorSmallerWords : StringScoreOption { return self(rawValue: 0b0001) }
	static var ReducedLongStringPenalty : StringScoreOption { return self(rawValue: 0b0010) }
}

extension String {
	func scoreAgainst(otheString:String) -> Double {
		return 0.0
	}
	func scoreAgainst(otheString:String, fuzziness:Double?) -> Double {
		return 0.0
	}
	func scoreAgainst(otheString:String, fuzziness:Double?, options:StringScoreOption) -> Double {
		return 0.0
	}
}