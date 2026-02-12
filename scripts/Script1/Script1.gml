
function cria_personagem(_nome, 
						 _spr, 
						 _vida = 0, 
						 _mana = 0, 
						 _vel,
						 _ataque,
						 _idle,
						 _cura,
						 _hero = true,
						 _dano
						) 
						 constructor
{
	
	nome = _nome;
	heroi = _spr
	
	vida_base = _vida;
	//vida_atual = _vida;
	controla_vida = new scr_vida(vida_base);
	
	mana = _mana
	vel_base = _vel
	vel_atual = _vel
	ataque = _ataque
	idle = _idle
	cura = _cura
	is_hero = _hero
	
	dano_atual = _dano
	dano_base = _dano
	
	//acoes que o personagem pode usar
	acoes = []
	
	//Lista de ataques unicos dos personagens
	tipo_ataques = []
	
	//Lista de buffs
	buff = []
	
	//controla a morte do personagem
	morto = false
	
	


}




function ordena_val(_array)
{
	fazer = true;
	
	var _lista = []
	
	array_copy(_lista, 0, _array, 0, array_length(_array))
	
	//var _lista = _array;
	
	while(fazer)
	{
		fazer = false
		
		var _qtd = array_length(_lista)
		for (var i = 0; i < _qtd - 1; i++)
		{
			var _atual = _lista[i];
			
			var _prox = _lista[i + 1];
			
			//Checando se o valor atual é maior que o do proimo
			
			if (_atual.vel_atual < _prox.vel_atual)
			{
					_lista[i] = _prox
					_lista[i + 1] = _atual
					
					fazer = true
		}
		}
	}
	
	return _lista
}

//HEROIS

#region STRELIZIA
var _char1 = new cria_personagem(
"Streliza", 
obj_strelia, 
222, 
100, 
8, 
spr_maga_atack, 
spr_strelizia,
,
,
78
)
array_push(_char1.acoes, "magia");
array_push(_char1.tipo_ataques, 
			{nome: "ATK", tipo: "ataque", valor: 0, mana: 0})
#endregion

#region CLONE STRELIZIA
var _char2 = new cria_personagem(
"Clone", 
obj_strelia_1, 
333, 
100, 
7, 
spr_clone_ataque, 
spr_strelizia_2,
,
,
80
)
array_push(_char2.acoes, "magia");
array_push(_char2.tipo_ataques, 
			{nome: "ATK", tipo: "ataque", valor: 0, mana: 0})
#endregion

#region SLIME
var _char3 = new cria_personagem(
"Slime", 
obj_gosma, 
444, 
100, 
4, 
spr_slime_atack, 
spr_gosma,
,
false,
30
) 
array_push(_char3.acoes, "ataque");
array_push(_char3.tipo_ataques, 
			{nome: "ATK", tipo: "ataque", valor: 0})
#endregion

#region LUCILLE
var _luce = new cria_personagem(
"Lucille",
obj_lucille,
350,
100,
15,
spr_luce_atack,
spr_luce_idle,
,
,
70

)
array_push(_luce.acoes, "ataque")
array_push(_luce.tipo_ataques, 
		{nome: "ATK", tipo: "ataque", valor: 0, mana: 0}
		);
		
		
#endregion

#region LILLI
var _lilli = new cria_personagem(
"Lilli",
obj_lilli,
150,
100,
16,
noone,
spr_lili_idle,
spr_lili_healer,
,
80
) 
array_push(_lilli.acoes, "magia")
array_push(_lilli.tipo_ataques,
		{nome: "Cura", tipo: "cura", valor: 75, mana: 40},
		{nome: "+DMG", tipo: "buff", valor: 50, mana: 20},
		{nome: "ATK", tipo: "ataque", valor: 25, mana: 0}
);
#endregion

#region     Lica

var _lica = new cria_personagem(
    "Lica",
    obj_lica,
    100,
    100,
    22,
    spr_lica_atack_1,
    spr_lica_idle,
    ,
    ,
    95
    
)
array_push(_lica.acoes, "magia");
array_push(_lica.tipo_ataques,
		{nome: "ATK", tipo: "ataque", valor: 0, mana: 0})

#endregion

//INIMIGOS
#region CORVO
var _inimigo1 = new cria_personagem(
"Corvo", 
obj_corvo, 
200, 
100, 
16, 
spr_corvo_atack, 
spr_corvo,
noone,
false,
35
)
array_push(_inimigo1.acoes, "ataque");
array_push(_inimigo1.tipo_ataques,
		{nome: "ATK", tipo: "ataque", valor: 0})
#endregion


#region CROW
var _inimigo2 = new cria_personagem(
"Crow", 
obj_luana, 
300, 
100, 
1, 
spr_corvo_atack, 
spr_player2,
noone,
false,
30
)
array_push(_inimigo2.acoes, "ataque");
array_push(_inimigo2.tipo_ataques,
		{nome: "ATK", tipo: "ataque", valor: 0})
#endregion


#region CAVALEIRO
var _cavaleiro = new cria_personagem(
"Cavaleiro",
obj_cavaleiro,
640,
100,
4,
spr_cavaleiro_atack,
spr_cavaleiro_idle,
,
false,
25)
array_push(_inimigo2.acoes, "defesa");
array_push(_cavaleiro.tipo_ataques,
		{nome: "ATK", tipo: "ataque", valor: 0})
#endregion 

#region Nyah

var nyah = new cria_personagem(
"Nyah",
obj_nyah,
500,
100,
12,
spr_nyah_atack,
spr_nyah_idle,
,
false,
85
)
array_push(nyah.acoes, "ataque")
array_push(nyah.tipo_ataques, 
        {nome: "ATK", tipo: "ataque", valor: 0})
#endregion

#region Lica_ENEMY
 var lica_enemy = new cria_personagem(
"lica Evil",
obj_lica_enemy,
300,
100,
19,
spr_lica_atack,
spr_lica_idle_1,
,
false,
78
)
array_push(lica_enemy.acoes, "magia")
array_push(lica_enemy.tipo_ataques,
            {nome: "ATK", tipo: "ataque", valor: 0})
#endregion 

global.personagens = [_char1, 
_char2, 
_char3, 
_luce, 
_inimigo1, 
_inimigo2,
_lilli,
_cavaleiro,
_lica,
nyah,
lica_enemy]
     
	 
global.batalha = [
_lilli,
_char1, 
_char2, 
_char3,
_luce,
_inimigo1,
lica_enemy,
_cavaleiro,
_lica,
nyah
]





global.inimigo = [_inimigo1, _cavaleiro, lica_enemy, _char3, nyah]

//Lista de Herois
global.herois = [_char1, _luce, _lica, _lilli, _char2]


//global.turno = [_char1, _char2, _char3]

//show_message(global.batalha)

