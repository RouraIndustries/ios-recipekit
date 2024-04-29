//
//  ImageDimension.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import UIKit

enum ImageDimension {
    case square, banner

    var placeholderImage: UIImage {
        switch self {
        case .square: return PlaceholderImage.square
        case .banner: return PlaceholderImage.banner
        }
    }
}
