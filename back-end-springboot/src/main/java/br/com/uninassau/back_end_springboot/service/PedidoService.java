package br.com.uninassau.back_end_springboot.service;

import br.com.uninassau.back_end_springboot.dto.PedidoDTO;
import br.com.uninassau.back_end_springboot.model.Hamburguer;
import br.com.uninassau.back_end_springboot.model.Pedido;
import br.com.uninassau.back_end_springboot.model.Usuario;
import br.com.uninassau.back_end_springboot.repository.HamburguerRepository;
import br.com.uninassau.back_end_springboot.repository.PedidoRepository;
import br.com.uninassau.back_end_springboot.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class PedidoService {
    private final PedidoRepository pedidoRepository;
    private final UsuarioRepository usuarioRepository;
    private final HamburguerRepository hamburguerRepository;

    public PedidoService(PedidoRepository pedidoRepository,
                         UsuarioRepository usuarioRepository,
                         HamburguerRepository hamburguerRepository) {
        this.pedidoRepository = pedidoRepository;
        this.usuarioRepository = usuarioRepository;
        this.hamburguerRepository = hamburguerRepository;
    }


    public List<PedidoDTO> listarTodos() {
        List<Pedido> pedidos = pedidoRepository.findAll();

        return pedidos.stream()
                .map(this::converterParaDTO)
                .toList();
    }


    public List<PedidoDTO> listarPorId(UUID id) {
        List<Pedido> pedidos = pedidoRepository.findAllById(Collections.singleton(id));

        return pedidos.stream()
                .map(this::converterParaDTO)
                .toList();
    }


    public PedidoDTO fazerPedido(PedidoDTO dto) {
        Pedido novoPedido = new Pedido();

        Usuario usuario = usuarioRepository.findById(dto.getUsuarioId())
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado com ID: " + dto.getUsuarioId()));

        Hamburguer hamburguer = hamburguerRepository.findById(dto.getHamburguerId())
                .orElseThrow(() -> new IllegalArgumentException("Hamburguer não encontrado com ID: " + dto.getUsuarioId()));

        novoPedido.setUsuario(usuario);
        novoPedido.setHamburguer(hamburguer);
        novoPedido.setQuantidade(dto.getQuantidade());
        novoPedido.setBacon(dto.getBacon());
        novoPedido.setQueijo(dto.getQueijo());
        novoPedido.setMolho(dto.getMolho());
        novoPedido.setStatus(dto.getStatus());

        Pedido pedidoFeito = pedidoRepository.save(novoPedido);

        return converterParaDTO(pedidoFeito);
    }


    public PedidoDTO alterarStatus(UUID id, PedidoDTO dto) {
        System.out.println("--- DEBUG ---");
        System.out.println("Status que chegou do JSON: " + dto.getStatus());

        Pedido pedido = pedidoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pedido não encontrado com o ID :" + id));

        pedido.setStatus(dto.getStatus());

        Pedido pedidoAtualizado = pedidoRepository.save(pedido);

        return converterParaDTO(pedidoAtualizado);
    }


    public void deletar(UUID id) {
        if (!pedidoRepository.existsById(id)) {
            throw new RuntimeException("Pedido não encontrado com o ID :" + id);
        }

        pedidoRepository.deleteById(id);
    }


    private PedidoDTO converterParaDTO(Pedido pedido) {
        PedidoDTO dto = new PedidoDTO();

        dto.setId(pedido.getId());
        dto.setUsuarioId(pedido.getUsuario().getId());
        dto.setHamburguerId(pedido.getHamburguer().getId());
        dto.setQuantidade(pedido.getQuantidade());
        dto.setCreatedAt(pedido.getCreatedAt());
        dto.setBacon(pedido.getBacon());
        dto.setQueijo(pedido.getQueijo());
        dto.setMolho(pedido.getMolho());
        dto.setStatus(pedido.getStatus());

        return dto;
    }
}
