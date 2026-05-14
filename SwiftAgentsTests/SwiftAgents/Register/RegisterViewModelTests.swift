//
//  RegisterViewModelTests.swift
//  swift-agents-skillsTests
//
//  Created by Junio Cesar Moquiuti on 14/05/26.
//

import Foundation
import XCTest
@testable import swift_agents_skills

final class RegisterViewModelTests: XCTestCase {
    // MARK: - Full Name Validation
    func testFullNameValidationRejectsEmptyAndSingleWord() {
        let vm = RegisterViewModel()

        vm.fullName = ""
        XCTAssertEqual(vm.fullNameError, "Informe seu nome completo")

        vm.fullName = "Alice"
        XCTAssertEqual(vm.fullNameError, "Digite nome e sobrenome")
    }

    func testFullNameValidationAcceptsNameAndSurname() {
        let vm = RegisterViewModel()
        vm.fullName = "Alice Silva"
        XCTAssertNil(vm.fullNameError)
    }

    func testFullNameValidationTrimsWhitespaceAndMultipleSpaces() {
        let vm = RegisterViewModel()
        vm.fullName = "   Alice    Silva   "
        XCTAssertNil(vm.fullNameError)
    }

    // MARK: - Email Validation
    func testEmailValidationRejectsEmptyAndInvalid() {
        let vm = RegisterViewModel()

        vm.email = ""
        XCTAssertEqual(vm.emailError, "Informe seu e-mail")

        vm.email = "invalid"
        XCTAssertEqual(vm.emailError, "E-mail inválido")
    }

    func testEmailValidationAcceptsValidAndUppercaseAndTrimmed() {
        let vm = RegisterViewModel()

        vm.email = "user@example.com"
        XCTAssertNil(vm.emailError)

        vm.email = "USER@EXAMPLE.COM"
        XCTAssertNil(vm.emailError)

        vm.email = "   user@example.com   "
        XCTAssertNil(vm.emailError)
    }

    // MARK: - Confirm Email Validation
    func testConfirmEmailRejectsEmptyInvalidAndMismatch() {
        let vm = RegisterViewModel()
        vm.email = "user@example.com"

        vm.confirmEmail = ""
        XCTAssertEqual(vm.confirmEmailError, "Confirme seu e-mail")

        vm.confirmEmail = "invalid"
        XCTAssertEqual(vm.confirmEmailError, "E-mail inválido")

        vm.confirmEmail = "user2@example.com"
        XCTAssertEqual(vm.confirmEmailError, "Os e-mails não coincidem")
    }

    // MARK: - Password Validation
    func testPasswordValidationRejectsEmptyAndShort() {
        let vm = RegisterViewModel()

        vm.password = ""
        XCTAssertEqual(vm.passwordError, "Informe sua senha")

        vm.password = "12345"
        XCTAssertEqual(vm.passwordError, "A senha deve ter no mínimo 6 caracteres")
    }

    func testPasswordValidationAcceptsMinimumLength() {
        let vm = RegisterViewModel()
        vm.password = "123456"
        XCTAssertNil(vm.passwordError)
    }

    // MARK: - Confirm Password Validation
    func testConfirmPasswordRejectsEmptyShortAndMismatch() {
        let vm = RegisterViewModel()
        vm.password = "123456"

        vm.confirmPassword = ""
        XCTAssertEqual(vm.confirmPasswordError, "Confirme sua senha")

        vm.confirmPassword = "12345"
        XCTAssertEqual(vm.confirmPasswordError, "A senha deve ter no mínimo 6 caracteres")

        vm.confirmPassword = "654321"
        XCTAssertEqual(vm.confirmPasswordError, "As senhas não coincidem")
    }

    func testConfirmPasswordAcceptsMatchWithMinimumLength() {
        let vm = RegisterViewModel()
        vm.password = "abcdef"
        vm.confirmPassword = "abcdef"
        XCTAssertNil(vm.confirmPasswordError)
    }

    // MARK: - isFormValid
    func testIsFormValidOnlyWhenAllFieldsValid() {
        let vm = RegisterViewModel()

        // Initially invalid
        XCTAssertFalse(vm.isFormValid)

        vm.fullName = "Alice Silva"
        vm.email = "user@example.com"
        vm.confirmEmail = "user@example.com"
        vm.password = "123456"
        vm.confirmPassword = "123456"

        XCTAssertTrue(vm.isFormValid)

        // Invalidate one field
        vm.confirmPassword = "654321"
        XCTAssertFalse(vm.isFormValid)
    }

    func testIsFormValidTrimsAndCaseInsensitiveForEmails() {
        let vm = RegisterViewModel()

        vm.fullName = "  Alice   Silva  "
        vm.email = "   user@example.com   "
        vm.confirmEmail = "USER@EXAMPLE.COM"
        vm.password = "123456"
        vm.confirmPassword = "123456"

        XCTAssertTrue(vm.isFormValid)
    }

    // MARK: - Edit Flags
    func testEditFlagsAreMarkedWhenRequested() {
        let vm = RegisterViewModel()

        vm.markFullNameAsEdited()
        vm.markEmailAsEdited()
        vm.markConfirmEmailAsEdited()
        vm.markPasswordAsEdited()
        vm.markConfirmPasswordAsEdited()

        XCTAssertTrue(vm.didEditFullName)
        XCTAssertTrue(vm.didEditEmail)
        XCTAssertTrue(vm.didEditConfirmEmail)
        XCTAssertTrue(vm.didEditPassword)
        XCTAssertTrue(vm.didEditConfirmPassword)
    }

    // MARK: - Create Account
    func testCreateAccountDoesNotCrash() {
        let vm = RegisterViewModel()
        vm.fullName = "Alice Silva"
        vm.email = "user@example.com"
        vm.confirmEmail = "user@example.com"
        vm.password = "123456"
        vm.confirmPassword = "123456"

        // Should be callable and not crash; currently prints a message
        vm.createAccount()
        XCTAssertTrue(true)
    }
}

