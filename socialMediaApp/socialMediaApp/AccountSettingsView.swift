//
//  AccountSettingsView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/29/24.
//

import SwiftUI

struct AccountSettingsView: View {
    @Binding var theUser: User
    @State private var changeIcon: Bool = false
    @State private var newUser: String = ""
    @State private var newPassword: String = ""
    @State private var newBio: String = ""
    @State private var changeBio: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Account")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .frame(maxWidth: 360, alignment: .topLeading)
                    .padding()
                
                Button(action:{
                    changeIcon.toggle()
                }, label:{
                    if changeIcon{
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.black)
                            .padding()
                    }
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
                        
                })
                
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                TextField("\(theUser.username)", text: $newUser)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                TextField("Change Password", text: $newPassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                
                Text("Current Bio: ")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                Text("\(theUser.bio)")
                    .padding()
                    .frame(width: 360, alignment: .leading)
                    .border(Color.black)
                
                HStack{
                    Spacer()
                    Button(action:{
                        changeBio = true
                    }, label:{
                        Text("Change Bio")
                            .padding(8)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 15)
                    })
                }
                if changeBio{
                    TextEditor(text: $newBio)
                        .autocapitalization(.none)
                        .frame(width: 340, height: 80)
                        .padding(10)
                        .border(Color.black)
                }
                
                Button(action: {
                    if newUser != ""{
                        theUser.username = newUser
                    }
                    if newPassword != ""{
                        theUser.password = newPassword
                    }
                }, label: <#T##() -> Label#>)
            }
        }
    }
}

#Preview {
    AccountSettingsView(theUser: .constant(User(username: "tempUser", bio: "tempBio", followers: 0, followingCount: 0, following: false, password: "password", archive: [])))
}
