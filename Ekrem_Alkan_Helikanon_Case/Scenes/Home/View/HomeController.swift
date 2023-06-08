//
//  HomeController.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureViewController()
    
    func reloadData()
}

final class HomeController: UIViewController {
    
    //MARK: - References
    weak var homeCoordinator: HomeCoordinator?
    private let viewModel: HomeViewModel
    private let homeView = HomeView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func configureNavItems() {
        navigationItem.title = "Movie App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "16143E")]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(systemName: "list.bullet"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .init(hex: "16143E")
    }
    
    private func setCollectionDelegates() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
    }
    
    
}

//MARK: - Configure HomeCollectionView
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell else { return UICollectionViewCell() }
        let data = viewModel.movies[indexPath.item]
        cell.configure(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as? HomeCollectionHeaderView else { return UICollectionReusableView() }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let homeCollectionView = homeView.homeCollectionView
        let headerWidth: CGFloat = homeCollectionView.frame.width
        var headerHeight: CGFloat = homeCollectionView.frame.height * 0.5
        if UIScreen.main.bounds.height < 850 {
            headerHeight = homeCollectionView.frame.height * 0.65
        }
        return CGSize(width: headerWidth, height: headerHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let homeCollectionView = homeView.homeCollectionView
        let cellWidth: CGFloat = homeCollectionView.frame.width
        let cellHeight: CGFloat = 200
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

//MARK: - HomeViewInterface
extension HomeController: HomeViewInterface {
    func configureViewController() {
        configureNavItems()
        setCollectionDelegates()
    }
    
    
    func reloadData() {
        homeView.homeCollectionView.reloadData()
    }

    
}


