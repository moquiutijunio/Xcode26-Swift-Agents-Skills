//
//  RegisterViewModel.swift
//  swift-agents-skills
//
//  Created by Junio Cesar Moquiuti on 10/04/26.
//

import SwiftUI
import Combine

final class RegisterViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var confirmEmail = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    @Published var didEditFullName = false
    @Published var didEditEmail = false
    @Published var didEditConfirmEmail = false
    @Published var didEditPassword = false
    @Published var didEditConfirmPassword = false

    var fullNameError: String? {
        let trimmed = fullName.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            return "Informe seu nome completo"
        }

        let parts = trimmed
            .split(separator: " ")
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

        if parts.count < 2 {
            return "Digite nome e sobrenome"
        }

        return nil
    }

    var emailError: String? {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            return "Informe seu e-mail"
        }

        if !isValidEmail(trimmed) {
            return "E-mail inválido"
        }

        return nil
    }

    var confirmEmailError: String? {
        let trimmedConfirm = confirmEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedConfirm.isEmpty {
            return "Confirme seu e-mail"
        }

        if !isValidEmail(trimmedConfirm) {
            return "E-mail inválido"
        }

        if trimmedConfirm.lowercased() != trimmedEmail.lowercased() {
            return "Os e-mails não coincidem"
        }

        return nil
    }

    var passwordError: String? {
        if password.isEmpty {
            return "Informe sua senha"
        }

        if password.count < 6 {
            return "A senha deve ter no mínimo 6 caracteres"
        }

        return nil
    }

    var confirmPasswordError: String? {
        if confirmPassword.isEmpty {
            return "Confirme sua senha"
        }

        if confirmPassword.count < 6 {
            return "A senha deve ter no mínimo 6 caracteres"
        }

        if confirmPassword != password {
            return "As senhas não coincidem"
        }

        return nil
    }

    var isFormValid: Bool {
        !fullName.isEmpty &&
        !email.isEmpty &&
        !confirmEmail.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        fullNameError == nil &&
        emailError == nil &&
        confirmEmailError == nil &&
        passwordError == nil &&
        confirmPasswordError == nil
    }

    func markFullNameAsEdited() {
        didEditFullName = true
    }

    func markEmailAsEdited() {
        didEditEmail = true
    }

    func markConfirmEmailAsEdited() {
        didEditConfirmEmail = true
    }

    func markPasswordAsEdited() {
        didEditPassword = true
    }

    func markConfirmPasswordAsEdited() {
        didEditConfirmPassword = true
    }

    func createAccount() {
        print("Conta criada com sucesso")
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
