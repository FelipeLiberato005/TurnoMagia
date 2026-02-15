
numero = 0
escolha = 0
up = noone
down = noone
enter = noone
retirar = noone

controles = function()
{
    up = keyboard_check_pressed(vk_up)
    down = keyboard_check_pressed(vk_down)
    enter = keyboard_check_pressed(vk_enter)
    retirar = keyboard_check_pressed(vk_backspace)
    esc = keyboard_check_released(vk_escape)
}

controla_escolhas = function()
{
    if up
    {
        escolha--;
    }
    else if down{
        escolha++;
    }
    
    if escolha < array_length(global.escolhas_player) - array_length(global.escolhas_player) {
        escolha = array_length(global.escolhas_player) - array_length(global.escolhas_player) 
    }
    else if escolha >= array_length(global.escolhas_player){
        escolha = array_length(global.escolhas_player) - 1
    }
}

desenha_escolhas = function()
{
    for (var i = 0; i < array_length(global.escolhas_player); i++)
    {
        var _x = 20
        var _y = 20 + (i * 20)
        cor = make_colour_rgb(255, 255, 255)
        
        
        if i == escolha
        {
            cor = make_colour_rgb(150,0,0)
           // draw_sprite(global.escolhas_player[i].idle, 0, 300, 200)
        }
        
        draw_set_colour(cor)
        draw_set_font(fnt_info_updates)
        draw_text(_x, _y, global.escolhas_player[i].nome)
        draw_set_font(-1)
        draw_set_colour(make_colour_rgb(255, 255, 255))
    }
}

ativa_personagem = function()
{
    if enter{
        escolhendo_personagem()
    }
}


retira_personagem = function(){
       if retirar 
    {
        if array_length(global.herois) > 0
        {
            var removido = array_pop(global.herois);
        }
        
    }
}


escolhendo_personagem = function()
{
   
    lista_batalha = global.batalha
    lista_herois = global.herois
    switch (escolha) {
    	case 0:
            controla_lista_player()
        break;
    
        case 1:
            controla_lista_player()
        break    
    
        case 2:
            controla_lista_player()
        break    
    
        case 3:
            controla_lista_player()
        break    
    
        case 4:
            controla_lista_player()
        break    
    
        case 5:
            controla_lista_player()
        break    
    
        case 6:
            controla_lista_player()
        break    
    }
}


mostrando_formacao = function(_lista){
    
  
	draw_set_font(fnt_painel)
	var _qtd = array_length(_lista)
	
	
	
	for (var i = 0; i < _qtd; i++)
	{
		
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
				//instance_create_layer(_x, _y, layer, _info.heroi)
                draw_sprite(_info.idle, 0, _x, _y)
				
			}
	}
	draw_set_font(-1)
}





info_listas = function()
{ 
    
    for (var i = 0; i < array_length(global.herois); i++){
        var _x = 600
        var _y = 90 + (i * 20)
        
        draw_set_font(fnt_turno)        
        draw_text(_x, _y, global.herois[i].nome) 
        draw_set_font(-1)
    }
    
    draw_set_font(fnt_turno)
draw_text(600, 32, "Lista batalha" + string(array_length(global.batalha)))
draw_text(600, 65, "Lista Aliados" + string(array_length(global.herois)))
draw_set_font(-1)
}