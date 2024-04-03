//
//  Notification.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct SIGNotification: Hashable {
    var id: Int
    
    var title: String
    var content: String
    var date: Date
}
