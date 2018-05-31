import UIKit
import Quick
import Nimble
import SwiftyStringScore

class StringScoreTestSpec: QuickSpec {
  
  var testCaseArray: [TestCase]!
  var precision: Double!
  
  override func setUp() {
    super.setUp()
  }
  
  override func spec() {
    precision = 0.00001
    
    describe("score of") {
      for testCase in TestCases.default {
        context(testCase.description, {
          it("is \(testCase.score)", closure: {
            let actualScore = testCase.text.score(word: testCase.keyword, fuzziness: testCase.fz)
            
            expect(actualScore).to(beCloseTo(testCase.score, within: self.precision))
          })
        })
      }
    }
    
    describe("score of") {
      for testCase in TestCases.diacritics {
        context(testCase.description, {
          it("is \(testCase.score)", closure: {
            let actualScore = testCase.text.score(word: testCase.keyword, fuzziness: testCase.fz)
            
            expect(actualScore).to(beCloseTo(testCase.score, within: self.precision))
          })
        })
      }
    }
  }
}
