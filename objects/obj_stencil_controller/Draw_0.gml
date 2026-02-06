////draw over efect
//gpu_set_stencil_enable(true) //Podemos usar o Stencil
//draw_clear_stencil(0)//Preenchendo o stencil com a informação 0
//gpu_set_stencil_ref(1)//Referencia onde vai desenhar o stencil
//gpu_set_stencil_func(cmpfunc_always)//Marcando todos os pixels da arvore
//gpu_set_stencil_pass(stencilop_replace)//Substituindo os 0 pela nossa referencia 1

//gpu_set_colourwriteenable(false,false,false,false)//Proibindo de desenhar a arvore na tela, pois, ela ja esta la!
//gpu_set_alphatestenable(true)//fazendo filtro de alpha
//gpu_set_alphatestref(127)//se o pixel tier alpha de 127 para cima, vou registra a informação

//with(obj_strelia)//desenhando
//{
//	draw_self()	
//}

//gpu_set_colourwriteenable(true, true, true, true)//Habilitando os canais novamente
//gpu_set_alphatestenable(false)
//gpu_set_stencil_func(cmpfunc_equal)

//draw_set_alpha(.5)
//draw_sprite_tiled(spr_stencil, 0, 0, current_time/20)//desenhando o stencil
//draw_set_alpha(1)
//gpu_set_stencil_enable(false)


////draw overlap effect


ativar_stencil()