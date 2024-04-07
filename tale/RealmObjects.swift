//
//  RealmObjects.swift
//  tale
//
//  Created by Austin Felder on 11/13/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import RealmSwift

class Post : Object {
    @objc dynamic var id: String = ""
    @objc dynamic var imageURL : String = ""
    @objc dynamic var comment : String = ""
    @objc dynamic var user : UserObject? = nil
    @objc dynamic var aspectRatio : Double = 0
    @objc dynamic var date : Date? = nil
    
    var isFavorited = RealmOptional<Bool>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class UserObject : Object {
    @objc dynamic var id : String = ""
    @objc dynamic var username : String = ""
    @objc dynamic var profileImageURL : String = ""
    var isLoggedIn = RealmOptional<Bool>()
    var isFollowing = RealmOptional<Bool>()
    
    
    var followers = List<StringValue>()
    var followings = List<StringValue>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class StringValue : Object {
    @objc dynamic var string : String = ""
}
