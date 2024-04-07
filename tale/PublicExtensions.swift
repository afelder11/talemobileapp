//
//  PublicExtensions.swift
//  tale
//
//  Created by Austin Felder on 11/13/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import RealmSwift
import Firebase

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}

extension String {
    var iso8601: Date? { return Formatter.iso8601.date(from: self) }
}

extension Object {
    func writeToRealm() {
        try! uiRealm.write({
            uiRealm.add(self, update: .all)
        })
    }
    func updateToRealm() {
        try! uiRealm.write({
            uiRealm.add(self, update: .modified)
        })
    }
}

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

func handlePostDict(_ dict : [String : AnyObject]) -> Post {
    let post = Post()
    post.id = dict["id"] as? String ?? ""
    post.comment = dict["comment"] as? String ?? ""
    post.date = (dict["date"] as? String ?? "").iso8601
    post.aspectRatio = dict["aspectRatio"] as? Double ?? 1.0
    post.imageURL = dict["imageUrl"] as? String ?? ""
    
    let uid = dict["uid"] as? String ?? ""
    loadUserFromID(uid, completion: {
        user in
        DispatchQueue.main.async {
            try! uiRealm.write( {
                post.user = user
            })
            
        }
        post.user = user
    })
    
    post.writeToRealm()
    return post
}

func handleUserDict(_ dict : [String : AnyObject]) -> UserObject {
    
    let user = UserObject()
    user.id = dict["uid"] as? String ?? ""
    user.username = dict["username"] as? String ?? ""
    user.profileImageURL = dict ["profileImage"] as? String ?? ""
    user.writeToRealm()
    return user
}

func loadUserFromID(_ userID : String, completion : @escaping(_ user : UserObject) -> ()) {
    try! uiRealm.write {
        if let user = uiRealm.object(ofType: UserObject.self, forPrimaryKey: userID)  {
            completion(user)
        } else {
            let ref = Database.database().reference().child("users")
            ref.child(userID).observeSingleEvent(of: .value, with: {
                snapshot in
                guard let dict = snapshot.value as? [String : AnyObject] else { return }
                completion(handleUserDict(dict))
               
            })
        }
    }
}
