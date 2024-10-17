//
//  ViewController.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 17.10.2024.
//

import UIKit

class MainPage: UIViewController {
    
    let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let viewModel = MainPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchTrendingMovies()
    }

    func setupUI() {
        
    }

}

