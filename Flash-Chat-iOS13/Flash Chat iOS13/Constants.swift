//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by BarisKandemir on 28.11.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
  // We don't need to instance for reach properties which is starting "static"
  // static properties are associated with the type
  // other properties are associated with instances created from the type
  static let appName = "⚡️FlashChat"
  static let cellIdentifier = "ReusableCell"
  static let cellNibName = "MessageCell"
  static let registerSegue = "RegisterToChat"
  static let loginSegue = "LoginToChat"
  
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

