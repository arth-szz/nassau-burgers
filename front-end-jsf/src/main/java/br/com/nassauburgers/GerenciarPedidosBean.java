package br.com.nassauburgers;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@ManagedBean
@ViewScoped
public class GerenciarPedidosBean implements Serializable {

    private List<Pedido> pedidos;

    public GerenciarPedidosBean() {
        pedidos = new ArrayList<>();
        for (int i = 1; i <= 15; i++) {
            pedidos.add(new Pedido(i, "Pendente"));
        }
    }

    public List<Pedido> getPedidos() {
        return pedidos;
    }

    public void aprovar(int id) {
        pedidos.stream()
               .filter(p -> p.getId() == id)
               .findFirst()
               .ifPresent(p -> p.setStatus("Aprovado"));
    }

    public void rejeitar(int id) {
        pedidos.stream()
               .filter(p -> p.getId() == id)
               .findFirst()
               .ifPresent(p -> p.setStatus("Rejeitado"));
    }

    public static class Pedido {
        private int id;
        private String status;

        public Pedido(int id, String status) {
            this.id = id;
            this.status = status;
        }

        public int getId() { return id; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
}