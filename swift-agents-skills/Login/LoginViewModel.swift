//
//  LoginViewModel.swift
//  swift-agents-skills
//
//  Created by Junio Cesar Moquiuti on 10/04/26.
//

import Foundation
import Observation

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""

    var didEditEmail = false
    var didEditPassword = false

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

    var passwordError: String? {
        if password.isEmpty {
            return "Informe sua senha"
        }

        if password.count < 6 {
            return "A senha deve ter no mínimo 6 caracteres"
        }

        return nil
    }

    var isFormValid: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        emailError == nil &&
        passwordError == nil
    }

    func markEmailAsEdited() {
        didEditEmail = true
    }

    func markPasswordAsEdited() {
        didEditPassword = true
    }

    func login() {
        print("Login realizado com sucesso")
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
