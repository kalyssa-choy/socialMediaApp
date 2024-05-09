//
//  AccountSettingsView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/29/24.
//

import SwiftUI

struct AccountSettingsView: View {
    @Binding var theUser: User
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Account")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .frame(maxWidth: 360, alignment: .topLeading)
                
                Button(action:{
                    //switch between 3 profile icons (idk how to do it)
                }, label:{
                    Image("profileIcon")
                })
                
//                Button(action:{
//                    
//                }, label:{
//                    Text(\(theUser.username))
//                })
            }
        }
    }
}

#Preview {
    AccountSettingsView(theUser: .constant(User(username: "tempUser", bio: "tempBio", followers: 0, followingCount: 0, following: false, password: "password", archive: [])))
}
