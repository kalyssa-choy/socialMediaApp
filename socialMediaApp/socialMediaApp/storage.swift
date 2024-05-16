//HStack{
//                                        if allUsers[index].username == allPosts[i].username{
//                                            if allUsers[index].personIcon{
//                                                Image(systemName: "person.circle.fill")
//                                                    .font(.system(size: 35))
//                                                    .foregroundColor(.black)
//                                                    .padding(.vertical, 10)
//                                                    .padding(.leading, 10)
//                                            }
//                                            else{
//                                                Image(systemName: "tortoise")
//                                                    .foregroundColor(.white)
//                                                    .font(.system(size: 15))
//                                                    .frame(width: 40, height: 40)
//                                                    .background(Color.black)
//                                                    .cornerRadius(100)
//                                                    .padding(.vertical, 10)
//                                                    .padding(.leading, 10)
//                                            }
//                                            //the post's account
//                                            NavigationLink(destination: AccountView(allPosts: $allPosts, theUser: $allUsers[index], myUser: $myUser, allUsers: $allUsers)){
//                                                Text("@\(allUsers[index].username)")
//                                                    .padding(.vertical, 10)
//                                                    .foregroundColor(.black)
//                                            }
//                                            .navigationBarBackButtonHidden(true)
//
//                                            Spacer()
//                                                //archive button on the own post
//                                            if allUsers[index].username == myUser.username{
//                                                Button(action: {
//                                                    myUser.archive.append(allPosts[i])
//                                                    allUsers[index] = myUser
//                                                    allPosts.remove(at: i)
//                                                    }, label:{
//                                                        Image(systemName: "hourglass")
//                                                            .font(.system(size: 20))
//                                                            .foregroundColor(.black)
//                                                            .padding()
//                                                })
//                                            }
//                                        }
//                                    }
//                                    .frame(width: 360)
//                                    .border(Color.black)
//                                }
//
//
//                                //the text body of the post
//                                HStack{
//                                    Text("\(allPosts[i].postText)")
//                                        .padding()
//
//                                    Spacer()
//                                }
//                                .frame(width: 360)
//                                .border(Color.black)
//                                .padding(-9)
//
//
//                                //the like and like count bar
//                                HStack{
//                                    //the like button
//                                    Button(action: {
//                                        if allPosts[i].liked{
//                                            allPosts[i].likeNum -= 1
//                                            allPosts[i].liked.toggle()
//                                        }
//                                        else{
//                                            allPosts[i].likeNum += 1
//                                            allPosts[i].liked.toggle()
//                                        }
//                                    }, label: {
//                                        Image(systemName: "heart.fill")
//                                            .foregroundColor(allPosts[i].liked ? .red : .black)
//                                            .padding()
//                                    })
//
//                                    //displays num of likes
//                                    Text("\(allPosts[i].likeNum) Likes")
//
//                                    Spacer()
//                                }
//                                .frame(width: 360, height: 50)
//                                .border(Color.black)
//
//
//                                //the existing comment list
//                                VStack{
//                                    if allPosts[i].comments.count > 0{
//                                        VStack{
//                                            ForEach(allPosts[i].comments.indices, id: \.self) { j in
//                                                HStack{
//                                                    Text("@\(allPosts[i].comments[j].username): ")
//                                                        .padding()
//
//                                                    Text("\(allPosts[i].comments[j].body)")
//
//                                                    Spacer()
//                                                }
//                                            }
//                                        }
//                                        .frame(width: 360)
//                                        .border(Color.black)
//                                        .padding(-9)
//                                    }
//                                }
//
//                                //add user comment bar
//                                HStack{
//                                    TextField("Comment", text: $comment)
//                                        .autocapitalization(.none)
//                                        .padding()
//                                    //add comment button
//                                    Button(action:{
//                                        if comment != ""{
//                                            //creates a new note
//                                            let newComment: Comment = Comment(username: myUser.username, body: comment)
//                                            //appends that new note
//                                            allPosts[i].comments.append(newComment)
//                                            comment = ""
//                                        }
//                                    }, label:{
//                                        Image(systemName: "bubble.left")
//                                    })
//                                    .padding()
//                                }
//                                .frame(width: 360)
//                                .border(Color.black)
