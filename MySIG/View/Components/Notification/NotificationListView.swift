//
//  NotificationListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct NotificationListView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    let notifications: [SIGNotification]
    
    var body: some View {
        List {
            ForEach(notifications, id: \.self) { notification in
                NotificationRowView(currentNotification: notification)
                    .swipeActions(edge: .trailing) {
                        if let user = appStoreData.currentActiveUser {
                            Button(role:.destructive, action: {
                                Utils().deleteNotificationByID(
                                    notificationID: notification.id,
                                    userId: user.id,
                                    appStoreData: appStoreData)
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    NotificationListView(notifications: AppDataStore().notifications)
        .environmentObject(AppDataStore())
}
