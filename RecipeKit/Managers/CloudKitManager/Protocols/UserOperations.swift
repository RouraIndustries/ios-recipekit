//
//  UserOperations.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/25/24.
//

import CloudKit

protocol UserOperations {
    func getUserRecord() async throws
}
