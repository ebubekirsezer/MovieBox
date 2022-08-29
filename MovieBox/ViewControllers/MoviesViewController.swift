//
//  TestViewController.swift
//  MovieBox
//
//  Created by EbubekirSezer on 29.08.2022.
//

import Foundation
import UIKit
import FirebaseAnalytics

final class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var textFieldSearch: UITextField?
    @IBOutlet private weak var buttonCancel: UIButton?
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var labelInfo: UILabel?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func registerCells() {
        let cell = UINib(nibName: MovieCell.REUSE_ID, bundle: nil)
        tableView?.register(cell, forCellReuseIdentifier: MovieCell.REUSE_ID)
    }
    
    private func setupUI() {
        self.title = UserDefaults.standard.string(forKey: "app_name")
        labelInfo?.isHidden = !movies.isEmpty
        if movies.isEmpty {
            labelInfo?.text = "You need to start searching..."
        }
        buttonCancel?.isHidden = true
        tableView?.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        textFieldSearch?.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        
        registerCells()
    }
    
    private func search(with movieName: String) {
        labelInfo?.isHidden = true
        startActivityIndicator()
        MBNetwork.shared.request(route: .search(by: movieName),
                                 responseModel: SearchResponse.self) { result in
            switch result {
            case .success(let response):
                self.stopActivityIndicator()
                self.movies = response.search ?? []
                self.labelInfo?.isHidden = !self.movies.isEmpty
                self.labelInfo?.text = "There is no movie for \(self.textFieldSearch?.text ?? "")"
                self.tableView?.reloadData()
            case .failure(let error):
                self.stopActivityIndicator()
                self.labelInfo?.isHidden = !self.movies.isEmpty
                self.labelInfo?.text = "\(error)"
                print(error)
            }
        }
    }
    
    private func getMovieDetail(with id: String, onSuccess: @escaping ((Movie?) -> Void), onFailure: @escaping ((Error?) -> Void)) {
        labelInfo?.isHidden = true
        startActivityIndicator()
        
        MBNetwork.shared.request(route: .detail(by: id), responseModel: Movie.self) { result in
            switch result {
            case .success(let response):
                self.stopActivityIndicator()
                onSuccess(response)
            case .failure(let error):
                self.stopActivityIndicator()
                print(error)
                onFailure(error)
            }
        }
    }
    
    private func startActivityIndicator() {
        activityIndicator?.superview?.isHidden = false
        activityIndicator?.startAnimating()
    }

    private func stopActivityIndicator() {
        activityIndicator?.superview?.isHidden = true
        activityIndicator?.stopAnimating()
    }
    
    @IBAction private func buttonCancelTapped(_ sender: UIButton) {
        textFieldSearch?.text = ""
    }
}

extension MoviesViewController: UITextFieldDelegate {
    
    @objc private func searchTextFieldDidChange(_ sender: UITextField) {
        buttonCancel?.isHidden = (textFieldSearch?.text?.isEmpty ?? false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty ?? true) {
            search(with: textField.text ?? "")
        }
        textFieldSearch?.resignFirstResponder()
        return true
    }
    
    func logEvent(with movie: Movie?) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(movie?.imdbID ?? "")",
            AnalyticsParameterItemName: "\(movie?.title ?? "Unknown Movie")",
          AnalyticsParameterContentType: "cont",
        ])
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.REUSE_ID, for: indexPath) as? MovieCell {
            let movie = movies[indexPath.row]
            cell.setupWith(movie: movie)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        logEvent(with: selectedMovie)
        guard let id = selectedMovie.imdbID else { return }

        getMovieDetail(with: id) { movie in
            if let viewController = self.getViewController(viewController: MovieDetailViewController(), from: "Detail") {
                viewController.initiliazeWith(movie: movie)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } onFailure: { _ in }
    }
}
