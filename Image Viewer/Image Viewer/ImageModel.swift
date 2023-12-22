//
//  ImageModel.swift
//  Image Viewer
//
//  Created by Jay Doshi on 2023-11-09.
//

import Foundation


class ImageModel {
    let title: String
    let imageURL: String

    init(title: String, imageURL: String) {
        self.title = title
        self.imageURL = imageURL
    }
}
