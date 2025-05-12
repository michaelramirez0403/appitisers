//
//  AccountView.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField: Hashable {
        case firstName
        case lastName
        case email
    }
    var body: some View {
        NavigationView {
            Form {
                PersonalInfoSection(viewModel: viewModel, focusedTextField: $focusedTextField)
                RequestsSection(viewModel: viewModel)
            }
            .navigationTitle("🤣 Account")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") { focusedTextField = nil }
                }
            }
        }
        .onAppear {
            viewModel.retrieveUser()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}
// MARK: - PersonalInfoSection Subview
struct PersonalInfoSection: View {
    @ObservedObject var viewModel: AccountViewModel
    @FocusState.Binding var focusedTextField: AccountView.FormTextField?
    var body: some View {
        Section(header: Text("Personal Info")) {
            TextField("First Name",
                      text: $viewModel.user.firstName)
                .focused($focusedTextField,
                         equals: .firstName)
                .onSubmit { focusedTextField = .lastName }
                .submitLabel(.next)
            TextField("Last Name",
                      text: $viewModel.user.lastName)
                .focused($focusedTextField,
                         equals: .lastName)
                .onSubmit { focusedTextField = .email }
                .submitLabel(.next)
            TextField("Email",
                      text: $viewModel.user.email)
                .focused($focusedTextField,
                         equals: .email)
                .onSubmit { focusedTextField = nil }
                .submitLabel(.continue)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            DatePicker("Birthday",
                       selection: $viewModel.user.birthdate,
                       in: Date().oneHundredTenYearsAgo...Date().eighteenYearsAgo,
                       displayedComponents: .date)
            Button {
                viewModel.saveChanges()
            } label: {
                Text("Save Changes")
            }
        }
    }
}
// MARK: - RequestsSection Subview
struct RequestsSection: View {
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        Section(header: Text("Requests")) {
            Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
            Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
        }
        .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
    }
}
// MARK: - Previews
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
