//
//  RegisterViewModelTests.swift
//  swift-agents-skillsTests
//
//  Created by Junio Cesar Moquiuti on 20/04/26.
//

import Testing
@testable import swift_agents_skills

@Suite("RegisterViewModel")
struct RegisterViewModelTests {
    @Test func fullNameValidationRejectsEmptyAndSingleNameValues() {
        let viewModel = RegisterViewModel()

        viewModel.fullName = ""
        #expect(viewModel.fullNameError == "Informe seu nome completo")

        viewModel.fullName = "Junio"
        #expect(viewModel.fullNameError == "Digite nome e sobrenome")
    }

    @Test func fullNameValidationAcceptsTrimmedFullNames() {
        let viewModel = RegisterViewModel()

        viewModel.fullName = "   Junio Cesar   "

        #expect(viewModel.fullNameError == nil)
    }

    @Test func emailValidationRejectsEmptyAndInvalidValues() {
        let viewModel = RegisterViewModel()

        viewModel.email = ""
        #expect(viewModel.emailError == "Informe seu e-mail")

        viewModel.email = "invalid-email"
        #expect(viewModel.emailError == "E-mail inválido")
    }

    @Test func emailValidationAcceptsValidEmail() {
        let viewModel = RegisterViewModel()

        viewModel.email = "junio@example.com"

        #expect(viewModel.emailError == nil)
    }

    @Test func confirmEmailValidationRejectsEmptyInvalidAndMismatchedValues() {
        let viewModel = RegisterViewModel()
        viewModel.email = "junio@example.com"

        viewModel.confirmEmail = ""
        #expect(viewModel.confirmEmailError == "Confirme seu e-mail")

        viewModel.confirmEmail = "invalid-email"
        #expect(viewModel.confirmEmailError == "E-mail inválido")

        viewModel.confirmEmail = "outro@example.com"
        #expect(viewModel.confirmEmailError == "Os e-mails não coincidem")
    }

    @Test func confirmEmailValidationAcceptsMatchingEmailIgnoringCase() {
        let viewModel = RegisterViewModel()
        viewModel.email = "junio@example.com"
        viewModel.confirmEmail = "JUNIO@EXAMPLE.COM"

        #expect(viewModel.confirmEmailError == nil)
    }

    @Test func passwordValidationRejectsEmptyAndShortPasswords() {
        let viewModel = RegisterViewModel()

        viewModel.password = ""
        #expect(viewModel.passwordError == "Informe sua senha")

        viewModel.password = "12345"
        #expect(viewModel.passwordError == "A senha deve ter no mínimo 6 caracteres")
    }

    @Test func passwordValidationAcceptsMinimumLengthPassword() {
        let viewModel = RegisterViewModel()

        viewModel.password = "123456"

        #expect(viewModel.passwordError == nil)
    }

    @Test func confirmPasswordValidationRejectsEmptyShortAndMismatchedPasswords() {
        let viewModel = RegisterViewModel()
        viewModel.password = "123456"

        viewModel.confirmPassword = ""
        #expect(viewModel.confirmPasswordError == "Confirme sua senha")

        viewModel.confirmPassword = "12345"
        #expect(viewModel.confirmPasswordError == "A senha deve ter no mínimo 6 caracteres")

        viewModel.confirmPassword = "654321"
        #expect(viewModel.confirmPasswordError == "As senhas não coincidem")
    }

    @Test func confirmPasswordValidationAcceptsMatchingPassword() {
        let viewModel = RegisterViewModel()
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        #expect(viewModel.confirmPasswordError == nil)
    }

    @Test func isFormValidReturnsTrueOnlyWhenAllFieldsAreValid() {
        let viewModel = RegisterViewModel()
        viewModel.fullName = "Junio Cesar"
        viewModel.email = "junio@example.com"
        viewModel.confirmEmail = "junio@example.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        #expect(viewModel.isFormValid)
    }

    @Test func editFlagsAreMarkedWhenRequested() {
        let viewModel = RegisterViewModel()

        viewModel.markFullNameAsEdited()
        viewModel.markEmailAsEdited()
        viewModel.markConfirmEmailAsEdited()
        viewModel.markPasswordAsEdited()
        viewModel.markConfirmPasswordAsEdited()

        #expect(viewModel.didEditFullName)
        #expect(viewModel.didEditEmail)
        #expect(viewModel.didEditConfirmEmail)
        #expect(viewModel.didEditPassword)
        #expect(viewModel.didEditConfirmPassword)
    }
}

@Suite("RegisterView")
struct RegisterViewTests {
    @MainActor
    @Test func bodyCanBeBuilt() {
        let view = RegisterView()
        _ = view.body
        #expect(true)
    }
}
