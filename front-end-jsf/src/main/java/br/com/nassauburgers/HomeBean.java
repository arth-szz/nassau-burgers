package br.com.nassauburgers;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

@ManagedBean
@SessionScoped
public class HomeBean implements Serializable {

    private final List<Hamburguer> hamburgueres;

    public HomeBean() {
        hamburgueres = Arrays.asList(
            new Hamburguer("resources/images/", "Hambúrguer Real", "R$32,90"),
            new Hamburguer("resources/images/", "Sertanejo Bacon", "R$34,90"),
            new Hamburguer("resources/images/", "Dourado Supreme", "R$38,90"),
            new Hamburguer("resources/images/", "Ministro Burguer", "R$49,99"),
            new Hamburguer("resources/images/", "Mr. Obesidade", "R$100,10"),
            new Hamburguer("resources/images/", "Entope Artéria", "R$149,10")
        );
    }

    public List<Hamburguer> getHamburgueres() {
        return hamburgueres;
    }

    public String irInicio() {
        return "/pages/home_page.xhtml?faces-redirect=true";
    }

    public String irPedido() {
        return "/pages/pedido_page.xhtml?faces-redirect=true";
    }

    public String irAcompanhamento() {
        return "/pages/acompanhamento_page.xhtml?faces-redirect=true";
    }

    public String irGerenciarPedidos() {
        return "/pages/gerenciar_pedidos_page.xhtml?faces-redirect=true";
    }

    public String irGerenciarUsuarios() {
        return "/pages/gerenciar_usuarios_page.xhtml?faces-redirect=true";
    }

    public String irLogin() {
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        return "/pages/login_page.xhtml?faces-redirect=true";
    }

    public static class Hamburguer {
        private final String imagePath;
        private final String nome;
        private final String preco;

        public Hamburguer(String imagePath, String nome, String preco) {
            this.imagePath = imagePath;
            this.nome = nome;
            this.preco = preco;
        }

        public String getImagePath() { return imagePath; }
        public String getNome() { return nome; }
        public String getPreco() { return preco; }
    }
}