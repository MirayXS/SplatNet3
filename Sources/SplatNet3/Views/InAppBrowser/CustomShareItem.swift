//
//  CustomShareItem.swift
//  
//
//  Created by devonly on 2023/03/09.
//

import Foundation
import LinkPresentation

class CustomShareItem: NSObject, UIActivityItemSource {
    private let metadata: LPLinkMetadata = LPLinkMetadata()

    init(content: ShareURL) {
        self.metadata.title = "Salmonia3+"
    }

    init(content: ShareImg) {
        self.metadata.title = "Salmonia3+"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return activityViewControllerPlaceholderItem(activityViewController)
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return metadata
    }
}
