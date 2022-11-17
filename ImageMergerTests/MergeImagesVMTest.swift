//
//  MergeImagesVMTest.swift
//  ImageMergerTests
//
//  Created by Anshuman Dahale on 17/11/22.
//

import XCTest
@testable import ImageMerger

final class MergeImagesVMTest: XCTestCase, MergeImagesOutput {
    
    var vm: MergeImagesViewModelProtocol = MergeImagesViewModel()
    
    var mergedImage: UIImage?
    var errorTitle: String?
    
    func mergedImage(image: UIImage) {
        self.mergedImage = image
    }
    
    func showError(title: String, message: String) {
        self.errorTitle = title
    }
    
    func testWhenNoImageIsSelectedErrorCondition() {
        //Check that initial value is nil
        XCTAssertNil(self.errorTitle)
        vm.mergeButtonClicked()
        XCTAssertEqual(errorTitle, "Empty")
    }
    
    func testSingleImageSelectionErrorCondition() {
        XCTAssertNil(self.errorTitle)
        vm.userSelectedImage(image: UIImage())
        vm.mergeButtonClicked()
        XCTAssertEqual(errorTitle, "Insufficient")
    }
    
    func testThatWeGetSingleMergedImageForOurImages() {
        //Check that initial value is nil
        XCTAssertNil(mergedImage)
        let expectation = expectation(description: "recievedMergedImage")
        
        vm.userSelectedImage(image: UIImage(named: "1")!)
        vm.userSelectedImage(image: UIImage(named: "1")!)
        vm.userSelectedImage(image: UIImage(named: "1")!)
        
        vm.mergeButtonClicked()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertNotNil(mergedImage)
    }
    
    override func setUp() async throws {
        vm.delegate = self
    }
}
