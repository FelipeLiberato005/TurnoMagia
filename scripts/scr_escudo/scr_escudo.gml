
function scr_escudo(_escudo_max) constructor{
	
	//vida total
	escudo_max = _escudo_max
	//vida atual
	escudo = escudo_max;
	escudo_temp = escudo;
	escudo_fundo = escudo
	
	static perde_escudo = function(_quantidade = 1)
	{
		escudo -= _quantidade;
		escudo = clamp(escudo, 0, escudo_max)
		return escudo;
	}
	
	static ganha_escudo = function(_quantidade = 1)
	{
		escudo += _quantidade;
		escudo = clamp(escudo, 0, escudo_max)
		return escudo;
	}
	
	//metodo vida
	///@function desenha_vida(x, y, largura, altura, [cor1], [cor2], [cor3]);
	static desenha_escudo= function(_x, _y, _largura, _altura, _cor1 = c_orange, _cor2 = c_red, _cor3 = c_white, _out = false)
	{
		//largura da minha barra com base a minha vida atual
		var _larg_vida = (escudo_temp/escudo_max) * _largura;
		var _larg_vida2 = (escudo_fundo/escudo_max) * _largura;
		
		var _cor = merge_color(_cor2, _cor1, escudo_temp / escudo_max);
		
		//diminuindo o valor vida_temp
		escudo_temp = lerp(escudo_temp, escudo, 0.1);
		escudo_fundo = lerp(escudo_fundo, escudo_temp, 0.03)
		
		//desenhando a sub barra de vida
		draw_rectangle_color(_x - 2, _y - 2, _x + _largura + 2, _y + _altura + 2, _cor3, _cor3, _cor3, _cor3, _out)
		
		//barra efeito
		draw_rectangle_color(_x, _y, _x + _larg_vida2, _y + _altura, _cor2, _cor2, _cor2, _cor2, _out)
		
		draw_rectangle_color(_x, _y, _x + _larg_vida, _y + _altura, _cor, _cor, _cor, _cor, _out);
	}
}