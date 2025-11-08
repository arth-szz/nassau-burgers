package br.com.nassauburgers;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

@ManagedBean
@ViewScoped
public class AcompanhamentoBean implements Serializable {

    private List<Pedido> pedidos;

    public AcompanhamentoBean() {
        pedidos = new ArrayList<>();
        // Mock de 3 pedidos (fui eu, caio, que colocou isso, só pra testar)
        for (int i = 1; i <= 3; i++) {
            pedidos.add(new Pedido(
                i,
                "Hambúrguer Real",
                2,
                "R$32,90",
                "Em preparo",
                i % 2 == 0, // bacon alternado
                i % 3 == 0, // queijo alternado
                i % 4 == 0  // molho alternado
            ));
        }
    }

    public List<Pedido> getPedidos() {
        return pedidos;
    }

    // Classe interna representando um pedido
    public static class Pedido {
        private int id;
        private String sabor;
        private int quantidade;
        private String preco;
        private String status;
        private boolean bacon;
        private boolean queijo;
        private boolean molho;

        public Pedido(int id, String sabor, int quantidade, String preco, String status,
                      boolean bacon, boolean queijo, boolean molho) {
            this.id = id;
            this.sabor = sabor;
            this.quantidade = quantidade;
            this.preco = preco;
            this.status = status;
            this.bacon = bacon;
            this.queijo = queijo;
            this.molho = molho;
        }

        public int getId() { return id; }
        public String getSabor() { return sabor; }
        public int getQuantidade() { return quantidade; }
        public String getPreco() { return preco; }
        public String getStatus() { return status; }
        public boolean isBacon() { return bacon; }
        public boolean isQueijo() { return queijo; }
        public boolean isMolho() { return molho; }
    }
}