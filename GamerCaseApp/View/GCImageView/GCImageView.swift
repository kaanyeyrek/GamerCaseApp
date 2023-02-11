//
//  GCImageView.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/10/23.
//

import UIKit

class GCImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
      }
    convenience init() {
        self.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
    private func configure() {
        contentMode = .scaleToFill
    }
}
