//
//  AccountViewModel.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
final class AccountViewModel: ObservableObject {
    // MARK: - Properties
    @AppStorage("user") private var userData: Data?
    @Published var user = User()
    @Published var alertItem: AlertItem?
    // MARK: - Methods
    /// Saves changes to the user data if the form is valid.
    func saveChanges() {
        guard isValidForm else { return }
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = AlertContext.userSaveSuccess
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    /// Retrieves the user data from storage.
    func retrieveUser() {
        guard let userData = userData else { return }
        do {
            user = try JSONDecoder().decode(User.self,
                                            from: userData)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    /// Validates the user form.
    private var isValidForm: Bool {
        guard !user.firstName.isEmpty,
              !user.lastName.isEmpty,
              !user.email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        return true
    }
}
