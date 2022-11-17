//
//  AppCoordinator.swift
//  ImageMerger
//
//  Created by Anshuman Dahale on 16/11/22.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol {
    //Any navigations from the MergeImagesViewController will be mentioned here
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mergeImageVM = MergeImagesViewModel()
        let mergeImagesVC = MergeImagesViewController(nibName: "MergeImagesViewController",
                                                      viewModel: mergeImageVM)
        self.navigationController.pushViewController(mergeImagesVC, animated: true)
    }
}
