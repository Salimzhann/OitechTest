//
//  MovieDetailsViewController.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 17.10.2024.
//

import UIKit

final class MovieDetailView: UIViewController {
    
    private let viewModel = MovieDetailViewModel()
    private var movieID: String?
    
    private let titleLabel: UILabel = createLabel(fontWeight: .bold)
    private let yearLabel: UILabel = createLabel(fontWeight: .light)
    private let ratingLabel: UILabel = createLabel(fontWeight: .light)
    private let voteLable: UILabel = createLabel(fontWeight: .light)
    private let genresLabel: UILabel = createLabel(fontWeight: .light)
    private let countriesLabel: UILabel = createLabel(fontWeight: .light)
    private let languageLabel: UILabel = createLabel(fontWeight: .light)
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.text = "Actors:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let starsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(StarsCell.self, forCellWithReuseIdentifier: StarsCell.identifier)
        return collectionView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails()
        configUI()
    }
    
    func config(id: String) {
        self.movieID = id
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        [titleLabel, yearLabel, ratingLabel, voteLable, genresLabel, countriesLabel, languageLabel, starsCollectionView, starsLabel, descriptionLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ratingLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 5),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            voteLable.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            voteLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            genresLabel.topAnchor.constraint(equalTo: voteLable.bottomAnchor, constant: 5),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            countriesLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 5),
            countriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            languageLabel.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 5),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            starsLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            starsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            starsCollectionView.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 5),
            starsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            starsCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: starsCollectionView.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        starsCollectionView.dataSource = self
        starsCollectionView.delegate = self
    }
    
    private func fetchMovieDetails() {
        guard let movieID = movieID else { return }
        
        viewModel.fetchData(id: movieID) { [weak self] movieDetail in
            
            DispatchQueue.main.async {
                if let movieDetail = movieDetail {
                    //Configuration of Data
                    self?.titleLabel.text = movieDetail.title
                    self?.yearLabel.text = "Year: \(movieDetail.year ?? "Unknown")"
                    self?.voteLable.text = "Vote count: \(movieDetail.voteCount ?? "Unknown")"
                    self?.genresLabel.text = "Genres: \(movieDetail.genres?.joined(separator: ", ") ?? "Unknown")"
                    self?.countriesLabel.text = "Countries: \(movieDetail.countries?.joined(separator: ", ") ?? "Unknown")"
                    self?.languageLabel.text = "Language: \(movieDetail.language?.joined(separator: ", ") ?? "Unknown")"
                    self?.descriptionLabel.text = "Description: \(movieDetail.description ?? "Unknown")"
                    
                    //Rating format to %.1f
                    if let ratingString = movieDetail.imdbRating, let ratingValue = Double(ratingString) {
                        self?.ratingLabel.text = String(format: "Rating: %.1f", ratingValue)
                    } else { self?.ratingLabel.text = "Rating: Unknown" }
                    
                } else {
                    print("Something went wrong about Movie Details")
                }
            }
        }
    }
}

extension MovieDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.stars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = starsCollectionView.dequeueReusableCell(withReuseIdentifier: StarsCell.identifier, for: indexPath) as! StarsCell
        cell.config(name: viewModel.stars[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let starName = viewModel.stars[indexPath.item]
        let width = starName.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)]).width + 20
        let height: CGFloat = 30
        
        return CGSize(width: width, height: height)
    }
}

extension MovieDetailView {
    private static func createLabel(fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: fontWeight)
        return label
    }
}
