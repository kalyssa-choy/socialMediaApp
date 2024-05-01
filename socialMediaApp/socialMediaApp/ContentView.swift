//
//  ContentView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct Post{
    var username: String
    var postText: String
    var likeNum: Int
    var comments: [Comment]
    var liked: Bool
}

struct User: Hashable{
    var username: String
    var bio: String
    var followers: Int
    var followingCount: Int
    var following: Bool
    var password: String
    var notifications: Bool
    var isPublic: Bool
}

struct Comment{
    var username: String
    var body: String
}

struct ContentView: View {
    
    @State private var comment:String = ""
    
    @State private var allPosts: [Post] = [Post(username: "tim", postText: "yapyapp", likeNum: 0, comments: [], liked: false)]
    
    @State private var allUsers: [User] = []
    
    @State private var myUser: User = User(username: "kchoy", bio: "branham", followers: 0, followingCount: 0, following: false, password: "password", notifications: false, isPublic: true)
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    ForEach(allPosts.indices, id: \.self) { i in
                        VStack{
                            
                            ForEach(allUsers.indices, id: \.self){ i in
                                if allUsers[i].username == allPosts[i].username{
                                    //the post's account
                                    NavigationLink(destination: AccountView(allPosts: $allPosts, theUser: allUsers[i], thePost: allPosts[i], allUsers: $allUsers, myUser: $myUser)){
                                        Text("@\(allPosts[i].username)")
                                            .padding()
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            //the text body of the post
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
                                        comment = ""
                                    }
                                }, label:{
                                    Image(systemName: "bubble.left")
                                })
                            }
                        }
                    }
                    
                    //the menu bar on the bottom
                    HStack{
                        //home buton (goes to home page)
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)){
                            Image(systemName: "house.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        }
                        
                        //create new post button (goes to new post page)
                        NavigationLink(destination: NewPostView()){
                            Text("+")
                                .frame(width: 40, height: 30)
                                .background(Color.white) 
                                .border(Color.black)
                                .cornerRadius(10)
                            
                        }
                        
                        //archive menu button (goes to user archive page)
                        NavigationLink(destination: ArchiveView()){
                            Image(systemName: "hourglass")
                                .font(.system(size: 28))
                                .foregroundColor(.black)
                        }
                        
                        //arccount menu button (goes to user account)
                        NavigationLink(destination: OwnAccountView(allPosts: $allPosts, myUser: $myUser)){
                            
                        }
                    }
                }
                .padding()
            }
            //might remove
            .navigationBarTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
