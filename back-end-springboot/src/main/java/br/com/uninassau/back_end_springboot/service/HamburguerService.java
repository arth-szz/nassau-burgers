package br.com.uninassau.back_end_springboot.service;

import br.com.uninassau.back_end_springboot.dto.HamburguerDTO;
import br.com.uninassau.back_end_springboot.model.Hamburguer;
import br.com.uninassau.back_end_springboot.repository.HamburguerRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class HamburguerService {
    private final HamburguerRepository repository;

    public HamburguerService(HamburguerRepository repository) {
        this.repository = repository;
    }



    public List<HamburguerDTO> listarTodos() {
        List<Hamburguer> hamburgueres = repository.findAll();

        return hamburgueres.stream()
                .map(this::converterParaDTO)
                .toList();
    }

    public HamburguerDTO buscarPorId(UUID id){
        Hamburguer hamburguer = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Hamburguer não encontrado com o ID: " + id));

        return converterParaDTO(hamburguer);
    }


    public HamburguerDTO salvar(HamburguerDTO dto) {
        if(repository.existsByNome(dto.getNome())){
            throw new IllegalArgumentException("Esse hamburguer já existe!");
        }

        Hamburguer hamburguer = new Hamburguer();
        hamburguer.setNome(dto.getNome());
        hamburguer.setPreco(dto.getPreco());

        Hamburguer salvo = repository.save(hamburguer);

        return converterParaDTO(salvo);
    }


    public HamburguerDTO atualizar(UUID id, HamburguerDTO dto){
        Hamburguer hamburguer = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Hamburguer não encontrado com o ID: " + id));

        hamburguer.setNome(dto.getNome());
        hamburguer.setPreco(dto.getPreco());

        Hamburguer hamburguerAtualizado = repository.save(hamburguer);

        return converterParaDTO(hamburguerAtualizado);
    }


    public void deletar(UUID id){
        if (!repository.existsById(id)){
            throw new RuntimeException("Hamburguer não encontrado com o ID: " + id);
        }
        repository.deleteById(id);
    }


    private HamburguerDTO converterParaDTO(Hamburguer hamburguer) {
        HamburguerDTO dto = new HamburguerDTO();
        dto.setId(hamburguer.getId());
        dto.setNome(hamburguer.getNome());
        dto.setPreco(hamburguer.getPreco());
        return dto;
    }
}
