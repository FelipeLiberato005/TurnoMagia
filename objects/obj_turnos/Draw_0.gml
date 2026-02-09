

desenha_quadro_escolhas()

//DESENHA AS AÇÕES DO PLAYER
//ATAQUE, ITEM...
if acao_realizada == "escolhendo_acao"
{
	desenha_acoes()
}
if acao_realizada == "escolhendo_ataque"
{
	desenha_ataques()	
}

//DESENHA OS ALIADOS
desenha_batalha(global.herois)

//DESENHA OS INIMIGOS
desenha_inimigo(global.inimigo)

//DESENHA STENCIL, PARA MELHORAR A VIZUALIZAÇÃO DO ATACANTE ATUAL
if global.trava == true
{
	desenha_stencil()
}
//PARA VIZUALIZAR O ALVO ATUAL
//SERÁ DELETADO - 03/01/2026
if global.alvos == true 	vizualiza_alvo()





//DESENHA O VALOR DO TURNO, EM QUE TURNO O JOGO ESTÁ
//NADA DE MAIS
desenha_turno()


