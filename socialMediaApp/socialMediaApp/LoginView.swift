//
//  LoginView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var myUser: User
    @Binding var allUsers: [User]
    @Binding var allPosts: [Post]
    @State var theUsername: String = ""
    @State var thePassword: String = ""
    @State private var loginSuccessful: Bool = false
    @State private var notLogin: Bool = false
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var noNewAcc: Bool = false
    
    //for going back out of a navigation path
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Login")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .padding(70)
                
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                TextField("Click here to type", text: $theUsername)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                    
                
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                TextField("Click here to type", text: $thePassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                Button(action: {
                    for i in allUsers.indices{
                        if allUsers[i].username == theUsername && allUsers[i].password == thePassword{
                            myUser = allUsers[i]
                            loginSuccessful = true
                        }
                        else{
                            notLogin = true
                        }
                    }
                }, label: {
                    Spacer()
                    
                    Text("Login")
                        .padding(5)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                })
                
                Spacer()
                
                Text("or")
                    .padding()
                Text("Sign Up")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .padding(30)
                
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                TextField("Click here to type", text: $newUsername)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                    
                
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                TextField("Click here to type", text: $newPassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                Text("Confirm Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                TextField("Click here to type", text: $confirmPassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                Button(action: {
                    for i in allUsers.indices{
                        if allUsers[i].username == newUsername{
                            noNewAcc = true
                        }
                        else if confirmPassword == newPassword{
                            let newAcc: User = User(username: newUsername, bio: "", followers: 0, followingCount: 0, following: false, password: newPassword, archive: [])
                            allUsers.append(newAcc)
                        }
                        else{
                            noNewAcc = true
                        }
                    }
                }, label: {
                    Spacer()
                    
                    Text("Create Account")
                        .padding(5)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                })
                
                //why are my alerts not showing up
                //checks if alerts should be shown
                .alert(isPresented:$loginSuccessful) {
                    //note has been added alert
                    return Alert(
                        //the text of the alert
                        title: Text("Login Successful"),
                        dismissButton:
                            //directs the user back to the home page
                            .default(Text("Return")) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
                
                //why are my alerts not showing up
                .alert(isPresented: $notLogin){
                    return Alert(
                        title: Text("Could Not Login: Invalid Username or Password"),
                        dismissButton: .default(Text("Retry"))
                    )
                }
                
                .alert(isPresented: $noNewAcc){
                    if newUsername == ""{
                        //note has been added alert
                        return Alert(
                            //the text of the alert
                            title: Text("Username already exists"),
                            message: Text("Choose a new username"),
                            dismissButton: .default(Text("Retry"))
                        )
                    }
                    else if newPassword != confirmPassword{
                        //alert for if the passwords do not match, so account could not be created
                        return Alert(
                            //text of the alert
                            title: Text("Passwords do not match"),
                            //allows user to dismiss the alert
                            dismissButton: .default(Text("Retry"))
                        )
                    }
                    else{
                        return Alert(
                            title: Text("Created Account!"),
                            dismissButton:
                                .default(Text("Return")){
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                        )
                    }
                }
                
            }
        }
    }
}

#Preview {
    LoginView(myUser: .constant(User(username: "", bio: "", followers: 0, followingCount: 0, following: false, password: "tempPass", archive: [])), allUsers: .constant([]), allPosts: .constant([]))
}
