package br.com.uninassau.back_end_springboot.controller;

import br.com.uninassau.back_end_springboot.dto.PedidoDTO;
import br.com.uninassau.back_end_springboot.service.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/pedidos")
public class PedidoController {
    @Autowired
    private final PedidoService service;

    public PedidoController(PedidoService service){
        this.service = service;
    }


    @GetMapping
    public ResponseEntity<List<PedidoDTO>> listarTodos(){
        return ResponseEntity.ok(service.listarTodos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<List<PedidoDTO>> listarPorId(@PathVariable UUID id){
        List<PedidoDTO> pedidos = service.listarPorId(id);

        return ResponseEntity.ok(pedidos);
    }

    @PostMapping
    public ResponseEntity<PedidoDTO> fazerPedido(@RequestBody PedidoDTO dto){
        PedidoDTO pedido = service.fazerPedido(dto);

        return ResponseEntity.status(HttpStatus.CREATED).body(pedido);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PedidoDTO> alterarStatus(@PathVariable UUID id, @RequestBody PedidoDTO dto){
        PedidoDTO pedidoAlterado = service.alterarStatus(id, dto);

        return ResponseEntity.ok(pedidoAlterado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable UUID id){
        service.deletar(id);

        return ResponseEntity.noContent().build();
    }
}
