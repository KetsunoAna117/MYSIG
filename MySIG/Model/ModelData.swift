//
//  ModelData.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

class AppDataStore: ObservableObject {
    @Published var currentActiveUser: User?
    
    @Published var users: [User]
    @Published var sigs: [SIG]
    @Published var events: [EventSIG]
    @Published var notifications: [SIGNotification]

    init() {
        self.currentActiveUser = nil
        self.users = Data().users
        self.sigs = Data().sigs
        self.events = Data().events
        self.notifications = Data().notification
    }
}


struct Data {
    var users: [User] = [
        User(id: 1,
             email: "Johndoe@mail.id",
             password: "abc",
             name: "John Doe",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [1, 2],
             notificationId: [1]
        ),
        User(id: 2,
             email: "jamesrc@mail.id",
             password: "123",
             name: "James RC",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [],
             notificationId: []
        ),
        User(id: 3,
             email: "dea@mail.id",
             password: "123",
             name: "Dea",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [],
             notificationId: []
        ),
        User(id: 4,
             email: "johan@mail.id",
             password: "123",
             name: "Johan",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [],
             notificationId: []
        )
    ]
    
    var sigs: [SIG] = []
    var events: [EventSIG] = []
    var notification: [SIGNotification] = []
}
