package br.com.nassauburgers;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

@ManagedBean
@ViewScoped
public class PedidoBean implements Serializable {
    private String hamburguerSelecionado;
    private boolean adicionarBacon;
    private boolean adicionarQueijo;
    private boolean adicionarMolho;
    private int quantidade;

    public List<String> getOpcoesHamburguer() {
        return Arrays.asList("Hambúrguer Real", "Sertanejo Bacon", "Dourado Supreme",
                             "Ministro Burguer", "Mr. Obesidade", "Entope Artéria");
    }

    public String getPrecoSelecionado() {
        if ("Hambúrguer Real".equals(hamburguerSelecionado)) return "R$32,90";
        if ("Sertanejo Bacon".equals(hamburguerSelecionado)) return "R$34,90";
        if ("Dourado Supreme".equals(hamburguerSelecionado)) return "R$38,90";
        if ("Ministro Burguer".equals(hamburguerSelecionado)) return "R$49,99";
        if ("Mr. Obesidade".equals(hamburguerSelecionado)) return "R$100,10";
        if ("Entope Artéria".equals(hamburguerSelecionado)) return "R$149,10";
        return "R$--,--";
    }

    public String finalizarCompra() {
        return "acompanhamento.xhtml?faces-redirect=true";
    }

    public String getHamburguerSelecionado() { return hamburguerSelecionado; }
    public void setHamburguerSelecionado(String h) { this.hamburguerSelecionado = h; }

    public boolean isAdicionarBacon() { return adicionarBacon; }
    public void setAdicionarBacon(boolean b) { this.adicionarBacon = b; }

    public boolean isAdicionarQueijo() { return adicionarQueijo; }
    public void setAdicionarQueijo(boolean q) { this.adicionarQueijo = q; }

    public boolean isAdicionarMolho() { return adicionarMolho; }
    public void setAdicionarMolho(boolean m) { this.adicionarMolho = m; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int q) { this.quantidade = q; }
}