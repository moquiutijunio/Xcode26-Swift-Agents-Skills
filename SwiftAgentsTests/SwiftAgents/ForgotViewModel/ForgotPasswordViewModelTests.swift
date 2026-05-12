import Testing
@testable import swift_agents_skills

@Suite("ForgotPasswordViewModel")
struct ForgotPasswordViewModelTests {
    @Test func emailValidationRejectsEmptyAndInvalidValues() {
        let viewModel = ForgotPasswordViewModel()

        viewModel.email = ""
        #expect(viewModel.emailError == "Informe seu e-mail")

        viewModel.email = "invalid-email"
        #expect(viewModel.emailError == "E-mail inválido")
    }

    @Test func emailValidationAcceptsValidEmail() {
        let viewModel = ForgotPasswordViewModel()

        viewModel.email = "junio@example.com"

        #expect(viewModel.emailError == nil)
    }

    @Test func emailValidationTrimsWhitespace() {
        let viewModel = ForgotPasswordViewModel()

        viewModel.email = "   junho@example.com   "

        #expect(viewModel.emailError == nil)
    }

    @Test func isFormValidReturnsTrueOnlyWhenEmailIsValid() {
        let viewModel = ForgotPasswordViewModel()

        #expect(viewModel.isFormValid == false)

        viewModel.email = "junio@example.com"

        #expect(viewModel.isFormValid)
    }

    @Test func editFlagIsMarkedWhenRequested() {
        let viewModel = ForgotPasswordViewModel()

        viewModel.markEmailAsEdited()

        #expect(viewModel.didEditEmail)
    }

    @Test func sendRecoveryLinkMarksRequestAsSentOnlyWhenFormIsValid() {
        let viewModel = ForgotPasswordViewModel()

        viewModel.sendRecoveryLink()

        #expect(viewModel.didSendRequest == false)

        viewModel.email = "junio@example.com"
        viewModel.sendRecoveryLink()

        #expect(viewModel.didSendRequest)
    }
}

@Suite("ForgotPasswordView")
struct ForgotPasswordViewTests {
    @MainActor
    @Test func bodyCanBeBuilt() {
        let view = ForgotPasswordView()
        _ = view.body
        #expect(true)
    }
}
