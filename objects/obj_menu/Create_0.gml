escolhas = ["Jogar", "Updates"]
atual = 0


desenha_menu = function(){
    
    draw_set_font(fnt_turno)
    for (var i = 0; i < array_length(escolhas);i++){
        _x = 20
        _y = ((display_get_gui_height() / 2) + (i * 25)) 
        _cor = c_white
        
        if(i == atual)
	{
		_cor = c_red;	
	}
        var _meio = 
        draw_set_colour(_cor)
        draw_text(_x, _y - 200, escolhas[i])  
        draw_set_colour(-1)
        //draw_set_font(-1)
       
    }
       draw_set_font(-1)  
}


muda_escolha = function()
{
    if keyboard_check_pressed(vk_up)
{
    atual--;
}

if keyboard_check_pressed(vk_down)
{
    atual++;
}



if(atual < 0)
{
		atual = 0;
}
else if(atual > 1)
{
		atual = 1
}



if(keyboard_check_released(vk_enter))
{
	escolhendo_menu();
}

}



escolhendo_menu = function(){
    switch (atual) {
    	case 0:
            room_goto(rm_jogo)
            break
        case 1:
            room_goto(rm_updates)
            break;
    }
}