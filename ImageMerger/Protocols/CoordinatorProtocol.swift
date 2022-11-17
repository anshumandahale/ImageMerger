//
//  CoordinatorProtocol.swift
//  ImageMerger
//
//  Created by Anshuman Dahale on 16/11/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator]? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
