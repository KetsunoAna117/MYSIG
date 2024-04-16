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
        self.currentActiveUser = Data().users[0]
        self.users = Data().users
        self.sigs = Data().sigs
        self.events = Data().events
        self.notifications = Data().notification
    }
    
}


struct Data {
    let utils = Utils()
    
     var users: [User] = [
        User(id: 1,
             email: "Johndoe@bsd.idserve.net",
             password: "123",
             picture: "john-doe",
             name: "John Doe",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [1],
             bookedEventId: [2,3],
             notificationId: [1]
        ),
        User(id: 2,
             email: "jamesrc@bsd.idserve.net",
             password: "123",
             picture: "james",
             name: "James RC",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [],
             notificationId: []
        ),
        User(id: 3,
             email: "dea@bsd.idserve.net",
             password: "123",
             picture: "dea",
             name: "Dea",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [],
             notificationId: []
        ),
        User(id: 4,
             email: "johan@bsd.idserve.net",
             password: "123",
             picture: "johan",
             name: "Johan",
             phoneNumber: "+6287831353012",
             cohort: 7,
             session: "Morning",
             joinedSigId: [],
             bookedEventId: [],
             notificationId: []
        )
    ]
    
    var sigs: [SIG] = [
        SIG(
            id: 1,
            name: "Badminton",
            desc: "Bermain badminton sampai bisa menguasai dunia, tunggu apa lagi, segera join dengan kami!",
            picId: 1,
            subscribedUserId: [1, 2, 3],
            listEventId: [1]
        ),
        SIG(
            id: 2,
            name: "Board Game",
            desc: "Catur? Ular tangga? Kartu remi? Bawa apa saja yang termasuk dengan permainan papan dan kita memainkannya bersama - sama!",
            picId: 2,
            subscribedUserId: [1,2],
            listEventId: [2]
        ),
        SIG(
            id: 3,
            name: "Voli",
            desc: "Boom - boom siapa yang suka menabok mikasa? Bukan mikasa anime ya, tapi mikasa merek bola voli. Ayo bergabung bersama - sama dengan kita!",
            picId: 3,
            subscribedUserId: [3],
            listEventId: [3]
        ),
        SIG(
            id: 4,
            name: "Basket",
            desc: "Ayo main basket biar ga cebol! Ingat, tumbuh tuh keatas bukan kesamping",
            picId: 4,
            subscribedUserId: [4],
            listEventId: []
        ),
        
    ]
    var events: [EventSIG] = [
        EventSIG(
            id: 1,
            name: "Latihan sore dengan senang",
            desc: "Mari kita latihan sore bersama - sama untuk memperkuat tali persaudaraan",
            eventStatus: "Ongoing",
            listRemindedUser: [1],
            location: "Green Office Park BSD, Tangerang Selatan",
            date: Utils().formatDate(from: "2024-03-31") ?? Date.now,
            time: "17.00-18.00",
            maxSlots: 4,
            sigId: 1,
            listRegisteredParticipantId: [2, 3]
        ),
        EventSIG(
            id: 2,
            name: "DnD",
            desc: "Mari kita menjelajahi dunia RPG bersama - sama dengan teman - teman!",
            eventStatus: "Ongoing",
            listRemindedUser: [1, 2, 3, 4],
            location: "Apple Developer Academy - Collaboration Area 2",
            date: Utils().formatDate(from: "2024-04-07") ?? Date.now,
            time: "14.00-18.00",
            maxSlots: 6,
            sigId: 2,
            listRegisteredParticipantId: [1, 2, 3, 4]
        ),
        EventSIG(
            id: 3,
            name: "Latihan servis",
            desc: "Buat pemula yang masih belum bisa servis, ayo berlatih bersama - sama",
            eventStatus: "Ongoing",
            listRemindedUser: [3],
            location: "Green Office Park BSD, Tangerang Selatan",
            date: Utils().formatDate(from: "2024-04-01") ?? Date.now,
            time: "10.00-13.00",
            maxSlots: 10,
            sigId: 3,
            listRegisteredParticipantId: [1, 2, 3]
        ),
    ]
    var notification: [SIGNotification] = [
        SIGNotification(
            id: 1,
            title: "Jadwal DND baru",
            content: "Siapa yang udah lama pingin main DnD? Ayo tunggu apa lagi mumpung kita ada sesi kedua besok jumat!",
            date: Utils().formatDate(from: "2024-03-28")
        )
    ]
}


