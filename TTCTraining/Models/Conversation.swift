//
//  Conversation.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
