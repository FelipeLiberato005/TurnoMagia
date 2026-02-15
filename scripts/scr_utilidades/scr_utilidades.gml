

//function estado_sprite(sprite_player)
//{
//    if _info._heroi.sprite_index != sprite_player
//    {
//        _info._heroi.sprite_index = sprite_player
//        _info._heroi.image_index = 0;
//    }
//}

global.reseta_turnos = 1

//Verificando se passou de turno
global.passei = false

//Verificando se ja pode realizar a proxima ação
global.trava = true

//Verificando se a animação chegou ao fim
global.fim_animacao = false

global.alvos = false

global.true_mana = false

global.i = 0

function controla_lista_player()
{

    var personagem = global.escolhas_player[escolha];

    // limite de 5
    if array_length(global.herois) >= 5
    {
        return;
    }

    // evitar duplicado
    if !array_contains(global.herois, personagem)
    {
        array_push(global.herois, personagem);
    }
}

function limpa_lista(_lista)
{
    for (var i = array_length(_lista) - 1; i >= 0; i--)
    {
        var _p = _lista[i];
        //
        //// 🔥 deleta objeto da room
            //if (instance_exists(_p.heroi))
            //{
                //instance_destroy(_p.heroi);
            //}

        if (_p.morto)
        {
            array_delete(_lista, i, 1);
        }
    }

    return _lista;
}

function montar_batalha()
{
    //global.batalha = []; 

    // adiciona herois escolhidos
    for (var i = 0; i < array_length(global.herois); i++)
    {
        var p = global.herois[i];
        array_push(global.batalha, p);
    }
    //for (var i = 0; i < array_length(global.inimigo); i++)
    //{
        //var e = global.inimigo[i];
        //array_push(global.batalha, e);
    //}
}
function ativar_stencil(_heroi)
{
	
	//draw over efect
gpu_set_stencil_enable(true) //Podemos usar o Stencil
draw_clear_stencil(0)//Preenchendo o stencil com a informação 0
gpu_set_stencil_ref(1)//Referencia onde vai desenhar o stencil
gpu_set_stencil_func(cmpfunc_always)//Marcando todos os pixels da arvore
gpu_set_stencil_pass(stencilop_replace)//Substituindo os 0 pela nossa referencia 1

gpu_set_colourwriteenable(false,false,false,false)//Proibindo de desenhar a arvore na tela, pois, ela ja esta la!
gpu_set_alphatestenable(true)//fazendo filtro de alpha
gpu_set_alphatestref(127)//se o pixel tier alpha de 127 para cima, vou registra a informação

with(_heroi)//desenhando
{
	draw_self()	
}

gpu_set_colourwriteenable(true, true, true, true)//Habilitando os canais novamente
gpu_set_alphatestenable(false)
gpu_set_stencil_func(cmpfunc_equal)

draw_set_alpha(.5)
draw_sprite_tiled(spr_stencil, 0, 0, current_time/20)//desenhando o stencil
draw_set_alpha(1)
gpu_set_stencil_enable(false)


//draw overlap effect
		
}




function ativar_stencil_enemy(_heroi)
{
	
	//draw over efect
gpu_set_stencil_enable(true) //Podemos usar o Stencil
draw_clear_stencil(0)//Preenchendo o stencil com a informação 0
gpu_set_stencil_ref(1)//Referencia onde vai desenhar o stencil
gpu_set_stencil_func(cmpfunc_always)//Marcando todos os pixels da arvore
gpu_set_stencil_pass(stencilop_replace)//Substituindo os 0 pela nossa referencia 1

gpu_set_colourwriteenable(false,false,false,false)//Proibindo de desenhar a arvore na tela, pois, ela ja esta la!
gpu_set_alphatestenable(true)//fazendo filtro de alpha
gpu_set_alphatestref(127)//se o pixel tier alpha de 127 para cima, vou registra a informação

with(_heroi)//desenhando
{
	draw_self()	
}

gpu_set_colourwriteenable(true, true, true, true)//Habilitando os canais novamente
gpu_set_alphatestenable(false)
gpu_set_stencil_func(cmpfunc_equal)

draw_set_alpha(.5)
draw_sprite_tiled(spr_stencil_enemy, 0, 0, current_time/20)//desenhando o stencil
draw_set_alpha(1)
gpu_set_stencil_enable(false)


//draw overlap effect
		
}




#region BUFFS
function cria_buff(_nome, _atributo, _valor, _turnos)
{
    return {
        nome: _nome,
        atributo: _atributo,   // "ataque"
        valor: _valor,         // +10, +20%, etc
        turnos: _turnos        // duração
    };
}



//function aplica_buff(alvo, buff)
//{
//    array_push(alvo.buffs, buff);
//}


#endregion


function executa_habilidade(usuario, alvo, acao)
{
    //if (usuario.morto) exit;
        
	var atk = usuario.tipo_ataques[acao_atual]
	switch(atk.tipo)
	{
        
            
		#region CURA
		case "cura":
            if atk.mana <= obj_player.mana
            {
			usuario.heroi.sprite_index = usuario.cura;
			
			var  _cura = atk.valor
			var _qtd = array_length(global.herois) 
			
			for (i = 0; i < _qtd; i++)
			{
                
				var x_alvo = global.herois[i].heroi.x
				var y_alvo = global.herois[i].heroi.y
				var temp  = instance_create_layer(x_alvo-20, y_alvo-20,"Instances", obj_cura)
				
				cura = ((atk.valor/100) * usuario.dano_atual)
				temp.txtCura = cura
				temp.cor = c_green
				temp.depth = depth - 1
				global.herois[i].controla_vida.ganha_vida(cura)
                 
				
			}
            obj_player.mana -= atk.mana 
            global.true_mana = true
            global.fim_animacao = true 
            }
            else {
            {
                //show_message("Mana Insuficiente!")
                var x_alvo = usuario.heroi.x 
                var y_alvo = usuario.heroi.y
                var temp  = instance_create_layer(x_alvo+20, y_alvo-30,"Instances", obj_cura)
                temp.txtCura = "Sem Mana! "
                temp.sinal = " "
            }
            }
			#endregion
			
		break;
		
		#region BUFFS
		case "buff":
			//usuario.heroi.sprite_index = usuario.ataque;
        if atk.mana <= obj_player.mana
        {    
			usuario.heroi.sprite_index = usuario.cura;
			
			
			var _qtd = array_length(global.herois) 
		
			for (i = 0; i < _qtd; i++)
			{
				
				var x_alvo = global.herois[i].heroi.x
				var y_alvo = global.herois[i].heroi.y
				var temp  = instance_create_layer(x_alvo-20, y_alvo-20,"Instances", obj_cura)
				
				temp.cor = c_red
				temp.txtCura = atk.valor
				global.herois[i].dano_atual += atk.valor
                
			}
            obj_player.mana -= atk.mana
            global.true_mana = true
            global.fim_animacao = true  
			//aplica_buff(alvo, buff);
        }
            else {
            	//show_message("Mana Insuficente!")
                var x_alvo = usuario.heroi.x 
                var y_alvo = usuario.heroi.y
                var temp  = instance_create_layer(x_alvo+20, y_alvo-30,"Instances", obj_cura)
                temp.txtCura = "Sem Mana! "
                temp.sinal = " "
            }
			#endregion
		break;
		
		#region ATK BASICO
		case "ataque":
        if atk.mana <= obj_player.mana    
        {
		var x_alvo = alvo.heroi.x
		var y_alvo = alvo.heroi.y
			usuario.heroi.sprite_index = usuario.ataque;
			var temp  = instance_create_layer(x_alvo+20, y_alvo-20,"Instances", obj_cura)
			temp.txtCura = usuario.dano_atual
			temp.sinal = "-"
			alvo.controla_vida.perde_vida(usuario.dano_atual)
			//show_message(alvo.controla_vida.vida)
			
			//show_message(alvo.vida_base)
			//var temp = instance_create_layer(x,y-10,"Instances", obj_cura)
			//temp.depth = depth - 1
			//temp.txtCura = usuario.dano_atual 
            obj_player.mana -= atk.mana   
            global.true_mana = true
            global.fim_animacao = true   
        }
        else {
        {
            //show_message("Mana Insuficiente!")
            var x_alvo = usuario.heroi.x 
            var y_alvo = usuario.heroi.y
            var temp  = instance_create_layer(x_alvo+20, y_alvo-30,"Instances", obj_cura)
            temp.txtCura = "Sem Mana! "
            temp.sinal = " "
        }
                                                    }                                              
		break;
		#endregion
	}
	
	
}


function executa_ia(usuario, alvo, acao)
{
    
        //if (alvo.morto) exit;
            
		var x_alvo = alvo.heroi.x
		var y_alvo = alvo.heroi.y
		usuario.heroi.sprite_index = usuario.ataque;
		var temp  = instance_create_layer(x_alvo+20, y_alvo-20,"Instances", obj_cura)
		temp.txtCura = usuario.dano_atual
		temp.sinal = "-"
		alvo.controla_vida.perde_vida(usuario.dano_atual)
			
	//	if (alvo.morto) exit;

    //usuario.heroi.sprite_index = usuario.ataque;

    //alvo.controla_vida.perde_vida(usuario.dano_atual);

    //if (alvo.controla_vida.vida <= 0)
    //{
    //    alvo.morto = true;
    //}
}

