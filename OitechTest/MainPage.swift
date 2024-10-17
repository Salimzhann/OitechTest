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
        title = "Trend Movies"
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func showMovieDetail(for movie: MovieResult) {
        let alert = UIAlertController(
            title: movie.title,
            message: "Year: \(movie.year)\nIMDb ID: \(movie.imdbID)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true) // Deselect the row after selection
            
            let selectedMovie = viewModel.movies[indexPath.row]
            print("Selected Movie: \(selectedMovie.title)")

            // Navigate to a detailed view or show an alert
            showMovieDetail(for: selectedMovie)
        }
    
}

