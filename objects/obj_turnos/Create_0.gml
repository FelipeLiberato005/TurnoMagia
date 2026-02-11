   alpha = 0
//LISTA COM AS AÇÕES DO PLAYER
//SUPER IMPORTANTE

lista_acoes = ["Ataque", "Especial", "Item"]
//lista_2 = ["fogo", "agua", "gelo"]

//CHECA SE O ROUND FOI FINALIZADADO
round_finalizado = false;

//Varivel para controlar em qual lista que esta no momento
acao_realizada = "escolhendo_acao"


//ESQUECI PARA QUE SERVE, POREM, VOU MATE-LAS, ATÉ LEMBRAR PARA QUE CRIEI-AS
//PROVAVELMENTE DE IDEIAS QUE DERAM ERRADO E ESQUECI DE DELETA-LAS
//HAHAHAHA
#region ?
estado = noone
cronometro = 0
tempo = 300
turnos = []
fazer = false
#endregion

//tempo de espera para assionar a tecla
tempo_1 = 300
cronometro_1 = 0
tempo_espera = false

//VARIAVEIS QUE CONTROLA O TEMPO ANTES DE CADA AÇÃO
 #region temporizador
tempo = room_speed * 1
cronometro = 0
#endregion
 
//VARIAVES DE CONTROLE DE TURNO
#region Seleção de alvos
alvo_index = 0
alvo_atual = undefined
estado_turno = "selecionar_alvo"
#endregion

//ESSAS DUAS SÃO DE CONTROLES
#region botões
//CHECANDO BOTÕES
up = noone
down = noone
#endregion
#region Controles
//selecionar = keyboard_check(vk_enter)
up = keyboard_check_pressed(ord("W"))
down = keyboard_check_pressed(ord("S"))
#endregion

//DESENHA O TURNO EM QUE O JOGO ESTA
//NADA DE MAIS POR ENQUANTO... É SÓ UM NUMERO QUE MUDA QUANDO O TURNO RESETA
desenha_turno = function()
{
	draw_set_font(fnt_turno)
	draw_text(320, 150, global.reseta_turnos)
	draw_set_font(-1)
}

//RESETA O TURNO
//MUDA O VALOR DO TURNO EM +1, E ZERA A VELOCIDADE DOS PERSONAGENS QUE REALIZAM OS ATAQUES
reseta_turno = function(_lista) 
{
         
		var total = array_length(_lista)
		var sem_vel = 0
		
		for (var i = 0; i < total; i++)
		{
			
            
			if _lista[i].vel_atual <= 0
			{
				sem_vel++
				
			}
		}
		
		if sem_vel == total
		{
			global.reseta_turnos += 1;	
			global.passei = true
            round_finalizado = true
		}
}

//RESTAURA A VELOCIDADE BASE DOS PERSONAGENS
//SUPUNHAMOS QUE O TODOS OS PERSONAGES DA BATALHA, SEJA INIMIGO E ALIADOS ESTEJAM ZERADOS, OU SEJA FEZ SEU ATAQUE
//ELE RESETA A VELCOCIDADE, ELE PEGA O VALOR DA vel_atual DELE E SUBSTITUI PELO vel_base VALOR DADO NO STRUCT
restaura_velocidade = function()
{
	if (!global.passei) return;

    var qtd = array_length(global.batalha);

    for (var i = 0; i < qtd; i++)
    {
        var _info = global.batalha[i];
        _info.vel_atual = _info.vel_base;
        global.passei = false;	
    }

    
		
}

acao_atual = 0


//DESESENHA AS AÇÕES QUE O JOGADOR PODERÁ FAZER, NA TELA. TIRADO DA LISTA DE AÇÕES
desenha_acoes = function()
{
        var info = turnos[0]
		draw_set_font(fnt_herois)
		
    
		var _qtd = array_length(lista_acoes)
		for(var i = 0; i < _qtd;i++)
		{
		var _cor = c_white
		var _marg = 0
		//Definindo posicão
		var _x = 0
        var _y = 0
            
		if acao_atual == i
		{
			_cor = c_red	
			_marg = 5
		}
		
        
            
        if instance_exists(info.heroi) && info.is_hero != false
        {    
		  _x = info.heroi.x//175 + i * 65;
		  _y = info.heroi.y + i * 15;
        }
		
		draw_set_color(_cor)
		draw_text(_x - 60  + _marg , (_y - 50), lista_acoes[i])
		}
		
		draw_set_color(-1)
		draw_set_font(-1)
		
		
}

//DESENHA  OS PERSONAGENS ALIADOS DO PLAYER QUE APARECERÁ NO JOGO, TIRADO DA LISTA GLOBAL GLOBAL.PERSONAGENS[] NO SCRIPT
//POR ENQUANTO DESENHA O NOME, VELOCIDADE, MANA E ETC... 03/01/2026
desenha_batalha = function(_lista)
{
	
	draw_set_font(fnt_painel)
	var _qtd = array_length(_lista)
	
	
	
	for (var i = 0; i < _qtd; i++)
	{
		
		
		
		//var _x1 = 60
		//var _y1 = 20 + (i * 42);
		//var _x2 = _x1 + 150
		//var _y2 = _y1 + 32
		
		
		var _info = _lista[i]
		 
		
		
		
			if i < 2
			{
					var _x = 250
					var _y = 150 + (i * 85)
                   
               
			}
			else
			{
					var _x = 160
					var _y = 100 + ((i - 2) * 85)
			}
			

			if !instance_exists(_info.heroi)
			{
				instance_create_layer(_x, _y, layer, _info.heroi)
				
			}
		
			
		
		var x_personagem = _info.heroi.x
		var y_personagem = _info.heroi.y
		_info.controla_vida.desenha_vida(x_personagem - 8 , y_personagem - 20, 20, 2, c_green, c_red,c_white)
	     draw_text(x_personagem - 8, y_personagem - 30, "Mana: " +string(_info.mana))  
		
	}
	draw_set_font(-1)
}


fim_partida = function()
{
    var inimigo = array_length(global.inimigo)
    var aliado = array_length(global.herois)
    
    if inimigo <= 0
    {
        show_message("Fim da Partida!")
        game_end()
    }
    
    
    
    if aliado <= 0
    {
        show_message("Fim da Partida!")
        game_end()
    }
    
    
}

//MUDA AS AÇÕES DO JOGADOR, NA LISTA DE AÇÕES
muda_acao = function(_lista)
{
	if (keyboard_check_pressed(vk_down)) acao_atual++;
								
	if (keyboard_check_pressed(vk_up)) acao_atual--;	
	
	var _qtd = array_length(_lista)
	
	acao_atual = clamp(acao_atual, 0, _qtd-1)
}


desenha_quadro_escolhas = function()
{
  
    var info = turnos[0]
    
    var _x = 0
    var _y = 0
    
    if instance_exists(info.heroi) && info.is_hero != false
    {
        _x = info.heroi.x
        _y = info.heroi.y - 10
        
        draw_set_color(make_colour_rgb(0,0,0))
        draw_set_alpha(alpha) 
        draw_rectangle(_x - 60, _y - 50, (_x + 55) - 55,(_y + 65) - 50, false)	
        draw_set_color(make_colour_rgb(255,255,255))
    }
 
      if alpha < 1
{
    alpha += 0.01
}
}


//ESCOLHE QUAL TIPO DE AÇÃO ELE VAI QUERER REALIZAR
//ATAQUE OU ITENS
executa_acao = function()
{
    var _info = turnos[0];

if _info.is_hero
		{
    switch (acao_atual)
    {
		
        case 0:
			acao_realizada = "escolhendo_ataque"
			global.alvos = true
        break;
		
    }
	}
}


//EXECUTA AS AÇÕES DOS PERSONAGENS
//EXEMPLO O JOGADOR SELECIONA ATAQUE = PERSONAGEM ATACA 
//ITEM = ABRE ABA DE ITENS
//TAMBEM CUIDA DOS TURNOS DE AÇÃO DOS PERSONAGENS, ATRAVES DO GLOBAL.BATALHA[] NO SCRIPT
//ESCOLHENDO ATAQUS DO PLAYER NA LITA DO CONSTRUCT
executa_habilidades = function()
{
    if (round_finalizado) return;

    var atual = turnos[0];
	
if atual.is_hero
		{
  			
            
            
            atual.heroi.image_index = 0;
            
            
			
			var usuario = turnos[0];
			var acao_escolhida = usuario.tipo_ataques[acao_atual]; // depois vem do menu
			
			executa_habilidade(usuario, alvo_atual, acao_escolhida)
			global.alvos = false
            
            if global.true_mana == true
            {
                atual.vel_atual = 0;
                global.true_mana = false
            }
            controlando_vida(); // só marca morto = true
            
            //array_delete(turnos, 0, 1);
            //array_push(turnos, atual);
            
        
        global.batalha = limpa_lista(global.batalha);
        global.inimigo = limpa_lista(global.inimigo);
        global.herois  = limpa_lista(global.herois);    
            
            

// reordena por velocidade 
        turnos = ordena_val(turnos);    
        reseta_turno(global.batalha);

        //if (global.passei)
        //{
            //round_finalizado = true;
            //return;
        //}
	   }
    
    //show_message(_info.vel_atual)
}

//Metodo para desenhar lista de atques unicos de cada personagem
//Aramazenado no construtor
desenha_ataques = function()
{
	draw_set_font(fnt_ataques)
		var info = turnos[0]
		usuario = turnos[0]
		var ataques = usuario.tipo_ataques
		var _qtd = array_length(ataques)
		for(var i = 0; i < _qtd;i++)
		{
		var _cor = c_white
		var _marg = 0
		//Definindo posicão
		var _x = 0
        var _y = 0
            
            
        if instance_exists(info.heroi) && info.is_hero != false
        {    
		  _x = info.heroi.x//175 + i * 65;
		  _y = info.heroi.y + i * 15;
        }    
            
		if acao_atual == i
		{
			_cor = c_red	
			_marg = 5
		}
		
		
		
		
		var atk = ataques[i]
		draw_set_color(_cor)
		draw_text((_x - 60) + _marg, (_y - 50), atk.nome)
         draw_text((_x - 25) + _marg, (_y - 50), "("+string(atk.mana)+")")    
		}
		
		draw_set_color(-1)
		draw_set_font(-1)
		
}

//DESENHA OS INIMIGOS DAQUELA FASE
//POR ENQUANTO DESENHA O NOME, VELOCIDADE, MANA E ETC... 03/01/2026
desenha_inimigo = function(_lista)
{
	
	draw_set_font(fnt_painel)
	var _qtd = array_length(_lista)
	
	
	
	for (var i = 0; i < _qtd; i++)
	{
		
		
		//var _x1 = 60
		//var _y1 = 20 + (i * 42);
		//var _x2 = _x1 + 150
		//var _y2 = _y1 + 32
		
		
		var _info = _lista[i]
		 
		
	     
		 
		 	if i < 2
			{
					var _x = 500
					var _y = 150 + (i * 85)
			}
			else
			{
					var _x = 590
					var _y = 100 + ((i - 2) * 85)
			}
		 
			
		//show_message(_info.x)
		
		//draw_sprite(_info.spr, 0, _x2 - 31, _y1)
		//draw_sprite_ext(_info.spr, 0, _x2 - 31, _y1, 1, 1, 1, c_white, 1)
		//draw_text(_x1 + 50, _y1, vida)
		
		
		if !instance_exists(_info.heroi)
		{
			var inimigo = instance_create_layer(_x, _y, layer, _info.heroi)	
            inimigo.image_xscale = -1
		}
		
		 
		
		var x_personagem = _info.heroi.x
		var y_personagem = _info.heroi.y
		_info.controla_vida.desenha_vida(x_personagem - 8 , y_personagem - 20, 20, 2, c_green, c_red,c_white)

		
		
	}
	draw_set_font(-1)
}
	
	
controlando_vida = function()
{
    for (var i = array_length(turnos) - 1; i >= 0; i--)
    {
        var _p = turnos[i];

        if (_p.controla_vida.vida <= 0 && !_p.morto)
        {
            _p.morto = true;

            // remove da ordem de turnos
            array_delete(turnos, i, 1);

            // opcional: remover do campo
            if (instance_exists(_p.heroi))
            {
                with (_p.heroi) instance_destroy();
            }
        }
    }
}




//DESENHA O STENCIL, DESTACA O PERSONAGEM QUE ESTÁ EM SUA VEZ DO TURNO
desenha_stencil = function()
{
	var _info = turnos[0]
	
	ativar_stencil(_info.heroi)
}

#region CONSTRUINDO A IA
//IA realizando ação
ia_acao = function()
{
	 if (round_finalizado) return;
			
			
			var _info = turnos[0]
			_info.vel_atual = 0;
            _info.heroi.image_index = 0;
            var _ia = array_length(global.herois)
			var _ia_aleatorio = irandom(_ia - 1)
			alvo_ia = global.herois[_ia_aleatorio]	
			
			var usuario = turnos[0];
			var acao_escolhida = usuario.tipo_ataques[0]; // depois vem do menu
			
			executa_ia(usuario, alvo_ia, acao_escolhida)
			//show_message(_ia_aleatorio)
    
            //array_delete(turnos, 0, 1);
            //array_push(turnos, _info);
	
    
        global.batalha = limpa_lista(global.batalha);
        global.inimigo = limpa_lista(global.inimigo);
        global.herois  = limpa_lista(global.herois);
        
        turnos = limpa_lista(turnos); 

// reordena por velocidade 
    turnos = ordena_val(turnos);
    //reseta_turno(global.batalha);

    // SE TODOS JÁ AGIRAM
    //if (global.passei)
    //{
        //round_finalizado = true;
        //return; // impede novo ataque
    //}
    
}

ia_alvo = function()
{
	
			
		
			
}
#endregion


//LUGAR ONDE CONTROLA A SELEÇÃO DO ALVO
#region Alvos Selecionados


//MUDA O ALVO SELECIONADO, ATRAVEZ DA LISTA DE INIMIGO
//ESSA SELEÇÃO ACONTECE PELO INDEX DA LISTA, POR ENQUANTO POSSO MUDAR ELE COM O "W" E "S"
mudar_alvo = function()
{
	
		//if keyboard_check_pressed(ord("W")){
			//alvo_index++	
			////show_debug_message(alvo_atual)
			//if(alvo_index >= array_length(global.inimigo))
			//{
				//alvo_index = 0
				//
			//}
		//}
		//
		//if keyboard_check_pressed(ord("S")){
			//alvo_index--;	
			////show_debug_message(alvo_atual)
			//if(alvo_index < 0)
			//{
				//alvo_index = array_length(global.inimigo) - 1	
			//}
		//}
		//
		//alvo_atual = global.inimigo[alvo_index]
    
    
    var qtd = array_length(global.inimigo);

    // Não existe alvo
    if (qtd == 0) {
        alvo_atual = undefined;
        return;
    }

    if (keyboard_check_pressed(ord("S"))) {
        alvo_index++;
    }

    if (keyboard_check_pressed(ord("W"))) {
        alvo_index--;
    }

    // 🔒 Garante índice válido
    alvo_index = clamp(alvo_index, 0, qtd - 1);

    alvo_atual = global.inimigo[alvo_index];
}




//EXECUTA A AÇÃO D PLAYER, TIRA VIDA DO ALVO
//ESSE METODO ESTA SENDO ACIONADO NO executa_acao()
executa_alvo = function()
{
	
		var usuario = turnos[0];
		var acao_escolhida = usuario.acoes[0]; // depois vem do menu
		executa_ataque(usuario, alvo_atual, acao_escolhida);
			//show_message(alvo_atual.vida)

}

//DESENHA UM QUADRADO
//DEBUG PARA VER SE ESTA SELECIONANDO O INIMIGO CORRETO. ISSO SERA APAGADO 03/01/2026
vizualiza_alvo = function()
{
	if (estado_turno == "selecionar_alvo")
{
    var a = alvo_atual;
    //draw_set_color(c_red);
    draw_rectangle(
        a.heroi.x - 16,
        a.heroi.y - 16,
        a.heroi.x + 16,
        a.heroi.y + 16,
        false
    );
}
}
#endregion ---Alvos

 #endregion	
 
 
 
 ver_estatistica = function()
 {
	var _info = turnos[0]
	
	if _info.is_hero == false
	{
	show_message(_info.is_hero)
	}
 }
 //ORDENANDO TURNOS
 //APARTIR DA MINHA FUNÇÃO DE ORDENAÇÃO NO SCRIPT
turnos = ordena_val(global.batalha)

