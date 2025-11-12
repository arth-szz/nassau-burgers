package br.com.nassauburgers;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import java.io.Serializable;

@ManagedBean
@SessionScoped
public class CadastroBean implements Serializable {

    private String nome;
    private String email;
    private String senha;

    public String cadastrar() {
        if (nome != null && !nome.isEmpty() &&
            email != null && !email.isEmpty() &&
            senha != null && !senha.isEmpty()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Cadastro realizado", "Seja bem-vindo!"));
            return "home?faces-redirect=true";
        } else {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Erro", "Preencha todos os campos"));
            return null;
        }
    }

    public String irLogin() {
        return "/pages/login_page.xhtml?faces-redirect=true";
    }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
}