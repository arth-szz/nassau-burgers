package br.com.nassauburgers;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@ManagedBean
@ViewScoped
public class GerenciarUsuariosBean implements Serializable {

    private List<Usuario> usuarios;

    public GerenciarUsuariosBean() {
        usuarios = new ArrayList<>();
        for (int i = 1; i <= 10; i++) {
            usuarios.add(new Usuario(i, "Usuário " + i));
        }
    }

    public List<Usuario> getUsuarios() {
        return usuarios;
    }

    public String editar(int id) {
        return "editar_usuario?faces-redirect=true&includeViewParams=true";
    }

    public void excluir(int id) {
        usuarios.removeIf(u -> u.getId() == id);
    }

    public static class Usuario {
        private int id;
        private String nome;

        public Usuario(int id, String nome) {
            this.id = id;
            this.nome = nome;
        }

        public int getId() { return id; }
        public String getNome() { return nome; }
    }
}