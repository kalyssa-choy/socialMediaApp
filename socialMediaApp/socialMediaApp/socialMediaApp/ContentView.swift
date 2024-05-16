//
//  ContentView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

//struct that holds all post traits
struct Post{
    var username: String
    var postText: String
    var likeNum: Int
    var comments: [Comment]
    var liked: Bool
}

//struct that holds all user traits
struct User{
    var username: String
    var bio: String
    var followers: Int
    var followingCount: Int
    var following: Bool
    var password: String
    var archive: [Post]
    var personIcon: Bool
}

//struct that holds all comment traits
struct Comment{
    var username: String
    var body: String
}

struct ContentView: View {
    
    //keeps track of what the user types and wants to comment
    @State private var comment:String = ""
    
    //array that holds all the posts in the system
    @State private var allPosts: [Post] = [Post(username: "tim", postText: "yapyappyapyapp", likeNum: 0, comments: [Comment(username: "yuki", body: "hello")], liked: false), Post(username: "kchoy", postText: "HALLOOOOOSOSOSOSOSOOSOSOSOSS I LIKE TO EAT AND SHOOP AND I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 10000, comments: [], liked: false), Post(username: "kchoy", postText: "D I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 100, comments: [], liked: false)]
    
    //the current logged in user
    @State private var myUser: User = User(username: "kchoy", bio: "branham", followers: 0, followingCount: 0, following: false, password: "password", archive: [], personIcon: true)
    
    //all of the current users in the system
    @State private var allUsers: [User] = [User(username: "tim", bio: "I like dogs", followers: 1, followingCount: 3, following: true, password: "pass", archive: [], personIcon: true), User(username: "kchoy", bio: "branham", followers: 0, followingCount: 0, following: false, password: "password", archive: [], personIcon: true), User(username: "yuki", bio: "meow", followers: 1000, followingCount: 10, following: false, password: "yuki", archive: [], personIcon: true)]
    
    var body: some View {
        //for navigating between pages
        NavigationView{
            //to have the navigation bar below
            TabView{
                //to allow scrolling through posts
                ScrollView(.vertical){
                    //home title
                    HStack{
                        //the house icon
                        Image(systemName: "house.fill")
                            .font(.system(size: 33))
                            .padding(.horizontal, 10)
                            .padding(.top, 15)
                        
                        //the actual title
                        Text("Home")
                            //styling
                            .fontWeight(.bold)
                            .font(.system(size: 33))
                            .frame(maxWidth: 360)
                            .padding(.horizontal, -140)
                            .padding(.top, 19)
                        
                        //formating to align left
                        Spacer()
                    }
                   
                    //all of the posts
                    VStack {
                        ForEach(allPosts.indices, id: \.self) { i in
                            VStack{
                                InteractivePostView(thePost: $allPosts[i], allPosts: $allPosts, allUsers: $allUsers, myUser: $myUser, index: i)
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                }

                //the home button
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .foregroundColor(.black)
                
                //the new post button redirects to new post page
                NewPostView(allPosts: $allPosts, myUser: $myUser)
                .tabItem{
                    Image(systemName: "note.text")
                    Text("New Post")
                }
                
                //the archive button redirects to archive page
                ArchiveView(allPosts: $allPosts, theUser: $myUser, allUsers: $allUsers)
                .tabItem{
                    Image(systemName: "hourglass")
                    Text("Archive")
                }
                
                //the account button to see account
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
