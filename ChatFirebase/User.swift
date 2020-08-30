//
//  User.swift
//  ChatFirebase
//
//  Created by Trung Le on 8/30/20.
//  Copyright © 2020 Trung Le The. All rights reserved.
//

import Foundation

struct UserManager {
    let firstName: String
    let lastName: String
    let emailAddress: String
    let sex: Int
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }

    var profilePictureFileName: String {
        //afraz9-gmail-com_profile_picture.png
        return "\(safeEmail)_profile_picture.png"
    }
}
