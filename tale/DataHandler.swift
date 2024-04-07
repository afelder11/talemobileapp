//
//  DataHandler.swift
//  tale
//
//  Created by Austin Felder on 11/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class DataHandler : ObservableObject {
    @Published var homePagePosts = [Post]()
    @Published var explorePagePosts = [PostIdentifiable]()
    @Published var searchPosts = [Post]()
    @Published var loggedInUser = UserObject()
    @Published var temporaryPosts = [PostIdentifiable]()
    @Published var profilePagePosts = [PostIdentifiable]()
    
    init() {
        self.loadHomePagePosts()
        self.loadExplorePagePosts()
    }
    
    func loadHomePagePosts() {
        let ref = Database.database().reference()
        ref.child("posts").observe(.value, with: {
            snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject] else {return}
                self.homePagePosts.append(handlePostDict(dict))
                self.homePagePosts.sort(by: {$0.date!.compare($1.date!) == .orderedDescending})
            }
        })
    }
        func loadExplorePagePosts() {
            let ref = Database.database().reference()
            ref.child("posts").observe(.value, with: {
                snapshot in
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    guard let dict = snap.value as? [String : AnyObject] else {return}
                    self.explorePagePosts.append(PostIdentifiable(post: handlePostDict(dict)))
                    
                }
            })
        }
    
    func loadPostsFor(_ user: String) {
        if user == loggedInUser.id {
            let ref = Database.database().reference()
            ref.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: user).observe(.value, with: {
                snapshot in
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    guard let dict = snap.value as? [String : AnyObject] else {return}
                    self.profilePagePosts.append(PostIdentifiable(post: handlePostDict(dict)))
                    self.profilePagePosts.sort(by: {$0.post.date!.compare($1.post.date!) == .orderedDescending})
                }
            })
        } else {
            let ref = Database.database().reference()
            ref.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: user).observe(.value, with: {
                snapshot in
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    guard let dict = snap.value as? [String : AnyObject] else {return}
                    self.temporaryPosts.append(PostIdentifiable(post: handlePostDict(dict)))
                    self.temporaryPosts.sort(by: {$0.post.date!.compare($1.post.date!) == .orderedDescending})
                }
            })
        }
        
    }
    
    func loadPostsFrom(_ keyword : String) {
        self.searchPosts.removeAll()
        let ref = Database.database().reference()
        ref.child("posts").queryOrdered(byChild: ("searchTerms/\(keyword)")).queryEqual(toValue: true).observeSingleEvent(of: .value, with: {
            snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject] else {return}
                self.searchPosts.append(handlePostDict(dict))
            }
        })
    }
    
    func checkIfLoggedIn(completion : @escaping(_ isLoggedIn : Bool) -> ()) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        if uiRealm.object(ofType: UserObject.self, forPrimaryKey: userID) != nil {
            let ref = Database.database().reference().child("users")
            ref.child(userID).observeSingleEvent(of: .value, with: {
                snapshot in
                guard let dict = snapshot.value as? [String : AnyObject] else { return }
                self.loggedInUser = handleUserDict(dict)
                completion(true)
            })
        } else {
            completion(false)
        }
    }
        
    }
    

