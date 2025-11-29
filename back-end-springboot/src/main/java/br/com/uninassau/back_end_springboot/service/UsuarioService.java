package br.com.uninassau.back_end_springboot.service;

import br.com.uninassau.back_end_springboot.dto.UsuarioDTO;
import br.com.uninassau.back_end_springboot.model.Funcionario;
import br.com.uninassau.back_end_springboot.model.Usuario;
import br.com.uninassau.back_end_springboot.repository.FuncionarioRepository;
import br.com.uninassau.back_end_springboot.repository.UsuarioRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class UsuarioService {
    private final UsuarioRepository usuarioRepository;
    private final FuncionarioRepository funcionarioRepository;
    private final PasswordEncoder passwordEncoder;

    public UsuarioService(UsuarioRepository usuarioRepository, PasswordEncoder passwordEncoder, FuncionarioRepository funcionarioRepository) {
        this.usuarioRepository = usuarioRepository;
        this.passwordEncoder = passwordEncoder;
        this.funcionarioRepository = funcionarioRepository;
    }


    public List<UsuarioDTO> listarTodos() {
        List<Usuario> usuarios = usuarioRepository.findAll();

        return usuarios.stream()
                .map(this::converterParaDTO)
                .toList();
    }


    public UsuarioDTO buscarPorId(UUID id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado com ID: " + id));

        return converterParaDTO(usuario);
    }


    public UsuarioDTO cadastrar(UsuarioDTO dto) {
        if (usuarioRepository.findByEmail(dto.getEmail()).isPresent()) {
            throw new IllegalArgumentException("Este email já está cadastrado");
        }

        Usuario usuario = new Usuario();

        usuario.setNome(dto.getNome());
        usuario.setEmail(dto.getEmail());

        String senhaCriptografada = passwordEncoder.encode(dto.getSenha());
        usuario.setSenha(senhaCriptografada);

        Usuario salvo = usuarioRepository.save(usuario);

        return converterParaDTO(salvo);
    }


    public UsuarioDTO login(String email, String senha) {
        var funcionarioOpt = funcionarioRepository.findByEmail(email);
        if (funcionarioOpt.isPresent()) {
            Funcionario func = funcionarioOpt.get();
            if (passwordEncoder.matches(senha, func.getSenha())) {
                UsuarioDTO dto = new UsuarioDTO();
                dto.setId(func.getId());
                dto.setNome(func.getNome());
                dto.setEmail(func.getEmail());
                dto.setTipo("ADMIN");
                return dto;
            }
        }

        var usuarioOpt = usuarioRepository.findByEmail(email);
        if (usuarioOpt.isPresent()) {
            Usuario user = usuarioOpt.get();
            if (passwordEncoder.matches(senha, user.getSenha())) {
                return converterParaDTO(user);
            }
        }

        throw new IllegalArgumentException("Email ou senha inválidos");
    }


    public UsuarioDTO atualizar(UUID id, UsuarioDTO dto) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado com ID: " + id));

        if (dto.getNome() != null && !dto.getNome().isBlank()) {
            usuario.setNome(dto.getNome());
        }

        if (dto.getEmail() != null && !dto.getEmail().isBlank()) {
            usuario.setEmail(dto.getEmail());
        }

        if (dto.getSenha() != null && !dto.getSenha().isBlank()) {
            String novaSenhaCriptografada = passwordEncoder.encode(dto.getSenha());
            usuario.setSenha(novaSenhaCriptografada);
        }

        Usuario usuarioAtualizado = usuarioRepository.save(usuario);

        return converterParaDTO(usuarioAtualizado);
    }


    public void deletar(UUID id) {
        if (!usuarioRepository.existsById(id)) {
            throw new RuntimeException("Usuário não encontrado com ID: " + id);
        }
        usuarioRepository.deleteById(id);
    }


    private UsuarioDTO converterParaDTO(Usuario usuario) {
        UsuarioDTO dto = new UsuarioDTO();

        dto.setId(usuario.getId());
        dto.setNome(usuario.getNome());
        dto.setEmail(usuario.getEmail());
        dto.setSenha(usuario.getSenha());
        dto.setTipo("CLIENTE");

        return dto;
    }
}
