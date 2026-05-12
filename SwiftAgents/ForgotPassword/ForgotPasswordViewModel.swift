//
//  ForgotPasswordViewModel.swift
//  swift-agents-skills
//
//  Created by Codex on 22/04/26.
//

import Foundation
import Observation

@Observable
final class ForgotPasswordViewModel {
    var email = ""
    var didEditEmail = false
    var didSendRequest = false

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

    var isFormValid: Bool {
        !email.isEmpty && emailError == nil
    }

    func markEmailAsEdited() {
        didEditEmail = true
    }

    func sendRecoveryLink() {
        guard isFormValid else {
            return
        }

        didSendRequest = true
        print("Link de recuperação enviado com sucesso")
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
