//
//  WritingViewModel.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/10.
//

import Foundation

protocol writingViewModelDelegate {
    func didChangedWriting(writing: Writing)
}

class WritingViewModel {
    // MARK: - property
    var writing: Writing? {
        willSet(newWriting) {
            guard let writing = newWriting else { return }

            writingDelegate?.didChangedWriting(writing: writing)
        }
    }

    // MARK: - delegate
    var writingDelegate: writingViewModelDelegate?
}
