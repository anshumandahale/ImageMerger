//
//  MergeImagesViewModel.swift
//  ImageMerger
//
//  Created by Anshuman Dahale on 16/11/22.
//

import Foundation
import UIKit

protocol MergeImagesViewModelProtocol {
    var images: [UIImage]? { get }
    var delegate: MergeImagesOutput? { get set }
    func userSelectedImage(image: UIImage)
    func mergeButtonClicked()
}

protocol MergeImagesOutput {
    func mergedImage(image: UIImage)
    func showError(title: String, message: String)
}

class MergeImagesViewModel: MergeImagesViewModelProtocol {
    var delegate: MergeImagesOutput?
    var images: [UIImage]?
    
    func userSelectedImage(image: UIImage) {
        print(#function)
        if images == nil {
            images = [UIImage]()
        }
        images?.append(image)
    }
    
    /// This function will merge all images into one
    func mergeButtonClicked() {
        print(#function)
        guard let images = images else {
            delegate?.showError(title: "Empty", message: "Please select some images to merge")
            return
        }
        guard images.count > 1 else {
            delegate?.showError(title: "Insufficient", message: "Please select more than one image to merge")
            return
        }
        mergeImagesIntoOne(arr: images)
    }
    
    
    /// This will be the core function which will merge all the images and convert 1 image
    /// - Parameter arr: Array of Images
    private func mergeImagesIntoOne(arr: [UIImage]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.delegate?.mergedImage(image: UIImage(named: "1")!)
        })
    }
}
