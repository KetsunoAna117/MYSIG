//
//  User.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct User: Hashable {
    var id: Int
    
    var email: String
    var password: String
    
    var name: String
    var phoneNumber: String
    var cohort: Int
    var session: String
    
    var joinedSigId: [Int]
    var bookedEventId: [Int]
    var notificationId: [Int]
}
