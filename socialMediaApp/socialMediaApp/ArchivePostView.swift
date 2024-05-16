//
//  ArchivePostView.swift
//  socialMediaApp
//
//  Created by StudentAM on 5/16/24.
//

import SwiftUI

//standard for all archive posts
struct ArchivePostView: View {
    //the single post that is being displayed
    @Binding var thePost: Post
    //the user that is logged in
    @Binding var myUser: User
    //all the posts in the system
    @Binding var allPosts: [Post]
    //keeps track of index to know where to remove a post
    @State var index: Int
    
    var body: some View {
        //first layer of the post
        HStack{
            //user's profile picture
            //if it is a person icon
            if myUser.personIcon{
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
            }
            //if it is a tortoise
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
            //the post's account name
                Text("@\(myUser.username)")
                    .padding(.vertical, 10)
                    .foregroundColor(.black)
                
            Spacer()
            
            //the archive button to remove from the user's archive and redisplay in all posts
            Button(action: {
                allPosts.append(thePost)
                myUser.archive.remove(at: index)
                }, label:{
                    //the appearance of the button
                    Image(systemName: "hourglass")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding()
            })
        }
        //styling
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
                    //if the post has been liked, will decrement the likes and unlike it
                    if thePost.liked{
                        thePost.likeNum -= 1
                        thePost.liked.toggle()
                    }
                    //if the post has not been liked, will increment the likes and like it
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
                        //goes through all of the post's comments to display
                        ForEach(thePost.comments.indices, id: \.self) { j in
                            HStack{
                                //the username of the comment
                                Text("@\(thePost.comments[j].username): ")
                                    .padding()
                                
                                //the body of the comments
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
        }
}

#Preview {
    ArchivePostView(thePost: .constant(Post(username: "", postText: "", likeNum: 0, comments: [], liked: false)), myUser: .constant(User(username: "temp", bio: "", followers: 0, followingCount: 0, following: false, password: "", archive: [], personIcon: false)), allPosts: .constant([]), index: 0)
}
