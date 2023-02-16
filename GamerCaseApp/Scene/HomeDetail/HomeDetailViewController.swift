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
    func setTableView()
    func reloadTable()
    func showWebsite(url: String)
}

@available(iOS 13.0, *)
final class HomeDetailViewController: UIViewController {
//MARK: - Injections
    private var viewModel: HomeDetailViewModelInterface!
//MARK: - Global UI Elements
    private let table = UITableView()
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
//MARK: - UI Components
    private var detailPresentation = [HomeDetailPresentation]()

    init(viewModel: HomeDetailViewModelInterface!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
//MARK: - HomeDetailInterface Methods
@available(iOS 13.0, *)
extension HomeDetailViewController: HomeDetailViewInterface {
    func setUI() {
        view.backgroundColor = UIColor(hex: Color.searchBackground)
    }
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    func handleOutput(output: HomeDetailOutput) {
        switch output {
        case .loadPresentation(let presentation):
            self.detailPresentation = presentation
            self.reloadTable()
        case .failedUpdateData(let message, let title):
            print(message, title)
        case .empty(let message):
            self.showEmptyStateView(with: message, at: self.view)
        case .removeEmpty:
            self.removeEmptyStateView()
        }
    }
    func setSubviews() {
        [indicator, table].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setLayout() {
        table.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: view.frame.size.width, height: view.frame.size.height))
        table.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        indicator.startAnimating()
        indicator.centerInSuperView(size: .init(width: 250, height: 250))
    }
    func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(DetailsUITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.detailsCell)
        table.keyboardDismissMode = .interactive
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.allowsSelectionDuringEditing = true
    }
    func reloadTable() {
        table.reloadData()
    }
    func showWebsite(url: String) {
        guard let url = URL(string: url) else { return }

        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: configuration)
        vc.preferredControlTintColor = .label
        present(vc, animated: true)
    }
}
@available(iOS 13.0, *)
//MARK: - UITableViewDataSource Methods
extension HomeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailPresentation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.detailsCell, for: indexPath) as? DetailsUITableViewCell else { return UITableViewCell() }
        let model = detailPresentation[indexPath.row]
        cell.setDetailImageConfig(model: model)
        cell.setGameLabelConfig(model: model)
        cell.setDescriptionHeader()
        cell.setDetailDescription(model: model)
        return cell
    }
}
//MARK: - UITableViewDelegate Methods
@available(iOS 13.0, *)
extension HomeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        tableView.deselectRow(at: indexPath, animated: true)
            let model = detailPresentation[indexPath.row]
            let url = model.reddit_url
            self.showWebsite(url: url)
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(100)
    }
}
