import Testing
@testable import swift_agents_skills
import SwiftUI

@Suite("LoginViewModel")
struct LoginViewModelTests {
    @Test func emailValidationRejectsEmptyAndInvalidValues() {
        let vm = LoginViewModel()

        vm.email = ""
        #expect(vm.emailError == "Informe seu e-mail")

        vm.email = "invalid"
        #expect(vm.emailError == "E-mail inválido")
    }

    @Test func emailValidationAcceptsValidEmail() {
        let vm = LoginViewModel()
        vm.email = "user@example.com"
        #expect(vm.emailError == nil)
    }

    @Test func passwordValidationRejectsEmptyAndShort() {
        let vm = LoginViewModel()

        vm.password = ""
        #expect(vm.passwordError == "Informe sua senha")

        vm.password = "12345"
        #expect(vm.passwordError == "A senha deve ter no mínimo 6 caracteres")
    }

    @Test func passwordValidationAcceptsMinimumLength() {
        let vm = LoginViewModel()
        vm.password = "123456"
        #expect(vm.passwordError == nil)
    }

    @Test func isFormValidOnlyWhenAllValid() {
        let vm = LoginViewModel()

        // Initially invalid
        #expect(vm.isFormValid == false)

        vm.email = "user@example.com"
        vm.password = "123456"

        #expect(vm.isFormValid)
    }

    @Test func editFlagsAreMarkedWhenRequested() {
        let vm = LoginViewModel()
        vm.markEmailAsEdited()
        vm.markPasswordAsEdited()
        #expect(vm.didEditEmail)
        #expect(vm.didEditPassword)
    }
}

@Suite("LoginView")
struct LoginViewTests {
    @MainActor
    @Test func bodyCanBeBuilt() {
        let view = LoginView()
        _ = view.body
        #expect(true)
    }
}

@Suite("LoginViewModel - Extras")
struct LoginViewModelExtraTests {
    @Test func emailValidationTrimsWhitespace() {
        let vm = LoginViewModel()
        vm.email = "   user@example.com   "
        #expect(vm.emailError == nil)
    }

    @Test func emailValidationAcceptsUppercase() {
        let vm = LoginViewModel()
        vm.email = "USER@EXAMPLE.COM"
        #expect(vm.emailError == nil)
    }

    @Test func formInvalidWhenOnlyOneFieldFilled() {
        let vm = LoginViewModel()
        vm.email = "user@example.com"
        #expect(vm.isFormValid == false)
        vm.email = ""
        vm.password = "123456"
        #expect(vm.isFormValid == false)
    }

    @Test func loginDoesNotCrashWhenFormIsValid() {
        let vm = LoginViewModel()
        vm.email = "user@example.com"
        vm.password = "123456"
        // Should not throw or crash; just ensure call is possible
        vm.login()
        #expect(true)
    }
}

@Suite("LoginView - Extras")
struct LoginViewExtraTests {
    @MainActor
    @Test func viewInitializesWithCustomRegisterAction() {
        var called = false
        let view = LoginView(onRegisterTapped: { called = true })
        _ = view.body
        // We cannot tap the button without UI testing tools; ensure view builds
        #expect(called == false)
    }
}

