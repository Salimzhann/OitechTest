//
//  MovieCell.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 17.10.2024.
//

import UIKit

class MovieCell: UITableViewCell {
    static let identifier: String = "MovieCell"
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    let movieYear: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    func setup(title: String, year: String) {
        movieTitle.text = title
        movieYear.text = year
        
        setupUI()
    }
    
    func setupUI() {
        [movieTitle, movieYear].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            movieYear.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5),
            movieYear.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor)
        ])
    }
}
