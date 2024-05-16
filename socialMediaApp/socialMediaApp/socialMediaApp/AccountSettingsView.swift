//
//  AccountSettingsView.swift
//  socialMediaApp
//
//  Created by StudentAM on 4/29/24.
//

import SwiftUI

struct AccountSettingsView: View {
    //the logge din user
    @Binding var theUser: User
    //all of the users in the system
    @Binding var allUsers: [User]
    //all the posts in the system
    @Binding var allPosts: [Post]
    //the user the user wants to change to
    @State private var newUser: String = ""
    //the password the user wants to change to
    @State private var newPassword: String = ""
    //the bio the user wants to change to
    @State private var newBio: String = ""
    //keeps track of if the user wants to change the bio
    @State private var changeBio: Bool = false
    //keeps track of if changes were made
    @State var changes: Bool = false
    //keeps track if the user wants to go back
    @State var goBack: Bool = false
    //keeps track if the user wants to log out
    @State var logout: Bool = false
    
    //for going back out of a navigation path
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        //to navigate between pages
        NavigationView{
            //to see full screen if cannot
            ScrollView{
                
                //title of the page
                Text("Account")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .frame(maxWidth: 360, alignment: .topLeading)
                    .padding()
                
                //allows the user to change their profile photo
                Button(action:{
                    //changes the boolean variable that keeps track of the profile
                    theUser.personIcon.toggle()
                }, label:{
                    //if the user has a person icon
                    if theUser.personIcon{
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.black)
                            .padding()
                    }
                    //if the user has a toroise icon
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
                //prompts the user to click if they want to change their profile photo
                Text("Click To Change")
                    .font(.system(size: 10))
                    .padding(.top, -20)
                
                //prompts the user to enter a new desired username
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                //keeps track of what the user wants to change their username to
                TextField("\(theUser.username)", text: $newUser)
                //styling
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                //prompts the user to enter a password they want to change to
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                //keeps track of what the user wants to change their password to
                TextField("Change Password", text: $newPassword)
                //styling
                    .autocapitalization(.none)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                //prompts the user to look at their current bio
                Text("Bio: ")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                //the current user's bio
                Text("\(theUser.bio)")
                    .padding()
                    .frame(width: 360, alignment: .leading)
                    .border(Color.black)
                    .padding(.top, -10)
                
                //if they want to changeBio and have clicked the button, then the text editor will appear
                if changeBio{
                    //keeps track of the new bio they want to have
                    TextEditor(text: $newBio)
                        .autocapitalization(.none)
                        .frame(width: 340, height: 80)
                        .padding(10)
                        .border(Color.black)
                }
                
                //the change bio button that shows the text field and the change bio confirmation button
                if !changeBio{
                    //seperate button
                    HStack{
                        //formatting
                        Spacer()
                        Button(action:{
                            //adjusts the boolean variable
                            changeBio = true
                        }, label:{
                            //the button's appearance
                            Text("Change Bio")
                                .padding(8)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 15)
                        })
                    }
                }
                else{
                    //seperate button
                    HStack{
                        //formatting
                        Spacer()
                        Button(action:{
                            //adjusts the changeBIo boolean and updates the user's bio
                            theUser.bio = newBio
                            changeBio = false
                        }, label:{
                            //the appearance of the button
                            Text("Change Bio")
                                .padding(8)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 15)
                        })
                    }
                }
                
                HStack{
                    //save changes to account button
                    Button(action: {
                        //traverses through allUsers array
                        for p in allUsers.indices{
                            //if the yser already exists and is not blank
                            if allUsers[p].username == newUser && newUser != ""{
                                newUser = "*"
                                //updates
                                changes = true
                            }
                        }
                        if newUser != "*"{
                            //traverses through allUsers array to update the username and all of the posts
                            for i in allUsers.indices{
                                if allUsers[i].username == theUser.username{
                                    if newUser != ""{
                                        //updates the username
                                        theUser.username = newUser
                                        //traverses through posts
                                        for k in allPosts.indices{
                                            //updates the username for posts
                                            if allPosts[k].username == allUsers[i].username{
                                                allPosts[k].username = newUser
                                            }
                                            //updates the username for comments
                                            for h in allPosts[i].comments.indices{
                                                if allPosts[i].comments[h].username == allUsers[i].username{
                                                    allPosts[i].comments[h].username = newUser
                                                }
                                            }
                                        }
                                    }
                                    //updates the password
                                    if newPassword != ""{
                                        theUser.password = newPassword
                                    }
                                    //updates the bio
                                    if newBio != ""{
                                        theUser.bio = newBio
                                    }
                                    //updates the profile photo
                                    if allUsers[i].personIcon != theUser.personIcon{
                                        allUsers[i].personIcon = theUser.personIcon
                                    }
                                    //updates the allUsers array to have the updated user
                                    allUsers[i] = theUser
                                    
                                    //change boolean to display the alert
                                    changes = true
                                    
                                }
                            }
                        }
                        
                    }, label: {
                        //appearance of the button
                        Text("Save Changes")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(6)
                            .padding()
                        
                    })
                    //changes have been made alert that directs back to account
                    .alert(isPresented: $changes){
                        //couldn't update the username since the username already exists
                        if newUser == "*"{
                            Alert(
                                title: Text("Could Not Make Changes"),
                                message: Text("Username Is Already In Use"),
                                dismissButton: .default(Text("Okay")){
                                    newUser = ""
                                }
                            )
                        }
                        //if the changes were successful
                        else{
                            Alert(
                                title: Text("Changes Have Been Saved!"),
                                dismissButton:
                                    .default(Text("Return")){
                                        //goes back to account page
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                            )
                        }
                    }
                    
                    
                    //back button
                    Button(action: {
                        goBack = true
                    }, label: {
                        //appearance of the button
                        Text("Back To Account")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(6)
                            .padding()
                    })
                    //goes back to the account without changes
                    .alert(isPresented: $goBack){
                        Alert(
                            title: Text("No Changes Have Been Saved"),
                            dismissButton:
                                .default(Text("Return")){
                                    //goes back to the account page
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                        )
                    }
                }
                .padding(.top, 40)
                
                
                //logout button
                Button(action: {
                    //resets the logges in user
                    theUser = User(username: "temp", bio: "", followers: 0, followingCount: 0, following: false, password: "", archive: [], personIcon: false)
                    
                    //updating that the user does not follow anyone since not logged in
                    for q in allUsers.indices{
                        allUsers[q].following = false
                    }
                    //updates the boolean variable
                    logout = true
                }, label: {
                    //appearance of the button
                    Text("Logout")
                        .padding()
                        .padding(.horizontal, 128)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(6)
                        .padding()
                })
                //logs the user out and returns to log in page
                .alert(isPresented: $logout){
                    Alert(
                        title: Text("You Have Successfully Logged Out!"),
                        dismissButton:
                            .default(Text("Return")){
                                //goes back to home back
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    )
                }
            }
            
        }
    }
}

#Preview {
    AccountSettingsView(theUser: .constant(User(username: "tempUser", bio: "tempBio", followers: 0, followingCount: 0, following: false, password: "password", archive: [], personIcon: false)), allUsers: .constant([]), allPosts: .constant([]))
}
