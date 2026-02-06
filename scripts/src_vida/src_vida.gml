
function scr_vida(_vida_max) constructor{
	
	//vida total
	vida_max = _vida_max
	//vida atual
	vida = vida_max;
	vida_temp = vida;
	vida_fundo = vida;
	
	static perde_vida = function(_quantidade = 1)
	{
		vida -= _quantidade;
		vida = clamp(vida, 0, vida_max)
		return vida;
	}
	
	static ganha_vida = function(_quantidade = 1)
	{
		vida += _quantidade;
		vida = clamp(vida, 0, vida_max)
		return vida;
	}
	
	//metodo vida
	///@function desenha_vida(x, y, largura, altura, [cor1], [cor2], [cor3]);
	static desenha_vida = function(_x, _y, _largura, _altura, _cor1 = c_orange, _cor2 = c_red, _cor3 = c_white)
	{
		//largura da minha barra com base a minha vida atual
		var _larg_vida = (vida_temp/vida_max) * _largura;
		var _larg_vida2 = (vida_fundo/vida_max) * _largura;
		
		var _cor = merge_color(_cor2, _cor1, vida_temp / vida_max);
		
		//diminuindo o valor vida_temp
		vida_temp = lerp(vida_temp, vida, 0.1);
		vida_fundo = lerp(vida_fundo, vida_temp, 0.03)
		
		//desenhando a sub barra de vida
		draw_rectangle_color(_x - 2, _y - 2, _x + _largura + 2, _y + _altura + 2, _cor3, _cor3, _cor3, _cor3,false)
		
		//barra efeito
		draw_rectangle_color(_x, _y, _x + _larg_vida2, _y + _altura, _cor2, _cor2, _cor2, _cor2, false)
		
		draw_rectangle_color(_x, _y, _x + _larg_vida, _y + _altura, _cor, _cor, _cor, _cor,false);
	}
}