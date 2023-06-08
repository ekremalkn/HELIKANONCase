//
//  DetailController.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func configureDetails(with details: DetailModel)
}

final class DetailController: UIViewController {

    //MARK: - References
    private let viewModel: DetailViewModel

    //MARK: - Init Methods
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}

//MARK: - DetailViewInterface
extension DetailController: DetailViewInterface {
    func configureDetails(with details: DetailModel) {
        print(details)
    }
    
    
}

