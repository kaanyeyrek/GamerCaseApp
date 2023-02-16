//
//  GCButton.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/15/23.
//

import UIKit

class GCButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(title: String?, setTitleColors: UIColor?, fontName: String?, fontSize: CGFloat) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(setTitleColors, for: .normal)
        titleLabel?.font = UIFont(name: fontName!, size: fontSize)
        contentHorizontalAlignment = .left
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
