//
//  HomeDetailViewController.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import UIKit
import SDWebImage
import SafariServices

protocol HomeDetailViewInterface: AnyObject {
    func setUI()
    func handleOutput(output: HomeDetailOutput)
    func setSubviews()
    func setLayout()
    func changeLoading(isLoad: Bool)
    func showWebsite(url: String)
    func configureUI()
    func setGradientLayer()
    func setTextFeatures()
    func setTargets()
    func setBarButton()
}

@available(iOS 13.0, *)
final class HomeDetailViewController: UIViewController {
//MARK: - Injections
    private var viewModel: HomeDetailViewModelInterface
//MARK: - Global UI Elements
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var gameImage = GCImageView()
    private let gradientLayer = CAGradientLayer()
    private let gradientView = UIView()
    private let gameLabel = GCLabel(alignment: .right, name: Fonts.boldProDisplay, size: 36, setTextColor: UIColor(hex: Color.white))
    private let gameHeaderDescription = GCLabel(alignment: .left, name: Fonts.regularProText, size: 17, setTextColor: UIColor(hex:Color.detailColor))
    private let gameDescription = GCLabel(alignment: .left, name: Fonts.regularProText, size: 12, setTextColor: UIColor(hex: Color.detailColor))
    private let seperator1stView = UIView()
    private let visitRedditButton = GCButton(title: "Visit reddit", setTitleColors: UIColor(hex: Color.detailColor), fontName: Fonts.regularProText, fontSize: 17)
    private let seperator2stView = UIView()
    private let visitWebsiteButton = GCButton(title: "Visit website", setTitleColors: UIColor(hex: Color.detailColor), fontName: Fonts.regularProText, fontSize: 17)
    private let seperator3stView = UIView()
    private let readMoreButton = GCButton(title: "Read More", setTitleColors: .systemBlue, fontName: Fonts.regularProText, fontSize: 10)
    private let barButton = UIButton(type: .system)
// init
    init(viewModel: HomeDetailViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        viewModel.setData()
    }
    //MARK: - @objc button actions
    @objc private func didTappedVisitRedditButton() {
        self.showWebsite(url: (viewModel.games?.reddit_url)!)
    }
    @objc private func didTappedVisitWebsiteButton() {
        self.showWebsite(url: (viewModel.games?.website)!)
    }
    @objc private func didTappedReadMoreButton() {
        if gameDescription.numberOfLines == 0 {
            gameDescription.numberOfLines = 4
            readMoreButton.setTitle("Read More", for: .normal)
        } else {
            readMoreButton.setTitle("Read Less", for: .normal)
            gameDescription.numberOfLines = 0
        }
    }
    @objc private func didTappedBarButtonItem() {
        barButton.isSelected.toggle()
    }
}
//MARK: - HomeDetailInterface Methods
@available(iOS 13.0, *)
extension HomeDetailViewController: HomeDetailViewInterface {
    func setUI() {
        view.backgroundColor = UIColor(hex: Color.white)
    }
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    func handleOutput(output: HomeDetailOutput) {
        switch output {
        case .failedUpdateData(let message, let title):
            print(message, title)
        }
    }
    func setSubviews() {
        [indicator, gameImage, gradientView, gameLabel, gameHeaderDescription, gameDescription, seperator1stView, visitRedditButton, seperator2stView, visitWebsiteButton, seperator3stView, readMoreButton].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setTargets() {
        visitRedditButton.addTarget(self, action: #selector(didTappedVisitRedditButton), for: .touchUpInside)
        visitWebsiteButton.addTarget(self, action: #selector(didTappedVisitWebsiteButton), for: .touchUpInside)
        readMoreButton.addTarget(self, action: #selector(didTappedReadMoreButton), for: .touchUpInside)
    }
    func setBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)
        barButton.setTitle("Favorited", for: .normal)
        barButton.setTitle("Favorite", for: .selected)
        barButton.addTarget(self, action: #selector(didTappedBarButtonItem), for: .touchUpInside)
        
    }
    func setLayout() {
        indicator.startAnimating()
        indicator.centerInSuperView(size: .init(width: 250, height: 250))
        
        gameImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 375, height: 291))
        gameImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -220).isActive = true
        
        gradientView.anchor(top: gameImage.topAnchor, leading: gameImage.leadingAnchor, bottom: gameImage.bottomAnchor, trailing: gameImage.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 375, height: 192))
        
        gameLabel.anchor(top: gameImage.topAnchor, leading: gameImage.leadingAnchor, bottom: gameImage.bottomAnchor, trailing: gameImage.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 10, right: 16), size: .init(width: 343, height: 80))
        
        gameHeaderDescription.anchor(top: gameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 9), size: .init(width: 343, height: 21))
        gameHeaderDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        
      
        gameDescription.anchor(top: gameHeaderDescription.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 343, height: 21))
        gameDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        
        seperator1stView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 200, height: 1))
        seperator1stView.backgroundColor = .lightGray
        seperator1stView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 95).isActive = true
        
        visitRedditButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 343, height: 22))
        visitRedditButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 125).isActive = true
        
        seperator2stView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 200, height: 1))
        seperator2stView.backgroundColor = .lightGray
        seperator2stView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 155).isActive = true
        
        visitWebsiteButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 343, height: 22))
        visitWebsiteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 185).isActive = true
        
        seperator3stView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 200, height: 1))
        seperator3stView.backgroundColor = .lightGray
        seperator3stView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 215).isActive = true
        
        readMoreButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        readMoreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 72).isActive = true
    
    }
    func setTextFeatures() {
        gameLabel.addCharactersSpacing(spacing: 0.38, text: gameLabel.text!)
        gameLabel.numberOfLines = 2
        gameHeaderDescription.text = "Game Description"
        
        gameDescription.addCharactersSpacing(spacing: -0.41, text: gameDescription.text!)
        gameDescription.setLineSpacing(lineSpacing: 10)
        gameDescription.numberOfLines = 4
        gameDescription.lineBreakMode = .byTruncatingTail
        
        visitRedditButton.titleLabel?.addCharactersSpacing(spacing: -0.41, text: (visitRedditButton.titleLabel?.text!)!)
        visitWebsiteButton.titleLabel?.addCharactersSpacing(spacing: -0.41, text: (visitWebsiteButton.titleLabel?.text!)!)
        readMoreButton.titleLabel?.addCharactersSpacing(spacing: -0.41, text: (readMoreButton.titleLabel?.text!)!)
    }
    func showWebsite(url: String) {
        guard let url = URL(string: url) else { return }

        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: configuration)
        vc.preferredControlTintColor = .label
        present(vc, animated: true)
    }
    func setGradientLayer() {
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
                                UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                                ]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.0)
            gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
    func configureUI() {
        guard let games = viewModel.games else { return }
        gameImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
        gameImage.sd_imageTransition = .fade
        gameImage.sd_setImage(with: URL(string: games.background_image!), placeholderImage: UIImage(systemName: Icon.placeHolder))
        gameLabel.text = games.name_original
        gameDescription.text = games.description!.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil).replacingOccurrences(of: "#" , with: "").replacingOccurrences(of: "&", with: "", options: String.CompareOptions.regularExpression).replacingOccurrences(of: "39", with: "", options: String.CompareOptions.regularExpression).replacingOccurrences(of: ";", with: "", options: String.CompareOptions.regularExpression)
        self.setTextFeatures()
    }
}


