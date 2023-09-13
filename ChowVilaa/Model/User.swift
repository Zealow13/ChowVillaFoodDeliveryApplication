//
//  User.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
  @DocumentID var id: String?
    var username: String
    var userBio: String
    var userBioLink: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case userBio
        case userBioLink
        case userUID
        case userEmail
        case userProfileURL
    }
}
