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

struct User{
    var username: String
    var bio: String
    var followers: Int
    var followingCount: Int
    var following: Bool
    var password: String
    var archive: [Post]
}

struct Comment{
    var username: String
    var body: String
}

struct ContentView: View {
    
    @State private var comment:String = ""
    
    @State private var allPosts: [Post] = [Post(username: "tim", postText: "yapyappyapyapp", likeNum: 0, comments: [Comment(username: "yuki", body: "hello")], liked: false), Post(username: "kchoy", postText: "HALLOOOOOSOSOSOSOSOOSOSOSOSOS I LIKE TO EAT AND SHOOP AND I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 10000, comments: [], liked: false), Post(username: "kchoy", postText: "D I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 100, comments: [], liked: false)]
    @State private var myUser: User = User(username: "temp", bio: "branham", followers: 0, followingCount: 0, following: false, password: "password", archive: [])
    
    @State private var allUsers: [User] = [User(username: "tim", bio: "I like dogs", followers: 1, followingCount: 3, following: true, password: "pass", archive: []), User(username: "kchoy", bio: "branham", followers: 0, followingCount: 0, following: false, password: "password", archive: [])]
    
    var body: some View {
        NavigationView{
            TabView{
                ScrollView(.vertical){
                    //home title
                    HStack{
                        Image(systemName: "house.fill")
                            .font(.system(size: 33))
                            .padding(.horizontal, 10)
                            .padding(.top, 15)
                        
                        Text("Home")
                            //styling
                            .fontWeight(.bold)
                            .font(.system(size: 33))
                            .frame(maxWidth: 360)
                            .padding(.horizontal, -140)
                            .padding(.top, 19)
                        
                        Spacer()
                    }
                   
                    VStack {
                        ForEach(allPosts.indices, id: \.self) { i in
                            VStack{
                                //error for some reason
                                HStack{
                                    ForEach(allUsers.indices, id: \.self){ index in
                                        if allUsers[index].username == allPosts[i].username{
                                            //the post's account
                                            NavigationLink(destination: AccountView(allPosts: $allPosts, theUser: $allUsers[index], myUser: $myUser, allUsers: $allUsers)){
                                                Text("@\(allUsers[index].username)")
                                                    .padding()
                                                    .foregroundColor(.black)
                                            }
                                                
                                            Spacer()
                                                //archive button on the own post
                                            if allUsers[index].username == myUser.username{
                                                Button(action: {
                                                    allUsers[index].archive.append(allPosts[i])
                                                    myUser.archive.append(allPosts[i])
                                                    allPosts.remove(at: i)
                                                    }, label:{
                                                        Image(systemName: "hourglass")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(.black)
                                                            .padding()
                                                })
                                            }
                                        }
                                    }
                                   
                                }
                                .frame(width: 360)
                                .border(Color.black)
                                
                                
                                //the text body of the post
                                HStack{
                                    Text("\(allPosts[i].postText)")
                                        .padding()
                                    
                                    Spacer()
                                }
                                .frame(width: 360)
                                .border(Color.black)
                                .padding(-9)
                                
                        
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
                                            .padding()
                                    })
                                    
                                    //displays num of likes
                                    Text("\(allPosts[i].likeNum) Likes")
                          
                                    Spacer()
                                }
                                .frame(width: 360, height: 50)
                                .border(Color.black)
                                
                                
                                //the existing comment list
                                VStack{
                                    if allPosts[i].comments.count > 0{
                                        VStack{
                                            ForEach(allPosts[i].comments.indices, id: \.self) { j in
                                                HStack{
                                                    Text("@\(allPosts[i].comments[j].username): ")
                                                        .padding()
                                                    
                                                    Text("\(allPosts[i].comments[j].body)")
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                        .frame(width: 360)
                                        .border(Color.black)
                                        .padding(-9)
                                    }
                                }
                                
                                //add user comment bar
                                HStack{
                                    TextField("Comment", text: $comment)
                                        .autocapitalization(.none)
                                        .padding()
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
                                    .padding()
                                }
                                .frame(width: 360)
                                .border(Color.black)
                    
                            }
                            
                        }
                        
                    }
                }

                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .foregroundColor(.black)
                
                NewPostView()
                .tabItem{
                    Image(systemName: "note.text")
                    Text("New Post")
                }
                
                ArchiveView()
                .tabItem{
                    Image(systemName: "hourglass")
                    Text("Archive")
                }
                
                //can you put an if else statement in front of tab item?
                AccountView(allPosts: $allPosts, theUser: $myUser, myUser: $myUser, allUsers: $allUsers)
                .tabItem{
                    Image(systemName: "person.circle.fill")
                    Text("Account")
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
