//
//  DetailsUITableViewCell.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/14/23.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class DetailsUITableViewCell: UITableViewCell {

    private let gradientLayer = CAGradientLayer()
    private let detailImage = GCImageView()
    private let gameLabel = GCLabel(alignment: .right, name: Fonts.boldProDisplay, size: 36, setTextColor: UIColor(hex: Color.white))
    private let descriptionHeader = GCLabel(alignment: .left, name: Fonts.regularProText, size: 20, setTextColor: UIColor(hex: Color.detailColor))
    private let detailDescription = GCLabel(alignment: .left, name: Fonts.regularProText, size: 13, setTextColor: UIColor(hex: Color.detailColor))
    public let visitRedditButton = GCButton(title: "Visit reddit", setTitleColors: UIColor(hex: Color.detailColor), fontName: Fonts.regularProText, fontSize: 20)
    private let visitWebsiteButton = GCButton(title: "Visit website", setTitleColors: UIColor(hex: Color.detailColor), fontName: Fonts.regularProText, fontSize: 20)
    private let gradientView = UIView()
    private let seperatorView = UIView()
    private let seperatorView2st = UIView()
    private let seperatorView3st = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }
    // gradient game label
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        let colorSet = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0),
                        UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)]
        let location = [0.5, 0.1]
        gradientView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        detailImage.image = nil
        gameLabel.text = ""
        descriptionHeader.text = ""
        detailDescription.text = ""
        visitRedditButton.backgroundColor = nil
        visitWebsiteButton.backgroundColor = nil
        seperatorView.backgroundColor = nil
        seperatorView2st.backgroundColor = nil
        seperatorView3st.backgroundColor = nil
    }
    private func setSubviews() {
        [detailImage, gameLabel, gradientView, descriptionHeader, detailDescription, visitRedditButton, visitWebsiteButton, seperatorView, seperatorView2st, seperatorView3st].forEach { elements in
            contentView.addSubview(elements)
        }
    }
    // layout etc.
    private func setLayout() {
        detailImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: 375, height: 291))
        contentView.sendSubviewToBack(detailImage)
        
        gameLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 20), size: .init(width: 343, height: 100))
        gameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 195).isActive = true
        contentView.bringSubviewToFront(gameLabel)
        
        gradientView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 375, height: 170))
        gradientView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 155).isActive = true
      
    
        descriptionHeader.anchor(top: detailImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 0), size: .init(width: 343, height: 43))
        descriptionHeader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 270).isActive = true
        
        detailDescription.anchor(top: descriptionHeader.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 5, left: 16, bottom: 0, right: 16), size: .init(width: 343, height: 105))
        detailDescription.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 340).isActive = true
        
        visitRedditButton.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 260), size: .init(width: 343, height: 22))
        visitRedditButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 440).isActive = true
        visitRedditButton.titleLabel?.addCharactersSpacing(spacing: -0.41, text: (visitRedditButton.titleLabel?.text)!)
        
        visitWebsiteButton.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 260), size: .init(width: 343, height: 22))
        visitWebsiteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 510).isActive = true
        visitWebsiteButton.titleLabel?.addCharactersSpacing(spacing: -0.41, text: (visitWebsiteButton.titleLabel?.text)!)
        visitWebsiteButton.addTarget(contentView, action: #selector(didtapped), for: .touchUpInside)
        
        seperatorView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: contentView.frame.width, height: 1))
        seperatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 410).isActive = true
        seperatorView.layer.borderColor = UIColor.lightGray.cgColor
        seperatorView.layer.borderWidth = 1
        
        seperatorView2st.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: contentView.frame.width, height: 1))
        seperatorView2st.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 475).isActive = true
        seperatorView2st.layer.borderColor = UIColor.lightGray.cgColor
        seperatorView2st.layer.borderWidth = 1
        
        seperatorView3st.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: contentView.frame.width, height: 1))
        seperatorView3st.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 540).isActive = true
        seperatorView3st.layer.borderColor = UIColor.lightGray.cgColor
        seperatorView3st.layer.borderWidth = 1
    }
    @objc func didtapped() {
        print("TAPPPEEDDDDD")
    }
    //config cell model attributes
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
    func setDescriptionHeader() {
        descriptionHeader.text = "Game Description"
        descriptionHeader.addCharactersSpacing(spacing: -0.41, text: descriptionHeader.text!)
    }
    func setDetailDescription(model: HomeDetailPresentation) {
        detailDescription.text = model.description.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        detailDescription.addCharactersSpacing(spacing: -0.41, text: detailDescription.text!)
        detailDescription.setLineSpacing(lineSpacing: 10)
    }
}
