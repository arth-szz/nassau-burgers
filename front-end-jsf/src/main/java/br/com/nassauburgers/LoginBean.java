package br.com.nassauburgers;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import java.io.Serializable;

@ManagedBean
@SessionScoped
public class LoginBean implements Serializable {

    private String email;
    private String senha;

    public String autenticar() {
        if ("teste@email.com".equals(email) && "12345".equals(senha)) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Login realizado", "Bem-vindo!"));
            return "home?faces-redirect=true";
        } else {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Acesso negado", "Email ou senha inválidos"));
            return null;
        }
    }

    public String irCadastro() {
        return "/pages/cadastro_page.xhtml?faces-redirect=true";
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
}