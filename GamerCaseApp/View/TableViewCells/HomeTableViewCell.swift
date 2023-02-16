//
//  HomeTableViewCell.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/10/23.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class HomeTableViewCell: UITableViewCell {
    //MARK: - Cell Elements
    private let gameImage = GCImageView()
    private let gameLabel = GCLabel(alignment: .left, name: Fonts.boldProDisplay, size: 20, setTextColor: .black)
    private let metacriticLabel = GCLabel(alignment: .left, name: Fonts.mediumProDisplay, size: 14, setTextColor: UIColor(hex: Color.black))
    private let metacriticCount = GCLabel(alignment: .left, name: Fonts.boldProDisplay, size: 18, setTextColor: UIColor(hex: Color.red))
    private let genreLabel = GCLabel(alignment: .left, name: Fonts.regularProText, size: 13, setTextColor: UIColor(hex: Color.genre))
    private var id: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubviews() {
        [gameImage, gameLabel, metacriticLabel, metacriticCount, genreLabel].forEach { elements in
            self.addSubview(elements)
        }
    }
    private func setLayout() {
        gameImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 0), size: .init(width: 120, height: 104))
        gameImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        gameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 16, left: 150, bottom: 110, right: 10), size: .init(width: 207, height: 50))
        
        metacriticLabel.anchor(top: gameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 150, bottom: 40, right: 0), size: .init(width: 71, height: 16))
        
        metacriticCount.anchor(top: gameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 223, bottom: 40, right: 0), size: .init(width: 26, height: 20))
        
        genreLabel.anchor(top: metacriticLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 150, bottom: 15, right: 0), size: .init(width: 207, height: 16))
    }
    // based components
    func setID(model: HomePresentation) {
        self.id = model.id
    }
    func setImage(model: HomePresentation) {
        // download url
        if let imageURL = model.background_image {
            gameImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            gameImage.sd_imageTransition = .fade
            gameImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: Icon.placeHolder))
        }
    }
    func setGameLabel(model: HomePresentation) {
        gameLabel.text = model.title
        gameLabel.addCharactersSpacing(spacing: 0.38, text: gameLabel.text!)
    }
    func setMetacriticLabel() {
        metacriticLabel.text = "metacritic:"
        metacriticLabel.addCharactersSpacing(spacing: 0.38, text: metacriticLabel.text!)
    }
    func setMetacriticCount(model: HomePresentation) {
        metacriticCount.text = "\(model.metacritic)"
        metacriticCount.addCharactersSpacing(spacing: 0.88, text: metacriticCount.text!)
    }
    func setGenres(model: HomePresentation) {
        genreLabel.text = model.genreName.joined(separator: ", ").lowercased().capitalizingFirstLetter()
        genreLabel.addCharactersSpacing(spacing: -0.08, text: genreLabel.text!)
    }
    // filtered components
    func setGameLabelFilter(model: filterPresentation) {
        gameLabel.text = model.title
        gameLabel.addCharactersSpacing(spacing: 0.38, text: gameLabel.text!)
    }
    func setGameImageFilter(model: filterPresentation) {
        if let imageURL = model.background_image {
            gameImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            gameImage.sd_imageTransition = .fade
            gameImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: Icon.placeHolder))
        }
    }
    func setMetacriticLabelFilter() {
        metacriticLabel.text = "metacritic:"
        metacriticLabel.addCharactersSpacing(spacing: 0.38, text: metacriticLabel.text!)
    }
    func setMetacriticCountFilter(model: filterPresentation) {
        metacriticCount.text = "\(model.metacritic ?? 0)"
        metacriticCount.addCharactersSpacing(spacing: 0.88, text: metacriticCount.text!)
    }
}
