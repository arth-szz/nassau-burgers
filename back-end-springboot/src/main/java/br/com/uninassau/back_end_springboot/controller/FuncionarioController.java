package br.com.uninassau.back_end_springboot.controller;

import br.com.uninassau.back_end_springboot.dto.FuncionarioDTO;
import br.com.uninassau.back_end_springboot.dto.UsuarioDTO;
import br.com.uninassau.back_end_springboot.service.FuncionarioService;
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
@RequestMapping("/funcionarios")
public class FuncionarioController {
    private final FuncionarioService service;

    public FuncionarioController(FuncionarioService service){
        this.service = service;
    }



    @GetMapping
    public ResponseEntity<List<FuncionarioDTO>> listar(){
        return ResponseEntity.ok(service.listarTodos());
    }


    @GetMapping("/{id}")
    public ResponseEntity<FuncionarioDTO> buscarPorId(@PathVariable UUID id){
        FuncionarioDTO dto = service.buscarPorId(id);

        return ResponseEntity.ok(dto);
    }


    @PostMapping
    public ResponseEntity<FuncionarioDTO> cadastrar(@RequestBody FuncionarioDTO dto){
        FuncionarioDTO novoFuncionario = service.cadastrar(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(novoFuncionario);
    }


    @PutMapping("/{id}")
    public ResponseEntity<FuncionarioDTO> atualizar(@PathVariable UUID id, @RequestBody FuncionarioDTO dto){
        FuncionarioDTO funcionarioAtualizado = service.atualizar(id, dto);

        return ResponseEntity.ok(funcionarioAtualizado);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable UUID id){
        service.deletar(id);

        return ResponseEntity.noContent().build();
    }
}
