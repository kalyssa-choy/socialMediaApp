//
//  ArchiveView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct ArchiveView: View {
    //allPosts in the system
    @Binding var allPosts: [Post]
    //theUser that the archives belong to
    @Binding var theUser: User
    //all the users in the system
    @Binding var allUsers: [User]
    
    var body: some View {
        //to navigate between pages
        NavigationView{
            //to scroll to see full page and posts
            ScrollView{
                //page title
                Text("Archive")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .frame(maxWidth: 360, alignment: .topLeading)
                    .padding()
                
                //formatting
                HStack{
                    //prompts the user to take action to archive/unarchive
                    Text("Click The Hourglass To Archive/Unarchive A Post")
                        .font(.system(size: 10))
                        .padding(.leading, 20)
                        .padding(.top, -15)
                    
                    //formatting
                    Spacer()
                }
                //if there are no archived posts there is text that is displayed
                if theUser.archive.count == 0{
                    Text("No Archived Posts")
                    //styling
                        .frame(height: 600)
                }
                
                //for holding all of the posts
                VStack {
                    //goes through all theUser's archived posts
                    ForEach(theUser.archive.indices, id: \.self) { i in
                        VStack{
                            //all of the posts
                            ArchivePostView(thePost: $theUser.archive[i], myUser: $theUser, allPosts: $allPosts, index: i)
                        }
                        //styling
                        .padding()
                        
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ArchiveView(allPosts: .constant([]), theUser: .constant(User(username: "", bio: "", followers: 0, followingCount: 10, following: false, password: "", archive: [], personIcon: false)), allUsers: .constant([]))
}
