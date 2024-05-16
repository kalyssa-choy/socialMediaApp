//
//  PostView.swift
//  socialMediaApp
//
//  Created by StudentAM on 5/16/24.
//

import SwiftUI

struct PostView: View {
    //the certain post
    @Binding var thePost: Post
    //the user of the post
    @State var theUser: User
    
    var body: some View {
        //first layer of the post
        HStack{
            //if the user's icon is a person
            if theUser.personIcon{
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
            }
            //if the user's icon is a tortoise
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
            //the post's account
                Text("@\(theUser.username)")
                    .padding(.vertical, 10)
                    .foregroundColor(.black)
                
            Spacer()
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
                    //decrements the post likes if already liked
                    if thePost.liked{
                        thePost.likeNum -= 1
                        thePost.liked.toggle()
                    }
                    //increments the post likes if not already liked
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
            //styling
            .frame(width: 360, height: 50)
            .border(Color.black)
            
            
            //the existing comment list
            VStack{
                //checks that comments are on the post
                if thePost.comments.count > 0{
                    VStack{
                        //traverses through all comments to display
                        ForEach(thePost.comments.indices, id: \.self) { j in
                            HStack{
                                //the user of the comment
                                Text("@\(thePost.comments[j].username): ")
                                    .padding()
                                
                                //the text of the comment
                                Text("\(thePost.comments[j].body)")
                                
                                Spacer()
                            }
                        }
                    }
                    .frame(width: 360)
                    .border(Color.black)
                    .padding(-9)
                }
            }
        }
    }

#Preview {
    PostView(thePost: .constant(Post(username: "", postText: "", likeNum: 0, comments: [], liked: false)), theUser: User(username: "temp", bio: "", followers: 0, followingCount: 0, following: false, password: "", archive: [], personIcon: false))
}
