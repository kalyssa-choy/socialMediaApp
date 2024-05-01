//
//  OwnAccountView.swift
//  socialMediaApp
//
//  Created by StudentAM on 5/1/24.
//

import SwiftUI

struct OwnAccountView: View {
    @Binding var allPosts: [Post]
    @Binding var myUser: User
    @State private var comment: String = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image("profileIcon")
                    
                    Text("@\(myUser.username)")
                    
                    Text("\(myUser.bio)")
                    
                    ForEach(allPosts.indices, id: \.self) {i in
                        if allPosts[i].username == myUser.username{
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

#Preview {
    OwnAccountView(allPosts: .constant([]), myUser: .constant(User(username: "tempUser", bio: "bio", followers: 0, followingCount: 0, following: false, password: "pword", notifications: false, isPublic: true)))
}
