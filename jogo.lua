-- Origame
-- por Gabriel Araújo

-- Esconde a barra de status
display.setStatusBar(display.HiddenStatusBar)
--physics.setDrawMode("hybrid")


-- Constantes
local LARGURA_TELA = display.contentWidth
local ALTURA_TELA = display.contentHeight
local CENTRO_X = display.contentCenterX
local CENTRO_Y = display.contentCenterY


-- Física
local physics = require('physics')
physics.start()


-- Variaveis composer
local composer = require("composer")
local scene = composer.newScene()


-- Variaveis
local TsuruAtual
local etiquetaDiferenciacao
local textoDiferenciacao
local textoPontuacao
local etiquetaPontuacao
local regraDiferenciacao
local etiquetaDistancia
local textoDistancia
local ultimaCorSelecionada
local ultimaFormaSelecionada
local velocidadeMovimento = 2
local ori
local velocidade = .1
local tsuru
local tsuruTimer
local tsuru1
local tsuru2
local tsuru3
local caminhoDiretorioImagens = "resources/images/"
local cores = {"amarelo", "ambar", "indigo", "laranja", "roxo", "vermelho"}
local formas = {"forma1", "forma2", "forma3", "forma4", "forma5", "forma6"}
local grupoImagens = display.newGroup()
local contadorTsurus = 0
local tableTsurus = {}
local indice = 1
local trioTsurusAtual = 1
local limiteNivel = 9
local primeiraEscolha = true
local ultimoTempo = 4.000
local tempoAtual
local fundo
local montanhasFundo
local montanhasFrente
local caminhoDiretorioEstilo = "resources/estilo/"
local velocidadeMontanhas
local barreira
local tsuruInicio = nil
local iconeDiferenciacao
local btnJogar
local btnCreditos
local btnSair
local btnComoJogar
local destroi = false
local titulo1
local titulo2
local frequencia = 1000

-- Funções
local adicionarOri = {}
local adicionarTsurus = {}
local mudarRegraDiferenciacao = {}
local diferenciar = {}
local fimDeJogo = {}
local selecionarTsuru = {}
local aumentarVelocidade = {}
local update = {}
local embaralhar = {}
local removerTsurusNaoSelecionados = {}
local pausar = {}
local resumir = {}
local montarCenario = {}
local scrollingMontanhas = {}
local carregarMenu = {}
local jogar = {}
local creditos = {}
local carregarMenu = {}
local fecharApp = {}
local montarCenario = {}
local jogar = {}

local transicao = false

function scene:create(event)
  local sceneGroup = self.view

  -- Inicia a cena aqui
  -- Ex: adicionar objetos display para "sceneGroup"

  -- monta cenario
  montarCenario()

end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está fora da cena
  elseif (phase == "did") then
    btnJogar:addEventListener("touch", jogar)
    btnCreditos:addEventListener("touch", creditos)
    btnSair:addEventListener("touch", fecharApp)
    btnComoJogar:addEventListener("touch", comoJogar)

    if(jogarNovamente == true) then
      jogar()
    end
  end
end

function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na cena
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    -- Chama imediatamente quando a cena está fora da tela
  end
end


function montarCenario()
  fundo = display.newImageRect(caminhoDiretorioEstilo .. "fundo2.png", LARGURA_TELA, ALTURA_TELA)
  fundo.x = CENTRO_X
  fundo.y = CENTRO_Y
  scene.view:insert(fundo)

  titulo1 = display.newText('ori', CENTRO_X - 90, CENTRO_Y - 162, "Origram", 70)
  titulo1:setFillColor(244/255,67/255,54/255)
  scene.view:insert(titulo1)
  titulo2 = display.newText('game', CENTRO_X + 42, CENTRO_Y - 162, "Origram", 70)
  scene.view:insert(titulo2)

--[[  montanhasFundo = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-fundo.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFundo.x = CENTRO_X
  montanhasFundo.y = CENTRO_Y
  scene.view:insert(montanhasFundo)

  montanhasFrente = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-frente.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFrente.x = CENTRO_X
  montanhasFrente.y = CENTRO_Y
  scene.view:insert(montanhasFrente)]]

--[[  montanhasFrente2 = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-frente.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFrente2.x = montanhasFrente.x + LARGURA_TELA
  montanhasFrente2.y = CENTRO_Y
  scene.view:insert(montanhasFrente2)

  montanhasFrente3 = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-frente.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFrente3.x = montanhasFrente3.x + LARGURA_TELA
  montanhasFrente3.y = CENTRO_Y
  scene.view:insert(montanhasFrente3)]]

  ori = display.newImage(caminhoDiretorioImagens .. 'ori.png')
  ori.x = CENTRO_X - 248
  ori.y = CENTRO_Y - 106
  ori.name = "ori"
  ori.isFixedRotation = true
  physics.addBody(ori, "kinematic")
  scene.view:insert(ori)
  --grupoImagens:insert(ori)


--[[barreira = display.newRect(CENTRO_X, CENTRO_Y, LARGURA_TELA, ALTURA_TELA)
  barreira:setFillColor(0, 0.5)
  barreira:setStrokeColor( 1, 0, 0 )
  scene.view:insert(barreira)]]

  carregarMenu()
end

-- Carregar imagens contidas no menu
function carregarMenu()
  btnComoJogar = display.newImageRect(caminhoDiretorioEstilo .. "botao-tutorial.png", 40, 40)
  btnComoJogar.x = CENTRO_X - 130
  btnComoJogar.y = CENTRO_Y + 170
  scene.view:insert(btnComoJogar)

  btnJogar = display.newImageRect(caminhoDiretorioEstilo .. "botao-jogar.png", 90, 90)
  btnJogar.x = CENTRO_X
  btnJogar.y = CENTRO_Y + 147
  scene.view:insert(btnJogar)

  btnCreditos = display.newImageRect(caminhoDiretorioEstilo .. "botao-creditos.png", 40, 40)
  btnCreditos.x = CENTRO_X + 130
  btnCreditos.y = CENTRO_Y + 170
  scene.view:insert(btnCreditos)

  btnSair = display.newImageRect(caminhoDiretorioEstilo .. "botao-sair.png", 30, 30)
  btnSair.x = CENTRO_X + 300
  btnSair.y = CENTRO_Y - 160
  scene.view:insert(btnSair)

  adicionarTsurus()
end

function scrollingMontanhas(event)
--  montanhasFundo.x = montanhasFundo.x - 0.5
  montanhasFrente.x = montanhasFrente.x - 1
  montanhasFrente2.x = montanhasFrente2.x - 1
  montanhasFrente3.x = montanhasFrente3.x - 1

  if (montanhasFrente.x + montanhasFrente.contentWidth) < 0 then
    montanhasFrente:translate(LARGURA_TELA * 4, 0)
  end

  if (montanhasFrente2.x + montanhasFrente2.contentWidth) < 0 then
    montanhasFrente2:translate(LARGURA_TELA * 4, 0)
  end

  if (montanhasFrente3.x + montanhasFrente3.contentWidth) < 0 then
    montanhasFrente3:translate(LARGURA_TELA * 4, 0)
  end
end

function exibirTextos()
  -- Exibi a distância percorrida
  textoDistancia = display.newText("0 m", CENTRO_X - 160, CENTRO_Y - 180, "Origram", 16)
  textoDistancia:setTextColor(68, 68, 68)
  scene.view:insert(textoDistancia)

  -- Exibi a pontuação
  textoPontuacao = display.newText("0", CENTRO_X, CENTRO_Y - 180, "Origram", 16)
  textoPontuacao:setTextColor(68, 68, 68)
  scene.view:insert(textoPontuacao)

  -- Exibi a regra de difereciação
  iconeDiferenciacao = display.newImageRect(caminhoDiretorioEstilo .. "icone-diferente.png", 30, 20)
  iconeDiferenciacao.x = CENTRO_X + 160
  iconeDiferenciacao.y = CENTRO_Y - 180
  scene.view:insert(iconeDiferenciacao)

  textoDiferenciacao = display.newText("", CENTRO_X + 205, CENTRO_Y - 180, "Origram", 16)
  textoDiferenciacao:setTextColor(68, 68, 68)
  scene.view:insert(textoDiferenciacao)
end


function jogar()
  --scene.view:remove(barreira)
  scene.view:remove(btnJogar)
  scene.view:remove(btnSair)
  scene.view:remove(btnCreditos)
  scene.view:remove(btnComoJogar)
  scene.view:remove(titulo1)
  scene.view:remove(titulo2)

  pontuacao = 0

  exibirTextos()

  local removeTsuru = function(obj)
    display.remove(obj)
    obj = nil
  end

  tsuruInicio = tsuru3

  --transição tsurus
  transition.to(tsuru1, {time = calculaTempo(tsuru1.x), x = CENTRO_X - 400, y = tsuru1.y, tag="transicao", onComplete=removeTsuru})
  transition.to(tsuru2, {time = calculaTempo(tsuru2.x), x = CENTRO_X - 400, y = tsuru2.y, tag="transicao", onComplete=removeTsuru})
  transition.to(tsuru3, {time = calculaTempo(tsuru3.x), x = CENTRO_X- 400, y = tsuru3.y, tag="transicao", onComplete=removeTsuru})

  --Adiciona manipulador ao toque
  tsuru1.touch = selecionarTsuru
  tsuru2.touch = selecionarTsuru
  tsuru3.touch = selecionarTsuru

  tsuru1:addEventListener("touch", tsuru1)
  tsuru2:addEventListener("touch", tsuru2)
  tsuru3:addEventListener("touch", tsuru3)

--  adicionarTsurusCall = adicionarTsurus(true)


  -- Adicionar tsurus
   transicao = true
   adicionarTsurus()
   tsuruTimer =  timer.performWithDelay(3000, adicionarTsurus, 0)
  -- Adicionar Ori
  -- adicionarOri()

  -- Atualizar cena
  --  Runtime:addEventListener('enterFrame', update)
  -- Runtime:addEventListener("enterFrame", scrollingMontanhas)
end

function calculaTempo(valorX)
    return (valorX - (CENTRO_X - 400))/velocidade
end

-- Adicionar Tsurus
function adicionarTsurus()
    local tsurus = {}
  --Speed up each 15 tsurus added
    if(contadorTsurus == limiteNivel) then
      limiteNivel = limiteNivel + 9
    --  aumentarVelocidade()
    end

    embaralhar(cores)
    embaralhar(formas)

    local cor1 = cores[1]
    local cor2 = cores[2]
    local cor3 = cores[3]

    local forma1 = formas[1]
    local forma2 = formas[2]
    local forma3 = formas[3]

    --Adiciona três tsurus
    --Adiciona tsuru no topo
    tsuru1 = display.newRect(0,0,90,60)
    tsuru1.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/" .. forma1 .. "/tsuru_" .. cor1 .. ".png"}
    tsuru1.color = cor1
    tsuru1.shape = forma1
    tsuru1.id = 1
    physics.addBody(tsuru1, "kinematic")
    scene.view:insert(tsuru1)

    --Adiciona tsuru no meio
    tsuru2 = display.newRect(0,0,90,60)
    tsuru2.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/" .. forma2 .. "/tsuru_" .. cor2 .. ".png"}
    tsuru2.color = cor2
    tsuru2.shape = forma2
    tsuru2.id = 2
    physics.addBody(tsuru2, "kinematic")
    scene.view:insert(tsuru2)

    --Adiona tsuru ao fundo
    tsuru3 = display.newRect(0,0,90,60)
    tsuru3.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/" .. forma3 .. "/tsuru_" .. cor3 .. ".png"}
    tsuru3.color = cor3
    tsuru3.shape = forma3
    tsuru3.id = 3
    physics.addBody(tsuru3, "kinematic")
    scene.view:insert(tsuru3)


  --[[  print("tsuru1 = " .. caminhoDiretorioImagens .. "tsurus/" .. forma1 .. "/tsuru_" .. cor1 .. ".png")
    print("tsuru2 = " .. caminhoDiretorioImagens .. "tsurus/" .. forma2 .. "/tsuru_" .. cor2 .. ".png")
    print("tsuru3 = " .. caminhoDiretorioImagens .. "tsurus/" .. forma3 .. "/tsuru_" .. cor3 .. ".png")
    print(".............................................")
    print(" ") print(" ")]]


    if(transicao == true) then
      tsuru1.x = LARGURA_TELA + 40
      tsuru1.y = ALTURA_TELA - 230

      tsuru2.x = LARGURA_TELA + 150
      tsuru2.y = ALTURA_TELA - 300

      tsuru3.x = LARGURA_TELA + 180
      tsuru3.y = ALTURA_TELA - 160

      local removeTsuru = function(obj)
        display.remove(obj)
        obj = nil
      end

      --transição tsurus
      transition.to(tsuru1, {time = calculaTempo(tsuru1.x), x = CENTRO_X - 400, y = tsuru1.y, tag="transicao", onComplete=removeTsuru})
      transition.to(tsuru2, {time = calculaTempo(tsuru2.x), x = CENTRO_X - 400, y = tsuru2.y, tag="transicao", onComplete=removeTsuru})
      transition.to(tsuru3, {time = calculaTempo(tsuru3.x), x = CENTRO_X - 400, y = tsuru3.y, tag="transicao", onComplete=removeTsuru})

      --Adiciona manipulador ao toque
      tsuru1.touch = selecionarTsuru
      tsuru2.touch = selecionarTsuru
      tsuru3.touch = selecionarTsuru

      tsuru1:addEventListener("touch", tsuru1)
      tsuru2:addEventListener("touch", tsuru2)
      tsuru3:addEventListener("touch", tsuru3)
    else
      tsuru1.x = CENTRO_X + 100
      tsuru1.y = CENTRO_Y - 20

      tsuru2.x = CENTRO_X + 180
      tsuru2.y = CENTRO_Y - 100

      tsuru3.x = CENTRO_X + 200
      tsuru3.y = CENTRO_Y + 50
    end

    --adiciona tsurus a um grupo
  --[[  grupoImagens:insert(tsuru1)
    grupoImagens:insert(tsuru2)
    grupoImagens:insert(tsuru3)
]]
    -- adiciona os três tsurus a uma table
    tsurus = {tsuru1, tsuru2, tsuru3}

    -- adiciona a table com os três tsurus a outra table
    tableTsurus[indice] = tsurus

    --[[ incrementa o indice, indicando em qual posicão da tabela os próximos três
    tsurus serão adicionados]]
    indice = indice + 1

    -- guarda o numero de tsurus adicionados
    contadorTsurus = contadorTsurus + 3
end

-- Embaralha itens de uma table
function embaralhar(t)
    local j

    for i = #t, 2, -1 do
        j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end


-- Tsuru é tocado
function selecionarTsuru(self, event)
  -- Move Ori para o tsuru tocado
  if(event.phase == "began" and ((primeiraEscolha) or (self.x > ori.x and self.x < (ori.x + 420)))) then

  --  transition.to(tsuru, {time = 7000, x = -150, y = tsuru.y, tag="transicao"})
    ori.x = self.x
    ori.y = self.y - 25

    local terminaJogo = function(obj)
      fimDeJogo()
    end

    transition.cancel(ori)
    transition.to(ori, {time = calculaTempo(self.x), x = CENTRO_X - 400, y = ori.y, tag="transicao", onComplete=terminaJogo})

    diferenciar(self)

    totalTsurusSaltados = totalTsurusSaltados + 1

    aumentarDistancia()

    removerTsurusNaoSelecionados(self.id)

    self.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/forma1/tsuru_preto.png"}

    ganharPonto(event)
  end
end

function diferenciar(TsuruAtual)
  if(regraDiferenciacao == "cor") then
    if(TsuruAtual.color == ultimaCorSelecionada) then
      fimDeJogo()
    end
  else
    if(TsuruAtual.shape == ultimaFormaSelecionada) then
      fimDeJogo()
    end
  end

  ultimaCorSelecionada = TsuruAtual.color
  ultimaFormaSelecionada = TsuruAtual.shape

  mudarRegraDiferenciacao()
end


--Change the tsurus differentiation mode
function mudarRegraDiferenciacao()
  local randomNumber = math.random(0,1)

  if(randomNumber == 0) then
    regraDiferenciacao = "cor"
  else
    regraDiferenciacao = "forma"
  end

  textoDiferenciacao.text = string.format("%s", regraDiferenciacao)

end


-- Remove os tsurus não selecionados do trio de tsurus atual
function removerTsurusNaoSelecionados(tsuruId)
  local tsuruNaoSelecionado1
  local tsuruNaoSelecionado2

  if (tsuruId == 1) then
    tsuruNaoSelecionado2 = table.remove(tableTsurus[trioTsurusAtual],3)
    tsuruNaoSelecionado2:removeSelf()
    tsuruNaoSelecionado2 = nil

    tsuruNaoSelecionado1 = table.remove(tableTsurus[trioTsurusAtual],2)
    tsuruNaoSelecionado1:removeSelf()
    tsuruNaoSelecionado1 = nil

  elseif (tsuruId == 2) then
    tsuruNaoSelecionado2 =  table.remove(tableTsurus[trioTsurusAtual],3)
    tsuruNaoSelecionado2:removeSelf()
    tsuruNaoSelecionado2 = nil

    tsuruNaoSelecionado1 =  table.remove(tableTsurus[trioTsurusAtual],1)
    tsuruNaoSelecionado1:removeSelf()
    tsuruNaoSelecionado1 = nil
  else
    tsuruNaoSelecionado2 =  table.remove(tableTsurus[trioTsurusAtual],2)
    tsuruNaoSelecionado2:removeSelf()
    tsuruNaoSelecionado2 = nil

    tsuruNaoSelecionado1 =  table.remove(tableTsurus[trioTsurusAtual],1)
    tsuruNaoSelecionado1:removeSelf()
    tsuruNaoSelecionado1 = nil
  end

  trioTsurusAtual =  trioTsurusAtual + 1
end


-- Aumenta a distância
function aumentarDistancia()
     --incrementando a distância
      distancia = distancia + 60
      textoDistancia.text = string.format("%d m", distancia)
end


-- Aumenta a velocidade
function aumentarVelocidade()
  velocidade = velocidade - 1000
end

function update()
  -- utilizar o tamanho da tela do dispositivo LARGURA_TELA
--  print("largura tela = " .. LARGURA_TELA)
  --print("ori x = " .. ori.x)
  if(contadorTsurus == 1000 or ((tsuruInicio ~= nil) and tsuruInicio.x < (ori.x + 20))) then
    fimDeJogo()
  end
end

function ganharPonto(event)
  tempoAtual = event.time/1000
  local diferencaTempo = tempoAtual - ultimoTempo

  if(diferencaTempo < 1.000) then
    pontuacao = pontuacao + 90
  elseif(diferencaTempo > 1.000 and diferencaTempo < 2.000) then
      pontuacao = pontuacao + 70
  elseif(diferencaTempo > 2.000 and diferencaTempo < 3.000) then
    pontuacao = pontuacao + 50
  elseif(diferencaTempo > 3.000  and diferencaTempo < 4.000) then
    pontuacao = pontuacao + 30
  else
    pontuacao = pontuacao + 10
  end

  textoPontuacao.text = string.format("%d", pontuacao)
  ultimoTempo = tempoAtual
end

-- Configuração de transição entre cenas
local transicaofimDeJogoConfig = {
	effect = "fade", time = 1000
}


-- Função que chama cena para início do jogo
function fimDeJogo()
  destroi = true
  composer.removeScene("jogo")
  composer.gotoScene("fim_de_jogo", transicaofimDeJogoConfig)
end

function scene:destroy(event)
  local sceneGroup = self.view

  if(destroi) then
    transition.cancel("transicao")
    timer.cancel(tsuruTimer)
    Runtime:removeEventListener("enterFrame", update)
    Runtime:removeEventListener("enterFrame", scrollingMontanhas)
    Runtime:removeEventListener("touch", tsuru1)
    Runtime:removeEventListener("touch", tsuru2)
    Runtime:removeEventListener("touch", tsuru3)
  end
end

function pausar()
  timer.pause(tsuruTimer)
  transition.pause("transicao")
  physics.pause()
end

function resumir()
  timer.resumo(tsuruTimer)
  transition.resume("transicao")
end

-- Fechar app
function fecharApp()
      composer.removeScene("menu")

       if(system.getInfo("platformName")=="Android") then
           native.requestExit()
       else
           os.exit()
      end
end


-- Configuração de transição entre cenas
local transicaoCreditosConfig = {
	effect = "fade", time = 550
}


local transicaoComoJogarConfig = {
	effect = "fade", time = 550
}

-- Função que chama cena de créditos do jogo
function creditos()
  composer.removeScene("jogo")
	composer.gotoScene("creditos", transicaoCreditosConfig)
end

-- Função que chama cena de créditos do jogo
function comoJogar()
  composer.removeScene("jogo")
	composer.gotoScene("como_jogar", transicaoComoJogarConfig)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
