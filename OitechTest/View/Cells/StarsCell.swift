//
//  StarsCell.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 18.10.2024.
//

import UIKit

class StarsCell: UICollectionViewCell {
    static let identifier: String = "StarsCell"
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    func config(name: String) {
        starLabel.text = name
        configUI()
    }
    
    func configUI() {
        self.addSubview(starLabel)
        self.backgroundColor = .systemYellow
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            starLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
