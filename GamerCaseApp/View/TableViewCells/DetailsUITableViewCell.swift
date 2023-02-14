//
//  DetailsUITableViewCell.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/14/23.
//

import UIKit
import SDWebImage

class DetailsUITableViewCell: UITableViewCell {

    private let gradientLayer = CAGradientLayer()
    private let detailImage = GCImageView()
    private let gameLabel = GCLabel(alignment: .right, name: Fonts.boldProDisplay, size: 36, setTextColor: UIColor(hex: Color.white))
    private let gradientView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }
    // gradient game label
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = self.bounds
        let colorSet = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0),
                        UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)]
        let location = [0.5, 0.1]
        gradientView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubviews() {
        [detailImage, gameLabel, gradientView].forEach { elements in
            self.addSubview(elements)
        }
    }
    private func setLayout() {
        detailImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, size: .init(width: 375, height: 291))
        detailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        self.sendSubviewToBack(detailImage)
        
        gameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 20), size: .init(width: 343, height: 43))
        gameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 155).isActive = true
        
        gradientView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 375, height: 150))
        gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 120).isActive = true
        self.bringSubviewToFront(gameLabel)
    }
    func setDetailImageConfig(model: HomeDetailPresentation) {
        if let imageURL = model.background_image {
            detailImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            detailImage.sd_imageTransition = .fade
            detailImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: Icon.placeHolder))
        }
    }
    func setGameLabelConfig(model: HomeDetailPresentation) {
        gameLabel.text = model.name_original
        gameLabel.addCharactersSpacing(spacing: 0.38, text: gameLabel.text!)
    }
    func configureCell(model: HomeDetailPresentation) {
           let colorSet = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0),
                           UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]
           let location = [0.2, 1.5]
           self.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
       }
}
