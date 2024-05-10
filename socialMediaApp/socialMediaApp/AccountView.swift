//
//  AccountView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct AccountView: View {
    @Binding var allPosts: [Post]
    @Binding var theUser: User
    @State private var comment: String = ""
    @Binding var myUser: User
    @Binding var allUsers: [User]
    
    var body: some View {
        if myUser.username == "temp"{
            LoginView(myUser: $myUser, allUsers: $allUsers, allPosts: $allPosts)
        }
        else{
            NavigationView{
                ScrollView{
                    if myUser.username == theUser.username{
                        HStack{
                            Spacer()
                            
                            NavigationLink(destination: AccountSettingsView(theUser: $myUser)){
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    
                    VStack{
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.black)
                            .padding()
                        
                        Text("@\(theUser.username)")
                       
                        Text("\(theUser.bio)")
                        
                        HStack{
                            Text("\(theUser.followers) Followers")
                            
                            Spacer()
                            
                            Text("\(theUser.followingCount) Following")
                        }
                        .frame(width: 200, height: 40)
                        
                        //checks if own account to display follow button
                        if myUser.username != theUser.username{
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
                                    .padding(6)
                                    .background(theUser.following ? Color.gray : Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5)
                            })
                            .padding()
                        }
                        
                        
                        ForEach(allPosts.indices, id: \.self) { i in
                            if theUser.username == allPosts[i].username{
                                VStack{
                                    HStack{
                                        if theUser.username == myUser.username{
                                            //the post's account
                                            NavigationLink(destination: AccountView(allPosts: $allPosts, theUser: $myUser, myUser: $myUser, allUsers: $allUsers)){
                                                Text("@\(myUser.username)")
                                                    .padding()
                                                    .foregroundColor(.black)
                                            }
                                            
                                            Spacer()
                                            
                                            //archive button on the own post
                                            Button(action: {
                                                theUser.archive.append(allPosts[i])
                                                myUser.archive.append(allPosts[i])
                                                allPosts.remove(at: i)
                                            }, label:{
                                                Image(systemName: "hourglass")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.black)
                                                    .padding()
                                            })
                                        }
                                        else{
                                            NavigationLink(destination: AccountView(allPosts: $allPosts, theUser: $theUser, myUser: $myUser, allUsers: $allUsers)){
                                                Text("@\(allPosts[i].username)")
                                                    .padding()
                                                    .foregroundColor(.black)
                                            }
                                            Spacer()
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
                    
                }
            }
        }
    }
        
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(allPosts: .constant([Post(username: "tim", postText: "yapyappyapyapp", likeNum: 0, comments: [Comment(username: "yuki", body: "hello")], liked: false), Post(username: "kchoy", postText: "HALLOOOOOSOSOSOSOSOOSOSOSOSOS I LIKE TO EAT AND SHOOP AND I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 10000, comments: [], liked: false), Post(username: "kchoy", postText: "D I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 100, comments: [], liked: false)]), theUser: .constant(User(username: "kchoy", bio: "", followers: 0, followingCount: 0, following: false, password: "", archive: [])), myUser: .constant(User(username: "kchoy", bio: "bio", followers: 0, followingCount: 0, following: false, password: "pword", archive: [])), allUsers: .constant([]))
    }
}
