#region Limpando as Listas
//Essa função esta limpando as listas a todo momento
//Claro caso atinja a condição dentro da função limpa_lista()
global.batalha = limpa_lista(global.batalha);
global.inimigo = limpa_lista(global.inimigo);
global.herois  = limpa_lista(global.herois);
#endregion

#region condição temporizador
//CONDIÇAÕ QUE CONTROLA O TEMPORIZADOR
//QUANDO O CRONOMETRO CHEGA NO VALOR DO TEMPO ESTIPULADO
//O TURNO SERÁ PASSADO, E O ATACANTE ATUAL PODERÁ REALIZAR SSUA AÇÃO
//O TEMPO É DE 2 SEGUNDOS DE ESPERA, POREM ESTA SUJEITO A MUDANÇAS 03/01/2026
    if global.fim_animacao == false 
    {
if (!global.trava)
{
    cronometro++;

    if (cronometro >= tempo)
    {
        global.trava = true;   // libera próxima ação
        cronometro = 0;        // reseta contador
		estado_turno = "selecionar_alvo"
    }
    }
}
#endregion


#region muda ação
//METODO QUE MUDA AÇÃO DA LISTA
//BOTÕES QUE CONTROLAM A SUBIDA E DECIDA DAS AÇÕES
//NADA DE MAIS
if acao_realizada == "escolhendo_acao"
{
	muda_acao(lista_acoes)
}


if acao_realizada == "escolhendo_ataque"
{
			var usuario = turnos[0];
			var acao_escolhida = usuario.tipo_ataques
			muda_acao(acao_escolhida)
}
#endregion


//Fazendo um Cronometro para ativar o executa_acao
#region Mudando para executa_acao()


if global.fim_animacao == false
{
    if acao_realizada == "escolhendo_acao"
    {
	   if (keyboard_check_released(vk_enter) && global.trava == true)
	   {
			//show_debug_message(turnos)
	           
			executa_acao()	
			global.trava = false
	   }
    }
}
#endregion


#region realizar alguma ação
//AÇÃO QUE É REALIZADA APARTIR DE DUAS AÇÕES. SE O ENTER É PRESSIONADO E SE JA PASSOU O TEMPO DO TEMPORIZADOR
//SE ESTA DUAS COISAS FOREM TRUE, O TEMPORIZADOR COMEÇARA A RODAR, PORQUE A TRAVA FOI SELECIONADA, E O JOGADOR TERÁ QE ESPERAR 2 MIN
//EXECUTA A AÇÃO ESCOLHIDA -- SE FOI ATAQUE, ITEM, ETC
//MUDA O ESTADO DO TURNO, PARA QUE PARE DE MOSTRAR OS ALVOS QUE PODEM SEREM SELECIONADOS
//BASICAMENTE É A BASE DO COMBATE
var _info = turnos[0]

if _info.is_hero
{
	if acao_realizada == "escolhendo_ataque"
	{
		if (keyboard_check_pressed(vk_enter)  && global.trava == true)
		{
         
		      global.trava = false
		      executa_habilidades()
		      //estado_turno = "atacou_alvo"
		      acao_realizada = "escolhendo_acao" 
		//show_debug_message("Real" + string(global.batalh
		      acao_atual = 0	
            //Zerando o alpha para fazer a transição do quadro de escolhas
              alpha = 0 
		}
		
	}	
}

else if _info.is_hero == false && global.trava == true
{
		randomise()
		global.trava = false
		ia_acao()
}
#endregion

reseta_turno(global.batalha)

#region finaliza round
//SE A VARIAVEL round_finalizado FOR TRUE, OU SEJA, TODOS AS INSTANCIAS ATACARAM
//CHAMA O METODO QUE RESTAURA VELOCIDADE
//E ORDENA OS TURNOS NOVAMENTE
//POR ULTIMO A VARIAVEL round_finalizado VOLTA A SER FALSE, ESPERANDO UMA PROXIMA ROTAQÇÃO
	if (round_finalizado)
{
    
        
    global.batalha = limpa_lista(global.batalha);
    global.inimigo = limpa_lista(global.inimigo);
    global.herois  = limpa_lista(global.herois);

    // 
   // restaura_velocidade();
    restaura_velocidade()
    
    //zerando o alpha para fazer a transição do quadro de escolhas
    
    
    // 3️⃣ reordena turnos
    turnos = ordena_val(global.batalha);
    
    //show_message(array_length(global.inimigo))

    // 
    if (array_length(global.inimigo) > 0)
    {
        alvo_index = clamp(alvo_index, 0, array_length(global.inimigo) - 1);
        alvo_atual = global.inimigo[alvo_index];
    }
    else
    {
        alvo_atual = undefined;
    }

    round_finalizado = false;
}
#endregion


#region mudando alvo
//METODO QUE MUDA O ALVO QUE ESTA SENDO SELECIONADO
//BEM...É ISSO
mudar_alvo()
#endregion

//ia_acao()



show_debug_message(alpha)
fim_partida()