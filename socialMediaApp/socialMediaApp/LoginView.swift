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
    @State var theUsername: String = ""
    @State var thePassword: String = ""
    @State private var loginSuccessful: Bool = false
    
    //for going back out of a navigation path
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Login or Sign Up")
                    //styling
                    .fontWeight(.bold)
                    .font(.system(size: 33))
                    .padding(70)
                
                Text("Username:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                TextField("Click here to type", text: $theUsername)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                    
                
                Text("Password:")
                    .bold()
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding()
                TextField("Click here to type", text: $thePassword)
                    .frame(width: 340, height: 20)
                    .padding(10)
                    .border(Color.black)
                
                Button(action: {
                    for i in allUsers.indices{
                        if allUsers[i].username == theUsername && allUsers[i].password == thePassword{
                            loginSuccessful = true
                        }
                        
                    }
                }, label: {
                    Text("Login")
                })
                
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
            }
        }
    }
}

#Preview {
    LoginView(myUser: .constant(User(username: "", bio: "", followers: 0, followingCount: 0, following: false, password: "tempPass", archive: [])), allUsers: .constant([]))
}
