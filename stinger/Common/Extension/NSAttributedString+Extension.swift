//
//  NSAttributedString+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/7/24.
//

import UIKit.UIColor

public extension NSAttributedString {
    static func lineSpaceAttributedString(with lineSpace: CGFloat, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.minimumLineHeight = lineSpace
        paragraphStyle.maximumLineHeight = lineSpace
        
        let attributedString = NSAttributedString(string: "\u{200b}\n", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
    
    static func attributedString(with string: String?,
                                 font: UIFont?,
                                 color: UIColor,
                                 alignment: NSTextAlignment = .left,
                                 lineBreakMode: NSLineBreakMode = .byWordWrapping,
                                 minimumLineHeight: CGFloat = 0.0,
                                 headIndent: CGFloat = 0.0,
                                 lineSpacing: CGFloat = 0.0,
                                 tabLocation: CGFloat = 0.0,
                                 firstLineHeadIndent: CGFloat = 0.0,
                                 tailIndent: CGFloat = 0.0,
                                 baselineOffset: CGFloat = 0.0) -> NSAttributedString? {
        guard let string = string, let font = font else { return nil }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.minimumLineHeight = minimumLineHeight
        paragraphStyle.headIndent = headIndent
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
        paragraphStyle.tailIndent = tailIndent
        if tabLocation != 0.0 {
            let textTab = NSTextTab(textAlignment: alignment, location: tabLocation, options: [:])
            paragraphStyle.tabStops = [textTab]
        }
        
        var attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: paragraphStyle, .baselineOffset: baselineOffset]
        if minimumLineHeight > 0.0, minimumLineHeight > font.lineHeight {
            attributes[.baselineOffset] = floorf((Float(minimumLineHeight) - Float(font.lineHeight)) * 0.25)
        }
        
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        return attributedString
    }
}
