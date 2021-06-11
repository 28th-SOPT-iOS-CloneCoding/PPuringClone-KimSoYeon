//
//  WritingViewModel.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/10.
//

import Foundation

protocol writingViewModelDelegate {
    func changedWriting(writing: Writing)
}

class WritingViewModel {
    // MARK: - property
    var writing: Writing? {
        willSet(newWriting) {
            guard let writing = newWriting else { return }

            writingDelegate?.changedWriting(writing: writing)
        }
    }

    // MARK: - delegate
    var writingDelegate: writingViewModelDelegate?
}
