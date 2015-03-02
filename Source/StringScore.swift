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
	func scoreAgainst(otherString:String) -> Double {
		return self.scoreAgainst(otherString, fuzziness: nil, options: StringScoreOption.None)
	}
	func scoreAgainst(otherString:String, fuzziness:Double?) -> Double {
		return self.scoreAgainst(otherString, fuzziness: fuzziness, options: StringScoreOption.None)
	}
	func scoreAgainst(_otherString:String, fuzziness:Double?, options:StringScoreOption) -> Double {
		let workingInvalidCharacterSet = NSCharacterSet.lowercaseLetterCharacterSet().mutableCopy() as NSMutableCharacterSet
		workingInvalidCharacterSet.formUnionWithCharacterSet(NSCharacterSet.uppercaseLetterCharacterSet())
		workingInvalidCharacterSet.addCharactersInString(" ")
		let invalidCharacterSet = workingInvalidCharacterSet.invertedSet
		
		var string = "".join(self.decomposedStringWithCanonicalMapping.componentsSeparatedByCharactersInSet(invalidCharacterSet))
		let otherString = "".join(_otherString.decomposedStringWithCanonicalMapping.componentsSeparatedByCharactersInSet(invalidCharacterSet))
		
		// If the string is equal to the abbreviation, perfect match.
		if string == otherString {
			return 1.0
		}
		
		//if it's not a perfect match and is empty return 0
		if otherString.isEmpty {
			return 0.0
		}
		
		var totalCharacterScore = 0.0
		let otherStringLengthInt = countElements(otherString)
		let otherStringLengthDouble = Double(countElements(otherString))
		let stringLengthDouble = Double(countElements(string))
		var startOfStringBonus = false
		var otherStringScore = 0.0
		var fuzzies = 1.0
		var finalScore = 0.0
		
		for var index = 0; index < otherStringLengthInt; index++ {
			var characterScore = 0.1
			var indexInString:String.Index?
			let chr = String( otherString[advance(otherString.startIndex, index)] as Character )
			
			var rangeChrLowercase = string.rangeOfString(chr.lowercaseString, options: nil, range: nil, locale: nil)
			var rangeChrUppercase = string.rangeOfString(chr.uppercaseString, options: nil, range: nil, locale: nil)
			
			if let rangeChrLowercase = rangeChrLowercase {
				if let rangeChrUppercase = rangeChrUppercase {
					// Chr Lowercase: FOUND; Chr Uppercase: FOUND
					indexInString = min(rangeChrLowercase.startIndex, rangeChrUppercase.startIndex)
				} else {
					indexInString = rangeChrLowercase.startIndex
				}
			} else {
				if let rangeChrUppercase = rangeChrUppercase {
					indexInString = rangeChrUppercase.startIndex
				} else {
					// Chr Lowercase: NOT found; Chr Uppercase: NOT found
					if let fuzziness = fuzziness {
						fuzzies += 1.0 - fuzziness
					} else {
						return 0.0 // This is an error
					}
				}
			}
			
			// Set base score for matching chr
			
			if let indexInString = indexInString {
				// Same case bonus.
				if string.substringWithRange( Range(start: indexInString, end: advance(indexInString, 1)) ) == chr {
					characterScore += 0.1
				}
				
				// Consecutive letter & start-of-string bonus
				if indexInString == string.startIndex {
					// Increase the score when matching first character of the remainder of the string
					characterScore += 0.6
					if index == 0 {
						// If match is the first character of the string
						// & the first character of abbreviation, add a
						// start-of-string match bonus.
						startOfStringBonus = true
					}
				} else {
					// Acronym Bonus
					// Weighing Logic: Typing the first character of an acronym is as if you
					// preceded it with two perfect character matches.
					if string.substringWithRange( Range(start: advance(indexInString, -1), end: indexInString) ) == " " {
						characterScore += 0.8
					}
				}
				
				// Left trim the already matched part of the string
				// (forces sequential matching).
				string = string.substringFromIndex(advance(indexInString, 1))
			}
			
			totalCharacterScore += characterScore
		}
		
		if StringScoreOption.FavorSmallerWords == options & StringScoreOption.FavorSmallerWords {
			// Weigh smaller words higher
			return totalCharacterScore / stringLengthDouble
		}
		
		otherStringScore = totalCharacterScore / otherStringLengthDouble
		
		if StringScoreOption.ReducedLongStringPenalty == options & StringScoreOption.ReducedLongStringPenalty {
			// Reduce the penalty for longer words
			let percentageOfMatchedString = otherStringLengthDouble / stringLengthDouble
			let wordScore = otherStringScore * percentageOfMatchedString
			finalScore = (wordScore + otherStringScore) / 2
		} else {
			finalScore = ( (otherStringScore * (otherStringLengthDouble / stringLengthDouble)) + otherStringScore ) / 2
		}
		
		finalScore = finalScore / fuzzies
		
		/*
		if startOfStringBonus {
			finalScore = min(finalScore + 0.15, 1.0)
		}
		*/
		
		if startOfStringBonus && finalScore + 0.15 < 1.0 {
			finalScore += 0.15
		}
		
		return finalScore
	}
}