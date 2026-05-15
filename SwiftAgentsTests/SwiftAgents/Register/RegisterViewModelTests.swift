//
//  RegisterViewModelTests.swift
//  swift-agents-skillsTests
//
//  Created by Junio Cesar Moquiuti on 14/05/26.
//

import Foundation
import Testing
@testable import swift_agents_skills

@Suite("RegisterViewModel")
struct RegisterViewModelTests {
    @Test func fullNameValidationRejectsEmptyAndSingleWord() {
        let vm = RegisterViewModel()
        vm.fullName = ""
        #expect(vm.fullNameError == "Informe seu nome completo")
        vm.fullName = "Alice"
        #expect(vm.fullNameError == "Digite nome e sobrenome")
    }

    @Test func fullNameValidationAcceptsNameAndSurname() {
        let vm = RegisterViewModel()
        vm.fullName = "Alice Silva"
        #expect(vm.fullNameError == nil)
    }

    @Test func fullNameValidationTrimsWhitespaceAndMultipleSpaces() {
        let vm = RegisterViewModel()
        vm.fullName = "   Alice    Silva   "
        #expect(vm.fullNameError == nil)
    }

    @Test func emailValidationRejectsEmptyAndInvalid() {
        let vm = RegisterViewModel()
        vm.email = ""
        #expect(vm.emailError == "Informe seu e-mail")
        vm.email = "invalid"
        #expect(vm.emailError == "E-mail inválido")
    }

    @Test func emailValidationAcceptsValidAndUppercaseAndTrimmed() {
        let vm = RegisterViewModel()
        vm.email = "user@example.com"
        #expect(vm.emailError == nil)
        vm.email = "USER@EXAMPLE.COM"
        #expect(vm.emailError == nil)
        vm.email = "   user@example.com   "
        #expect(vm.emailError == nil)
    }

    @Test func confirmEmailRejectsEmptyInvalidAndMismatch() {
        let vm = RegisterViewModel()
        vm.email = "user@example.com"
        vm.confirmEmail = ""
        #expect(vm.confirmEmailError == "Confirme seu e-mail")
        vm.confirmEmail = "invalid"
        #expect(vm.confirmEmailError == "E-mail inválido")
        vm.confirmEmail = "user2@example.com"
        #expect(vm.confirmEmailError == "Os e-mails não coincidem")
    }

    @Test func passwordValidationRejectsEmptyAndShort() {
        let vm = RegisterViewModel()
        vm.password = ""
        #expect(vm.passwordError == "Informe sua senha")
        vm.password = "12345"
        #expect(vm.passwordError == "A senha deve ter no mínimo 6 caracteres")
    }

    @Test func passwordValidationAcceptsMinimumLength() {
        let vm = RegisterViewModel()
        vm.password = "123456"
        #expect(vm.passwordError == nil)
    }

    @Test func confirmPasswordRejectsEmptyShortAndMismatch() {
        let vm = RegisterViewModel()
        vm.password = "123456"
        vm.confirmPassword = ""
        #expect(vm.confirmPasswordError == "Confirme sua senha")
        vm.confirmPassword = "12345"
        #expect(vm.confirmPasswordError == "A senha deve ter no mínimo 6 caracteres")
        vm.confirmPassword = "654321"
        #expect(vm.confirmPasswordError == "As senhas não coincidem")
    }

    @Test func confirmPasswordAcceptsMatchWithMinimumLength() {
        let vm = RegisterViewModel()
        vm.password = "abcdef"
        vm.confirmPassword = "abcdef"
        #expect(vm.confirmPasswordError == nil)
    }

    @Test func isFormValidOnlyWhenAllFieldsValid() {
        let vm = RegisterViewModel()
        #expect(vm.isFormValid == false)
        vm.fullName = "Alice Silva"
        vm.email = "user@example.com"
        vm.confirmEmail = "user@example.com"
        vm.password = "123456"
        vm.confirmPassword = "123456"
        #expect(vm.isFormValid)
        vm.confirmPassword = "654321"
        #expect(!vm.isFormValid)
    }

    @Test func isFormValidTrimsAndCaseInsensitiveForEmails() {
        let vm = RegisterViewModel()
        vm.fullName = "  Alice   Silva  "
        vm.email = "   user@example.com   "
        vm.confirmEmail = "USER@EXAMPLE.COM"
        vm.password = "123456"
        vm.confirmPassword = "123456"
        #expect(vm.isFormValid)
    }

    @Test func editFlagsAreMarkedWhenRequested() {
        let vm = RegisterViewModel()
        vm.markFullNameAsEdited()
        vm.markEmailAsEdited()
        vm.markConfirmEmailAsEdited()
        vm.markPasswordAsEdited()
        vm.markConfirmPasswordAsEdited()
        #expect(vm.didEditFullName)
        #expect(vm.didEditEmail)
        #expect(vm.didEditConfirmEmail)
        #expect(vm.didEditPassword)
        #expect(vm.didEditConfirmPassword)
    }

    @Test func createAccountDoesNotCrash() {
        let vm = RegisterViewModel()
        vm.fullName = "Alice Silva"
        vm.email = "user@example.com"
        vm.confirmEmail = "user@example.com"
        vm.password = "123456"
        vm.confirmPassword = "123456"
        vm.createAccount()
        #expect(true)
    }
}

