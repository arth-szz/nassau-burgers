package br.com.uninassau.back_end_springboot.dto;

import br.com.uninassau.back_end_springboot.model.StatusPedido;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PedidoDTO {
    private UUID id;
    private UUID usuarioId;
    private UUID hamburguerId;
    private Integer quantidade;
    private LocalDateTime createdAt;
    private Boolean bacon;
    private Boolean queijo;
    private Boolean molho;
    private StatusPedido status;
}
