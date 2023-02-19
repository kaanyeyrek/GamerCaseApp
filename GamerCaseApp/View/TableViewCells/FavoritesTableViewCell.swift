//
//  FavoritesTableViewCell.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/18/23.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class FavoritesTableViewCell: UITableViewCell {
    //MARK: - Cell Elements
    private let gameImage = GCImageView()
    private let gameLabel = GCLabel(alignment: .left, name: Fonts.boldProDisplay, size: 20, setTextColor: .black)
    private let metacriticLabel = GCLabel(alignment: .left, name: Fonts.mediumProDisplay, size: 14, setTextColor: UIColor(hex: Color.black))
    private let metacriticCount = GCLabel(alignment: .left, name: Fonts.boldProDisplay, size: 18, setTextColor: UIColor(hex: Color.red))
    private let genreLabel = GCLabel(alignment: .left, name: Fonts.regularProText, size: 13, setTextColor: UIColor(hex: Color.genre))
    
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
        gameImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 20, left: 16, bottom: 20, right: 0), size: .init(width: 120, height: 104))
        gameImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        gameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 16, left: 150, bottom: 115, right: 10), size: .init(width: 207, height: 50))
        
        metacriticLabel.anchor(top: gameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 150, bottom: 45, right: 0), size: .init(width: 71, height: 16))
        
        metacriticCount.anchor(top: gameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 220, bottom: 44, right: 0), size: .init(width: 26, height: 20))
        
        genreLabel.anchor(top: metacriticLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 150, bottom: 20, right: 0), size: .init(width: 207, height: 16))
    }
//MARK: - Favorites vc cell configure
    func setFavoritesImage(presentation: Games) {
        if let imageURL = presentation.image {
            gameImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            gameImage.sd_imageTransition = .fade
            gameImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: Icon.placeHolder))
        }
    }
    func setFavoritesGameLabel(presentation: Games) {
        gameLabel.text = presentation.name
        gameLabel.addCharactersSpacing(spacing: 0.38, text: gameLabel.text!)
    }
    func setFavoritesMetacriticLabel() {
        metacriticLabel.text = "metacritic:"
        metacriticLabel.addCharactersSpacing(spacing: 0.38, text: metacriticLabel.text!)
    }
    func setMetacriticCount(presentation: Games) {
        metacriticCount.text = "\(presentation.metacritic)"
        metacriticCount.addCharactersSpacing(spacing: 0.88, text: metacriticCount.text!)
    }
    func setGenres(presentation: Games) {
        guard let genreArray = presentation.genre as? [String] else { return }
        genreLabel.text = genreArray.joined(separator: ", ").lowercased().capitalizingFirstLetter()
        genreLabel.addCharactersSpacing(spacing: -0.08, text: genreLabel.text!)
    }
}
