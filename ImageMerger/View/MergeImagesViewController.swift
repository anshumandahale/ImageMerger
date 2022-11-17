//
//  MergeImagesViewController.swift
//  ImageMerger
//
//  Created by Anshuman Dahale on 16/11/22.
//

import UIKit

class MergeImagesViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    private var viewModel: MergeImagesViewModelProtocol
    lazy private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    init(nibName: String, viewModel: MergeImagesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: Bundle.main)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func uploadClicked(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {
                self.showError(title: "Error", message: "Source unavailable")
                return
            }
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        })
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self.showError(title: "Error", message: "Source unavailable")
                return
            }
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            actionSheet.dismiss(animated: true)
        })
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true)
    }
    
    @IBAction func mergeClicked(_ sender: Any) {
        viewModel.mergeButtonClicked()
    }
}

extension MergeImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            self.showError(title: "Error", message: "Corrupted Media")
            return
        }
        picker.dismiss(animated: true)
        self.viewModel.userSelectedImage(image: image)
    }
}

extension MergeImagesViewController: MergeImagesOutput {
    func mergedImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func showError(title: String, message: String) {
        let errorAlert =
        UIAlertController(title: title,
                          message: message,
                          preferredStyle: .alert)
        let okAction =
        UIAlertAction(title: "OK",
                      style: .default,
                      handler: { _ in
            errorAlert.dismiss(animated: true)
            
        })
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
}
