//
//  NewPostView.swift
//  socialMediaApp
//
//  Created by StudentAM on 5/1/24.
//

import SwiftUI

struct NewPostView: View {
    //the desired text of the post
    @State private var postText: String = ""
    //all of the posts in the system
    @Binding var allPosts: [Post]
    //the logged in user
    @Binding var myUser: User
    //the temp post to create the desired post
    @State var tempPost: Post = Post(username: "", postText: "", likeNum: 0, comments: [], liked: false)
    //keeps track if the button and temporary post are displayed
    @State var show: Bool = false
    //keeps track if the alert should be shown
    @State var alert: Bool = false
    //if the post could be created
    @State var noPost: Bool = false
    
    //for going back out of a navigation path
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        //to navigate between pages
        NavigationView{
            //to scroll in case cannot see whole screen
            ScrollView{
                VStack{
                    //title of the page
                    Text("New Post")
                        //styling
                        .fontWeight(.bold)
                        .font(.system(size: 33))
                        .frame(maxWidth: 360, alignment: .topLeading)
                        .padding()
                    
                    //prompts the user to enter text
                    Text("Post Text:")
                        .bold()
                        .frame(maxWidth: 360, alignment: .leading)
                    //keeps track of the user's desired post text
                    TextEditor(text: $postText)
                        .autocapitalization(.none)
                        .frame(width: 340, height: 80)
                        .padding(10)
                        .border(Color.black)
                    
                    //formatting
                    HStack{
                        //aligns the button right
                        Spacer()
                        
                        //button to preview the post
                        Button(action: {
                            if postText != ""{
                                tempPost = Post(username: myUser.username, postText: postText, likeNum: 0, comments: [], liked: false)
                                //show the previewed post
                                show = true
                            }
                            else{
                                //if there is no text alert is shown
                                noPost = true
                            }
                        }, label:{
                            //appearance of the button
                            Text("Preview Post")
                                .padding(8)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 15)
                        })
                        //alert telling the user they must ass text to post
                        .alert(isPresented: $noPost){
                            Alert(title: Text("Must Add Text To Create Post"), dismissButton: .default(Text("Okay")))
                        }
                    }
                    
                    Spacer()
                    
                    //shows the preview of the post
                    if show{
                        VStack{
                            //uses a view to show the post
                            PostView(thePost: $tempPost, theUser: myUser)
                        }
                        .padding()
                        
                        Spacer()
                        
                        //create post button
                        Button(action:{
                            //adds the post into allPosts array
                            allPosts.append(tempPost)
                            //resets the values
                            postText = ""
                            show = false
                            alert = true
                        }, label:{
                            //appearance of the button
                            Text("Post")
                                .padding()
                                .frame(width: 200, alignment: .bottom)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                        //alert for if the post has been created
                        .alert(isPresented: $alert){
                            Alert(
                                title: Text("Post Has Been Created!"),
                                dismissButton: .default(Text("Return")){
                                    //resets value
                                    alert = false
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            )
                        }
                    }
                    
                }
                .frame(minHeight: 500)
            }
        }
    }
}

#Preview {
    NewPostView(allPosts: .constant([]), myUser: .constant(User(username: "temp", bio: "", followers: 0, followingCount: 0, following: false, password: "", archive: [], personIcon: false)))
}
