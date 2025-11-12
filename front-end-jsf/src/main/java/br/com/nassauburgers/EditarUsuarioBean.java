package br.com.nassauburgers;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import java.io.Serializable;

@ManagedBean
@ViewScoped
public class EditarUsuarioBean implements Serializable {

    private String nome;
    private String senha;

    public String salvar() {
        if (nome != null && !nome.isEmpty() &&
            senha != null && !senha.isEmpty()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Usuário atualizado", "Alterações salvas com sucesso"));
            return "gerenciar_usuarios?faces-redirect=true";
        } else {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Erro", "Preencha todos os campos"));
            return null;
        }
    }

    public String irGerenciarUsuarios() {
        return "/pages/gerenciar_usuarios_page.xhtml?faces-redirect=true";
    }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
}