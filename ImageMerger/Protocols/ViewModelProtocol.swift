//
//  ViewModelProtocol.swift
//  ImageMerger
//
//  Created by Anshuman Dahale on 16/11/22.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    
    func bind(input: Input)
}
