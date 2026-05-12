//
//  RegisterView.swift
//  swift-agents-skills
//
//  Created by Junio Cesar Moquiuti on 10/04/26.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Criar conta")
                    .font(.largeTitle.bold())

                Group {
                    validatedField(
                        title: "Nome completo",
                        text: $viewModel.fullName,
                        hasEdited: viewModel.didEditFullName,
                        errorMessage: viewModel.fullNameError,
                        autocapitalization: .words,
                        keyboardType: .default,
                        onChanged: viewModel.markFullNameAsEdited
                    )

                    validatedField(
                        title: "E-mail",
                        text: $viewModel.email,
                        hasEdited: viewModel.didEditEmail,
                        errorMessage: viewModel.emailError,
                        autocapitalization: .never,
                        keyboardType: .emailAddress,
                        onChanged: viewModel.markEmailAsEdited
                    )

                    validatedField(
                        title: "Confirmar e-mail",
                        text: $viewModel.confirmEmail,
                        hasEdited: viewModel.didEditConfirmEmail,
                        errorMessage: viewModel.confirmEmailError,
                        autocapitalization: .never,
                        keyboardType: .emailAddress,
                        onChanged: viewModel.markConfirmEmailAsEdited
                    )

                    secureValidatedField(
                        title: "Senha",
                        text: $viewModel.password,
                        hasEdited: viewModel.didEditPassword,
                        errorMessage: viewModel.passwordError,
                        onChanged: viewModel.markPasswordAsEdited
                    )

                    secureValidatedField(
                        title: "Confirmar senha",
                        text: $viewModel.confirmPassword,
                        hasEdited: viewModel.didEditConfirmPassword,
                        errorMessage: viewModel.confirmPasswordError,
                        onChanged: viewModel.markConfirmPasswordAsEdited
                    )
                }

                Button(action: viewModel.createAccount) {
                    Text("Criar conta")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!viewModel.isFormValid)
                .padding(.top, 8)
            }
            .padding()
        }
    }
}

private extension RegisterView {
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

    func secureValidatedField(
        title: String,
        text: Binding<String>,
        hasEdited: Bool,
        errorMessage: String?,
        onChanged: @escaping () -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            SecureField("Digite aqui", text: text)
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
    RegisterView()
}
