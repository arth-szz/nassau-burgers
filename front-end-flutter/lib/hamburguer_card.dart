import 'package:flutter/material.dart';
import 'package:nassau_burgers/constantes.dart';

class HamburguerCard extends StatelessWidget {
  final String imagePath;
  final String nome;
  final String preco;

  const HamburguerCard({
    super.key,
    required this.imagePath,
    required this.nome,
    required this.preco,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: nassauBlack,
        border: Border.all(
          color: nassauGold,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(nome, style: styleNomeHamburguer),
          const SizedBox(height: 8),
          Text(preco, style: stylePrecoHamburguer),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
