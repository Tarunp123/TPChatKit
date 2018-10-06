//
//  Extensions.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/23/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    static func heightForSingleLine(font: UIFont, fontPointSize pointSize: CGFloat) -> CGFloat {
        let label = UILabel()
        label.font = font.withSize(pointSize)
        label.numberOfLines = 0
        label.text = "TPChatKit"
        return label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    static func getSizeToFitText(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat?) -> CGSize {
        let label = UILabel()
        label.font = font.withSize(pointSize)
        label.numberOfLines = 0
        label.text = text
        return label.sizeThatFits(CGSize(width: maxWidth, height: maxHeight ?? CGFloat.greatestFiniteMagnitude))
    }
    
    func getLinesArrayOfString() -> [String] {
        
        var linesArray = [String]()
        
        guard let text = self.text, let font = self.font else {return linesArray}
        
        let rect = self.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }
    
}

extension UITextView{
    
    static func getSizeToFitText(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat?) -> CGSize {
        let textView = UITextView()
        textView.font = font.withSize(pointSize)
        textView.textContainerInset = .zero
        textView.text = text
        return textView.sizeThatFits(CGSize(width: maxWidth, height: maxHeight ?? CGFloat.greatestFiniteMagnitude))
    }
    
    
    static func getLastLineSize(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat) -> CGSize {
        
        var linesArray = [String]()
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.greatestFiniteMagnitude), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return .zero}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        
        if let lastLine =  linesArray.last{
            return UITextView.getSizeToFitText(text: lastLine, font: font, fontPointSize: font.pointSize, maxWidth: msgBubbleMaxWidth, maxHeight: nil)
        }
        
        return .zero
    }
    
    
}


extension String{
    
    static func getTimeStampForMsgBubbleForDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}

extension UICollectionView {
    func scrollToBottom() {
        guard numberOfSections > 0 else {
            return
        }
        
        let lastSection = numberOfSections - 1
        
        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }
        
        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}

extension UIFont{
    
//    static func getWidthRequiredByOneCharacter
    
}


