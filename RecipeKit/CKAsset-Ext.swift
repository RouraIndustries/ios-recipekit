//
//  CKAsset-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholderImage = dimension.placeholderImage

        guard let fileURL else { return placeholderImage }

        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholderImage
        } catch {
            return placeholderImage
        }
    }
}
