package br.com.uninassau.back_end_springboot.controller;

import br.com.uninassau.back_end_springboot.dto.HamburguerDTO;
import br.com.uninassau.back_end_springboot.service.HamburguerService;
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
@RequestMapping("/hamburgueres")
public class HamburguerController {
    private final HamburguerService service;

    public HamburguerController(HamburguerService service) {
        this.service = service;
    }



    @GetMapping
    public ResponseEntity<List<HamburguerDTO>> listar() {
        List<HamburguerDTO> hamburgueres = service.listarTodos();

        return ResponseEntity.ok(hamburgueres);
    }


    @GetMapping("/{id}")
    public ResponseEntity<HamburguerDTO> buscarPorId(@PathVariable UUID id){
        HamburguerDTO hamburguer = service.buscarPorId(id);

        return ResponseEntity.ok(hamburguer);
    }


    @PostMapping
    public ResponseEntity<HamburguerDTO> salvar(@RequestBody HamburguerDTO dto) {
        HamburguerDTO novoHamburguer = service.salvar(dto);

        return ResponseEntity.status(HttpStatus.CREATED).body(novoHamburguer);
    }


    @PutMapping("/{id}")
    public ResponseEntity<HamburguerDTO> atualizar(@PathVariable UUID id, @RequestBody HamburguerDTO dto){
        HamburguerDTO hamburguerAtualizado = service.atualizar(id, dto);

        return ResponseEntity.ok(hamburguerAtualizado);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable UUID id){
        service.deletar(id);

        return ResponseEntity.noContent().build();
    }
}
