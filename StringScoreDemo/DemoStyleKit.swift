/*

Copyright (c) 2015 Yichi Zhang
https://github.com/yichizhang
zhang-yi-chi@hotmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

import UIKit

open class DemoStyleKit: NSObject
{
    class var mainFont: UIFont
    {
        return UIFont(name: "HelveticaNeue-Bold", size: 20)!
    }

    //// Cache

    fileprivate struct Cache
    {
        static var imageDict: [String:UIImage] = Dictionary()
        //        static var oneTargets: [AnyObject]?
    }

    //// Drawing Methods

    open class func draw(string: String)
    {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Text Drawing
        let textRect = CGRect(x: 0, y: 0, width: 25, height: 25)
        let textTextContent = NSString(string: string)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center

        let textFontAttributes = [NSFontAttributeName: DemoStyleKit.mainFont, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        context?.saveGState()
        context?.clip(to: textRect);
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context?.restoreGState()
    }

    //// Generated Images

    open class func imageOf(string: String) -> UIImage
    {
        if let image = Cache.imageDict[string] {
            return image
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 25), false, 0)
        DemoStyleKit.draw(string: string)

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        Cache.imageDict[string] = image

        return image
    }
}
