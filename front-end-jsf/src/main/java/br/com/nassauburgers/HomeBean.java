package br.com.nassauburgers;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean
@SessionScoped
public class HomeBean implements Serializable {

    public static class Hamburguer {
        private String imagePath;
        private String nome;
        private String preco;

        public Hamburguer(String imagePath, String nome, String preco) {
            this.imagePath = imagePath;
            this.nome = nome;
            this.preco = preco;
        }
        public String getImagePath() { return imagePath; }
        public String getNome() { return nome; }
        public String getPreco() { return preco; }
    }

    public List<Hamburguer> getHamburgueres() {
        return Arrays.asList(
            new Hamburguer("resources/images/hamburguer-transparente.png", "Hambúrguer Real", "R$32,90"),
            new Hamburguer("resources/images/hamburguer-transparente.png", "Sertanejo Bacon", "R$34,90"),
            new Hamburguer("resources/images/hamburguer-transparente.png", "Dourado Supreme", "R$38,90"),
            new Hamburguer("resources/images/hamburguer-transparente.png", "Ministro Burguer", "R$49,99"),
            new Hamburguer("resources/images/hamburguer-transparente.png", "Mr. Obesidade", "R$100,10"),
            new Hamburguer("resources/images/hamburguer-transparente.png", "Entope Artéria", "R$149,10")
        );
    }

    public String irPedido() {
        return "pedido.xhtml?faces-redirect=true";
    }

    public String irAcompanhamento() {
        return "acompanhamento.xhtml?faces-redirect=true";
    }

    public String irInicio() {
        return "home.xhtml?faces-redirect=true";
    }
}