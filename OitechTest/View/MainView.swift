//
//  ViewController.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 17.10.2024.
//

import UIKit

final class MainView: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupTableView()
        fetchingData()
    }
    
    private func configUI() {
        title = "Trend Movies"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchingData() {
        viewModel.fetchTrendingMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.config(title: viewModel.movies[indexPath.item].title, year: viewModel.movies[indexPath.item].year)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.row]
        let movieDetailVC = MovieDetailView()
        movieDetailVC.config(id: selectedMovie.imdbID) 
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}

