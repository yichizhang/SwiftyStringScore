import UIKit
import Quick
import Nimble
import StringScore_Swift

class StringScoreTestSpec: QuickSpec
{
    var testCaseArray: [StringScoreTestCase]!
    var precision: Double!

    override func setUp()
    {
        super.setUp()
    }
    override func spec()
    {
        testCaseArray = StringScoreTestCaseManager.defaultTestCaseArray()
        precision = 0.00001

        describe("String scores") {
            for testCase in self.testCaseArray {
                context(testCase.description, {
                    it("Returns correct score", closure: {
                        let actualScore = testCase.text.score(testCase.searchString, fuzziness: testCase.fuzziness)

                        expect(actualScore).to(beCloseTo(testCase.expectedScore, within: self.precision))
                    })
                })
            }
        }
    }
}
