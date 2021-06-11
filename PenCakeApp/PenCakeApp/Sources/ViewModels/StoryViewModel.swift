//
//  StoryHeaderView.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/01.
//

import UIKit

protocol StoryViewModelDelegate {
    func changedStory(story: Story)
}

class StoryViewModel {
    // MARK: - property
    var story: Story? {
        willSet(newStory) {
            guard let story = newStory else { return }

            storyDelegate?.changedStory(story: story)
        }
    }

    // MARK: - delegate
    var storyDelegate: StoryViewModelDelegate?
}
