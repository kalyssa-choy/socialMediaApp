//
//  AccountView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct AccountView: View {
    //all posts in the system
    @Binding var allPosts: [Post]
    //the user that the viewer is looking at
    @Binding var theUser: User
    //keeps track of what the user input is for comments
    @State private var comment: String = ""
    //the logged in user
    @Binding var myUser: User
    //all of the users in the system
    @Binding var allUsers: [User]
    //boolean that keeps track of when alert should be shown
    @State var notLoggedIn: Bool = false
    
    var body: some View {
        //checks if there is a user logged in
        if theUser.username == "temp"{
            //if not logged in redirects to log in page
            LoginView(myUser: $myUser, allUsers: $allUsers, allPosts: $allPosts)
        }
        else{
            //view to navigate between pages
            NavigationView{
                //to scroll through user posts
                ScrollView{
                    //checks if user is viewing own account
                    if myUser.username == theUser.username{
                        HStack{
                            Spacer()
                            
                            //if it is the logged in account, it allows user to make changes to their account
                            NavigationLink(destination: AccountSettingsView(theUser: $myUser, allUsers: $allUsers, allPosts: $allPosts).navigationBarBackButtonHidden(true)){
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    
                    //the account's profile photo
                    VStack{
                        //if the user's profile photo is a person icon
                        if theUser.personIcon{
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 100))
                                .foregroundColor(.black)
                                .padding()
                        }
                        //if the user's profile photo is a tortoise
                        else{
                            Image(systemName: "tortoise")
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                                .frame(width: 100, height: 100)
                                .background(Color.black)
                                .cornerRadius(100)
                                .aspectRatio(contentMode: .fit)
                                .padding(23)
                        }
                        
                        //displaying the user's username
                        Text("@\(theUser.username)")
                        
                        //displaying the user's bio
                        Text("\(theUser.bio)")
                        
                        //formatting to make followers and following on the same line
                        HStack{
                            //the user's followers
                            Text("\(theUser.followers) Followers")
                            
                            //formatting
                            Spacer()
                            
                            //the user's following
                            Text("\(theUser.followingCount) Following")
                        }
                        //styling
                        .frame(width: 200, height: 40)
                        
                        //checks if own account to display follow button
                        if myUser.username != theUser.username{
                            //the actual follow/unfollow button
                            Button(action: {
                                //if the user is logged in and not following the acccount they are viewing, they can follow
                                if !theUser.following && myUser.username != "temp"{
                                    //increments followers count
                                    theUser.followers += 1
                                }
                                //if they are already following and logged in, they can unfollow
                                else if myUser.username != "temp"{
                                    //decrements followers count
                                    theUser.followers -= 1
                                }
                                //alerts user they are not logged in
                                else{
                                    notLoggedIn = true
                                }
                                //updates if the logged in user is following the viewed account
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
                    }
                    
                    //all of the posts from the user they are viewing
                    VStack {
                        ForEach(allPosts.indices, id: \.self) { i in
                            
                            //all of the posts from the viewing user
                            if allPosts[i].username == theUser.username{
                                VStack{
                                    InteractivePostView(thePost: $allPosts[i], allPosts: $allPosts, allUsers: $allUsers, myUser: $myUser, index: i)
                                }
                                .padding()
                                
                                Spacer()
                            }
                        }
                    }
                    
                    //if the user tries to follow/unfollow someone while not being logged in
                    .alert(isPresented: $notLoggedIn){
                        return Alert(
                            title: Text("Unsuccessful"),
                            message: Text("You Must Login Or Create An Account To Follow/Unfollow Other Users"),
                            dismissButton: .default(Text("Okay"))
                        )
                    }
                }
            }
        }
    }
        
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(allPosts: .constant([Post(username: "tim", postText: "yapyappyapyapp", likeNum: 0, comments: [Comment(username: "yuki", body: "hello")], liked: false), Post(username: "kchoy", postText: "HALLOOOOOSOSOSOSOSOOSOSOSOSOS I LIKE TO EAT AND SHOOP AND I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 10000, comments: [], liked: false), Post(username: "kchoy", postText: "D I AM GOING TO BE ATTENDED UCSD IN THE FALL!", likeNum: 100, comments: [], liked: false)]), theUser: .constant(User(username: "kchoy", bio: "", followers: 0, followingCount: 0, following: false, password: "", archive: [], personIcon: false)), myUser: .constant(User(username: "kchoy", bio: "bio", followers: 0, followingCount: 0, following: false, password: "pword", archive: [], personIcon: false)), allUsers: .constant([]))
    }
}
