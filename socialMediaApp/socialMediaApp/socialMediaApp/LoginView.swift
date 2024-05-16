//
//  LoginView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/25/24.
//

import SwiftUI

struct LoginView: View {
    //the logged in user
    @Binding var myUser: User
    //all the users in the system
    @Binding var allUsers: [User]
    //all the posts in the system
    @Binding var allPosts: [Post]
    //the username entered
    @State var theUsername: String = ""
    //the password entered
    @State var thePassword: String = ""
    //boolean for if the login worked
    @State private var loginSuccessful: Bool = false
    //if the user is not logged in
    @State private var notLogin: Bool = false
    //the username the user enters to create an account
    @State private var newUsername: String = ""
    //the password the user enters to create an account
    @State private var newPassword: String = ""
    //the password the user enters to confirm their password to create an account
    @State private var confirmPassword: String = ""
    //boolean that checks if it should display alert
    @State private var noNewAcc: Bool = false
    
    //for going back out of a navigation path
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        //to navigate between pages
        NavigationView{
            //to scroll down to view the whole page
            ScrollView{
                //prompt the user to log in if they have an account
                Text("Login")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .padding(70)
                
                //prompts the user to enter their username if it exists
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                //allows the user to enter their username
                TextField("Click here to type", text: $theUsername)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                    
                //prompts the user to enter their password
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                //allows the user to enter their password
                TextField("Click here to type", text: $thePassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                //the button to log in
                Button(action: {
                    //traverses through allUsers array to check if the account exists
                    for i in allUsers.indices{
                        //if the account does exist, the log in is successful
                        if allUsers[i].username == theUsername && allUsers[i].password == thePassword{
                            myUser = allUsers[i]
                            loginSuccessful = true
                        }
                        //login is unsuccessful
                        else{
                            notLogin = true
                        }
                    }
                }, label: {
                    Spacer()
                    //the text of the button
                    Text("Login")
                        .padding(5)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                })
                //if they were not able to log in
                .alert(isPresented: $notLogin){
                    return Alert(
                        title: Text("Could Not Login: Invalid Username or Password"),
                        dismissButton: .default(Text("Retry"))
                    )
                }
                //checks if alerts should be shown
                .alert(isPresented:$loginSuccessful) {
                    //if the log in was successful
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
                
                //formatting
                Spacer()
                
                //prompts alternate route
                Text("or")
                    .padding()
                
                //prompts user to create an account
                Text("Sign Up")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .padding(30)
                
                //prompts the user to enter a desired username
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                //tracks the user's desired username
                TextField("Click here to type", text: $newUsername)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                    
                //prompts the user to create a password
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                //tracks the user's desired password
                TextField("Click here to type", text: $newPassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                //prompts the user to confirm their password
                Text("Confirm Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                //allows user to enter passwrod to confirm the previously entered one
                TextField("Click here to type", text: $confirmPassword)
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                //sign up button
                Button(action: {
                    //traverses through allUsers array
                    for k in allUsers.indices{
                        //ensures there is not a user with that username already
                        if allUsers[k].username == newUsername{
                            newUsername = "*"
                            noNewAcc = true
                        }
                    }
                    //if the passwords match, the account has been successfully created
                    if confirmPassword == newPassword{
                        let newAcc: User = User(username: newUsername, bio: "", followers: 0, followingCount: 0, following: false, password: newPassword, archive: [], personIcon: false)
                        allUsers.append(newAcc)
                        noNewAcc = true
                    }
                    //if the passwords do not match
                    else{
                        noNewAcc = true
                    }
                }, label: {
                    Spacer()
                    //text of the button
                    Text("Create Account")
                        .padding(5)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                })
                //the alert
                .alert(isPresented: $noNewAcc){
                    //if the username exists already
                    if newUsername == "*"{
                        Alert(
                            title: Text("Username already exists"),
                            message: Text("Choose a new username"),
                            dismissButton: .default(Text("Retry")){
                                //resets username textfield
                                newUsername = ""
                            }
                        )
                    }
                    //if the passwords don't match
                    else if newPassword != confirmPassword{
                        //alert for if the passwords do not match, so account could not be created
                        Alert(
                            //text of the alert
                            title: Text("Passwords do not match"),
                            //allows user to dismiss the alert
                            dismissButton: .default(Text("Retry"))
                        )
                    }
                    //if the account was successfully created
                    else{
                        Alert(
                            title: Text("Successfully Created Account!"),
                            message: Text("You Can Now Login!"),
                            dismissButton: .default(Text("Return")){
                                //resets all variables
                                newUsername = ""
                                newPassword = ""
                                confirmPassword = ""
                            }
                        )
                    }
                }
                
            }
        }
    }
}

#Preview {
    LoginView(myUser: .constant(User(username: "", bio: "", followers: 0, followingCount: 0, following: false, password: "tempPass", archive: [], personIcon: false)), allUsers: .constant([]), allPosts: .constant([]))
}
