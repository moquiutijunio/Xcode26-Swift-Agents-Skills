//
//  ForgotPasswordView.swift
//  swift-agents-skills
//
//  Created by Codex on 22/04/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        let bindableViewModel = Bindable(viewModel)

        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Esqueci minha senha")
                    .font(.largeTitle.bold())

                Text("Informe seu e-mail para receber o link de recuperação.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                validatedField(
                    title: "E-mail",
                    text: bindableViewModel.email,
                    hasEdited: viewModel.didEditEmail,
                    errorMessage: viewModel.emailError,
                    autocapitalization: .never,
                    keyboardType: .emailAddress,
                    onChanged: viewModel.markEmailAsEdited
                )

                Button(action: viewModel.sendRecoveryLink) {
                    Text("Enviar link de recuperação")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!viewModel.isFormValid)
                .padding(.top, 8)

                if viewModel.didSendRequest {
                    Text("Se o e-mail estiver cadastrado, você receberá as instruções de recuperação.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
            }
            .padding()
        }
    }
}

private extension ForgotPasswordView {
    func validatedField(
        title: String,
        text: Binding<String>,
        hasEdited: Bool,
        errorMessage: String?,
        autocapitalization: TextInputAutocapitalization,
        keyboardType: UIKeyboardType,
        onChanged: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            TextField("Digite aqui", text: text)
                .textInputAutocapitalization(autocapitalization)
                .keyboardType(keyboardType)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            hasEdited && errorMessage != nil
                            ? Color.red
                            : Color.gray.opacity(0.3),
                            lineWidth: 1
                        )
                )
                .cornerRadius(10)
                .onChange(of: text.wrappedValue) { _, _ in
                    onChanged()
                }

            if hasEdited, let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
