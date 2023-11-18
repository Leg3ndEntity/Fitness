//
//  ModalView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI
import AuthenticationServices

class AuthManager: NSObject, ObservableObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @Published var fullName: String?
    @Published var emailAddress: String?

    func requestUserAuthentication() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Ottenere informazioni sull'utente
            fullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
            emailAddress = appleIDCredential.email
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Gestire eventuali errori
        print("Errore durante l'autenticazione con Apple ID: \(error.localizedDescription)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

struct ModalView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var authManager = AuthManager()
    
    var body: some View {
        NavigationStack{
            VStack {
                List(){
                    Section{
                        HStack(spacing: 25.0) {
                            Image(systemName: "person")
                            VStack(alignment: .leading, spacing: -2.0){
                                Text(authManager.fullName ?? "Simone Sarnataro")
                                    .fontWeight(.medium)
                                Text(authManager.emailAddress ?? "simone.sarnataro02@gmail.com")
                                    .font(.subheadline)
                                    .textContentType(.none)
                            }
                        }
                    }
                    Section{
                        NavigationLink {
                            AccountView()
                        } label: {
                            Text("Health Details")
                        }
                        Text("Change Move Goal")
                        Text("Units of Measure")
                    }
                    Section{
                        Text("Notifications")
                    }
                    Section{
                        Text("Redeem Gift Card or Code")
                        Text("Send Gift Card by Email")
                    }.foregroundColor(Color("AccentColor1"))
                    Section{
                        Text("Apple Fitness Privacy")
                    }
                    
                }
                //.environment(\.defaultMinListRowHeight, 80)
                .navigationTitle("Account")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem{
                            Button{
                                dismiss()
                            }label:{
                                Text("Done")
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor1)
                                
                            }
                        }
                })
                
                
            }
        }
            
    }
}

#Preview {
    ModalView()
}
