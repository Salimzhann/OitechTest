//
//  ViewController.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 17.10.2024.
//

import UIKit

class MainPage: UIViewController {
    
    let moviesTableView: UITableView = {
        let tv = UITableView()
        tv.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tv
    }()
    
    private let viewModel = MainPageViewModel()
    private var movies: [MovieResult] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchTrendingMovies { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        [moviesTableView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func setupTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }

}


extension MainPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.setup(title: viewModel.movies[indexPath.item].title, year: viewModel.movies[indexPath.item].year)
        return cell
    }
}

