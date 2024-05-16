//
//  InteractivePostView.swift
//  socialMediaApp
//
//  Created by StudentAM on 5/16/24.
//

import SwiftUI

//standard for posts for the home posts and account posts
struct InteractivePostView: View {
    //the certain post
    @Binding var thePost: Post
    //all the posts in the system
    @Binding var allPosts: [Post]
    //all the users in the system
    @Binding var allUsers: [User]
    //the logged in user
    @Binding var myUser: User
    //keeps track of what the user wants to comment
    @State private var comment: String = ""
    //the index at which the user wants to move a post to archive
    @State var index: Int
    //keeps track that a user is logged in
    @State var notLoggedIn: Bool = false
    
    var body: some View {
        //a singular post
        VStack{
            //the top layer of the post
            HStack{
                //traverses through allUsers array
                ForEach(allUsers.indices, id: \.self){ i in
                    //if the user's post, then it will fisplay their profile photo
                    if allUsers[i].username == thePost.username{
                        //if the profile photo is person icon
                        if allUsers[i].personIcon{
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .padding(.leading, 10)
                        }
                        //if the profile photo is a tortoise
                        else{
                            Image(systemName: "tortoise")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .frame(width: 40, height: 40)
                                .background(Color.black)
                                .cornerRadius(100)
                                .padding(.vertical, 10)
                                .padding(.leading, 10)
                        }
                        //navigated to the post's account
                        NavigationLink(destination: AccountView(allPosts: $allPosts, theUser: $allUsers[i], myUser: $myUser, allUsers: $allUsers)){
                            Text("@\(allUsers[i].username)")
                                .padding(.vertical, 10)
                                .foregroundColor(.black)
                        }
                        .navigationBarBackButtonHidden(true)
                            
                        Spacer()
                        //archive button on the own post
                        if allUsers[i].username == myUser.username{
                            Button(action: {
                                myUser.archive.append(thePost)
                                allUsers[i] = myUser
                                allPosts.remove(at: index)
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
                Text("\(thePost.postText)")
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
                    //decrements the post likes if the user has already liked
                    if thePost.liked{
                        thePost.likeNum -= 1
                        thePost.liked.toggle()
                    }
                    //increments the post's likes if the user has not already liked
                    else{
                        thePost.likeNum += 1
                        thePost.liked.toggle()
                    }
                }, label: {
                    //appearance of the button
                    Image(systemName: "heart.fill")
                        .foregroundColor(thePost.liked ? .red : .black)
                        .padding()
                })
                
                //displays num of likes
                Text("\(thePost.likeNum) Likes")
      
                Spacer()
            }
            .frame(width: 360, height: 50)
            .border(Color.black)
            
            
            //the existing comment list
            VStack{
                //if there are comments
                if thePost.comments.count > 0{
                    VStack{
                        //traverses through all comments
                        ForEach(thePost.comments.indices, id: \.self) { j in
                            // a comment
                            HStack{
                                //the user that commented
                                Text("@\(thePost.comments[j].username): ")
                                    .padding()
                                
                                //the text of the comment
                                Text("\(thePost.comments[j].body)")
                                
                                Spacer()
                            }
                        }
                    }
                    //styling
                    .frame(width: 360)
                    .border(Color.black)
                    .padding(-9)
                }
            }
            
            //add user comment bar
            HStack{
                //tracks what the user wants to comment
                TextField("Comment", text: $comment)
                    .autocapitalization(.none)
                    .padding()
                //add comment button
                Button(action:{
                    //checks that the user is logged in
                    if myUser.username == "temp"{
                        notLoggedIn = true
                    }
                    //ensures comment has text
                    else if comment != ""{
                        //creates a new note
                        let newComment: Comment = Comment(username: myUser.username, body: comment)
                        //appends that new note
                        thePost.comments.append(newComment)
                        comment = ""
                    }
                }, label:{
                    Image(systemName: "bubble.left")
                })
                .padding()
                //alerts that the user cannot comment if they are not logged in
                .alert(isPresented: $notLoggedIn){
                    Alert(title: Text("Must Be Logged In To Comment"),
                          dismissButton: .default(Text("Return")){
                    })
                }
            }
            .frame(width: 360)
            .border(Color.black)

        }
    }
}

#Preview {
    InteractivePostView(thePost: .constant(Post(username: "kchoy", postText: "hellooo", likeNum: 0, comments: [], liked: false)), allPosts: .constant([Post(username: "kchoy", postText: "", likeNum: 0, comments: [], liked: false)]), allUsers: .constant([]), myUser: .constant(User(username: "kchoy", bio: "branham", followers: 0, followingCount: 0, following: false, password: "password", archive: [], personIcon: true)), index: 0)
}
