//
//  Constants.swift
//  ChillChat
//
//  Created by Toygun Çil on 20.08.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
    
    static let appName = "⚡️ChillChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let chatViewControllerIdentifier = "ChatViewController"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}
