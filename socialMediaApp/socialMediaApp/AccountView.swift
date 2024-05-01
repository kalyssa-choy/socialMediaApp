//
//  AccountView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct AccountView: View {
    @Binding var allPosts: [Post]
    @State var theUser: User
    @State var thePost: Post
    @Binding var allUsers: [User]
    @State private var comment: String = ""
    @Binding var myUser: User
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image("profileIcon")
                    
                    Text("@\(thePost.username)")
                   
                    Text("\(theUser.bio)")
                    
                    Button(action: {
                        if !theUser.following{
                            theUser.followers += 1
                        }
                        else{
                            theUser.followers -= 1
                        }
                        theUser.following.toggle()
                    }, label: {
                        Text(theUser.following ? "Unfollow" : "Follow")
                    })
                    
                    ForEach(allPosts.indices, id: \.self) {i in
                        if allPosts[i].username == thePost.username{
                            VStack{
                                Text("\(allPosts[i].postText)")
                                
                                //the like and like count bar
                                HStack{
                                    //the like button
                                    Button(action: {
                                        if allPosts[i].liked{
                                            allPosts[i].likeNum -= 1
                                            allPosts[i].liked.toggle()
                                        }
                                        else{
                                            allPosts[i].likeNum += 1
                                            allPosts[i].liked.toggle()
                                        }
                                    }, label: {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(allPosts[i].liked ? .red : .black)
                                    })
                                    
                                    //displays num of likes
                                    Text("\(allPosts[i].likeNum) Likes")
                                }
                                        
                                //the existing comment list
                                VStack{
                                    ForEach(allPosts[i].comments.indices, id: \.self) { j in
                                        HStack{
                                            Text("@\(allPosts[i].comments[j].username): ")
                                            
                                            Text("\(allPosts[i].comments[j].body)")
                                        }
                                    }
                                }
                                
                                //adding comment bar
                                HStack{
                                    TextField("Comment", text: $comment)
                                    
                                    //add comment button
                                    Button(action:{
                                        if comment != ""{
                                            //creates a new note
                                            let newComment: Comment = Comment(username: myUser.username, body: comment)
                                            //appends that new note
                                            allPosts[i].comments.append(newComment)
                                        }
                                    }, label:{
                                        Image(systemName: "bubble.left")
                                    })
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
}

//#Preview {
//    AccountView(allPosts: .constant([]), thePost: Post(username: "temp", postText: "temp", likeNum: 0, comments: [], liked: false), allUsers: .constant([]), myUser: .constant(User(username: "tempUser", bio: "bio", followers: 0, followingCount: 0, following: false, password: "pword", notifications: false, isPublic: true)))
//}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(allPosts: .constant([]), theUser: User(username: "", bio: "", followers: 0, followingCount: 0, following: false, password: "", notifications: false, isPublic: false), thePost: Post(username: "temp", postText: "temp", likeNum: 0, comments: [], liked: false), allUsers: .constant([]), myUser: .constant(User(username: "tempUser", bio: "bio", followers: 0, followingCount: 0, following: false, password: "pword", notifications: false, isPublic: true)))
    }
}
