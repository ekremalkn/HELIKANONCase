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
    func openDetailVC(with movieID: String)
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "120E4A")]
        navigationController?.navigationBar.barTintColor = .init(hex: "FFFFFF")
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(systemName: "list.bullet"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .init(hex: "16143E")
    }
    
    private func setCollectionDelegates() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
    }
    
    
}

//MARK: - Configure HomeCollectionView
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell else { return UICollectionViewCell() }
        let data = viewModel.movies[indexPath.item]
        cell.configure(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as? HomeCollectionHeaderView else { return UICollectionReusableView() }
            header.delegate = self
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeCollectionFooterView.identifier, for: indexPath) as? HomeCollectionFooterView else { return UICollectionReusableView() }
            return footer
        }
        return UICollectionReusableView()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let homeCollectionView = homeView.homeCollectionView
        let footerWidth: CGFloat = homeCollectionView.frame.width
        let footerHeight: CGFloat = 100
        
        return CGSize(width: footerWidth, height: footerHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let homeCollectionView = homeView.homeCollectionView
        let cellWidth: CGFloat = homeCollectionView.frame.width
        let cellHeight: CGFloat = 200
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let collectionViewContentPosition = scrollView.contentOffset.y
        let collectionBottomPosition = homeView.homeCollectionView.contentSize.height - scrollView.frame.size.height
        
        if viewModel.isPaginating {
            return
        }
        (collectionViewContentPosition > collectionBottomPosition) ? viewModel.didScrollToEnd() : nil
    }
    
}

//MARK: - HomeViewInterface
extension HomeController: HomeViewInterface {
    func configureViewController() {
        configureNavItems()
        setCollectionDelegates()
    }
    
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            homeView.homeCollectionView.reloadData()
        }
    }
    
    func openDetailVC(with movieID: String) {
        homeCoordinator?.openDetail(movieID)
    }
    
    
}

//MARK: - HomeHeaderButtonInterface
extension HomeController: HomeCollectionHeaderButtonInterface {
    func didSelectHeaderCollectionItem(with movieID: String) {
        homeCoordinator?.openDetail(movieID)
    }
}



