//
//  UIImage-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import CloudKit
import UIKit

extension UIImage {
    func convertToCKAsset() -> CKAsset? {
        let fileURL = URL.documentsDirectory.appending(path: "selectedAvatarImage")
        let imageData = jpegData(compressionQuality: 0.35)

        do {
            try imageData?.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            return nil
        }
    }
}
