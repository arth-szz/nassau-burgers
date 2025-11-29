package br.com.uninassau.back_end_springboot.repository;

import br.com.uninassau.back_end_springboot.model.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface PedidoRepository extends JpaRepository<Pedido, UUID> {
}
