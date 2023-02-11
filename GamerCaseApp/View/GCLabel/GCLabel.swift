//
//  GCLabel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/10/23.
//

import UIKit

class GCLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    // Helper
    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude),
                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                    attributes: [NSAttributedString.Key.font: font!],
                                                                    context: nil).size
            super.drawText(in: CGRect(x:0,y: 0, width: self.frame.width, height: ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    // init ex
    convenience init(alignment: NSTextAlignment, name: String, size: CGFloat, setTextColor: UIColor?) {
        self.init(frame: .zero)
        textAlignment = alignment
        font = UIFont(name: name, size: size)
        textColor = setTextColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.9
    }
}
