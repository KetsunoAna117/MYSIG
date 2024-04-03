//
//  SIG.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct SIG: Hashable{
    var id: Int
    
    var name: String
    var desc: String
    var picId: Int
    var subscribedUserId: [Int]
    
    var listEventId: [Int]
}
