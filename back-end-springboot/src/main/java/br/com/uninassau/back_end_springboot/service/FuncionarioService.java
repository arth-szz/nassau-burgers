package br.com.uninassau.back_end_springboot.service;

import br.com.uninassau.back_end_springboot.dto.FuncionarioDTO;
import br.com.uninassau.back_end_springboot.model.Funcionario;
import br.com.uninassau.back_end_springboot.repository.FuncionarioRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class FuncionarioService {
    private final FuncionarioRepository repository;
    private final PasswordEncoder passwordEncoder;

    public FuncionarioService(FuncionarioRepository repository, PasswordEncoder passwordEncoder) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
    }


    public List<FuncionarioDTO> listarTodos() {
        List<Funcionario> funcionarios = repository.findAll();

        return funcionarios.stream()
                .map(this::converterParaDTO)
                .toList();
    }


    public FuncionarioDTO buscarPorId(UUID id) {
        Funcionario funcionario = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Funcionário não encontrado com ID: " + id));

        return converterParaDTO(funcionario);
    }


    public FuncionarioDTO cadastrar(FuncionarioDTO dto) {
        if (repository.findByEmail(dto.getEmail()).isPresent()) {
            throw new IllegalArgumentException("Este email já está cadastrado");
        }

        Funcionario funcionario = new Funcionario();

        funcionario.setNome(dto.getNome());
        funcionario.setEmail(dto.getEmail());

        String senhaCriptografada = passwordEncoder.encode(dto.getSenha());
        funcionario.setSenha(senhaCriptografada);

        Funcionario salvo = repository.save(funcionario);

        return converterParaDTO(salvo);
    }


    public FuncionarioDTO atualizar(UUID id, FuncionarioDTO dto) {
        Funcionario funcionario = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Funcionário não encontrado com ID: " + id));

        if (dto.getNome() != null && !dto.getNome().isBlank()) {
            funcionario.setNome(dto.getNome());
        }

        if (dto.getEmail() != null && !dto.getEmail().isBlank()) {
            funcionario.setEmail(dto.getEmail());
        }

        if (dto.getSenha() != null && !dto.getSenha().isBlank()) {
            String novaSenhaCriptografada = passwordEncoder.encode(dto.getSenha());
            funcionario.setSenha(novaSenhaCriptografada);
        }

        Funcionario funcionarioAtualizado = repository.save(funcionario);

        return converterParaDTO(funcionarioAtualizado);
    }


    public void deletar(UUID id) {
        if (!repository.existsById(id)) {
            throw new RuntimeException("Funcionário não encontrado com o ID :" + id);
        }
        repository.deleteById(id);
    }


    private FuncionarioDTO converterParaDTO(Funcionario funcionario) {
        FuncionarioDTO dto = new FuncionarioDTO();

        dto.setId(funcionario.getId());
        dto.setNome(funcionario.getNome());
        dto.setEmail(funcionario.getEmail());
        dto.setSenha(funcionario.getSenha());

        return dto;
    }
}
