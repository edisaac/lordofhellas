setuplog=0


EVENT_CARDS=Global.getVar("EVENT_CARDS")
EVENTCARD_ZONE=Global.getVar("EVENTCARD_ZONE")

MONSTER_CARDS=Global.getVar("MONSTER_CARDS")
ARTEFACT_CARDS=Global.getVar("ARTEFACT_CARDS")
COMBAT_CARDS=Global.getVar("COMBAT_CARDS")
TEMPLE_CARDS=Global.getVar("TEMPLE_CARDS")
PROPHECY_CARDS=Global.getVar("PROPHECY_CARDS")
CONSTRUCT_CARDS=Global.getVar("CONSTRUCT_CARDS")
PANDORA_CARDS=Global.getVar("PANDORA_CARDS")
HEROS_BAG=Global.getVar("HEROS_BAG")
GODS_BAG=Global.getVar("GODS_BAG")


APOLLO_TILE=Global.getVar("APOLLO_TILE")
HADES_TILE=Global.getVar("HADES_TILE")
POSEIDON_TILE=Global.getVar("POSEIDON_TILE")
HEPHESTOS_TILE=Global.getVar("HEPHESTOS_TILE")

BENDITION_CARDS=Global.getVar("BENDITION_CARDS")
APOLLO_CARDS=Global.getVar("APOLLO_CARDS")
HADES_CARDS=Global.getVar("HADES_CARDS")
POSEIDON_CARDS=Global.getVar("POSEIDON_CARDS")
HEPHESTOS_CARDS=Global.getVar("HEPHESTOS_CARDS")


APOLLO_ARTEFACT=Global.getVar("APOLLO_ARTEFACT")
POSEIDON_ARTEFACT=Global.getVar("POSEIDON_ARTEFACT")
HEPHESTOS_ARTEFACT=Global.getVar("HEPHESTOS_ARTEFACT")
HADES_ARTEFACT=Global.getVar("HADES_ARTEFACT")
ATHENA_ARTEFACT=Global.getVar("ATHENA_ARTEFACT")

RELIQUIA_DECK=Global.getVar("RELIQUIA_DECK")
ALUMBRADO_CARD=Global.getVar("ALUMBRADO_CARD")

MUSA_DECK=Global.getVar("MUSA_DECK")
GODCARD_ZONE=Global.getVar("GODCARD_ZONE")
GODBOARD_ZONE=Global.getVar("GODBOARD_ZONE")
POSEIDON_BOARD=Global.getVar("POSEIDON_BOARD")

MONSTER_FIGURES = {
  adrestiaCard= {tile = "83fdfa", figure = "8e8838"},
  arachneCard= {tile = "xxx", figure = "c13beb"},
  cerberoCard= {tile = "xxx", figure = "199e8c"},
  cetusCard= {tile = "xxx", figure = "cb9de8"},
  chironCard= {tile = "xxx", figure = "b48b93"},
  ciclopeCard= {tile = "xxx", figure = "848536"},
  esfingeCard= {tile = "xxx", figure = "5c9b8e"},
  hidraCard= {tile = "xxx", figure = "2030fe"},
  medusaCard= {tile = "xxx", figure = "398c4a"},
  minotauroCard= {tile = "xxx", figure = "230e3e"},
  pythonCard= {tile = "xxx", figure = "e3b2a7"},
  quimeraCard= {tile = "xxx", figure = "e5e7bd"},
  sirenaCard= {tile = "xxx", figure = "1c7ceb"},
  typhonCard= {tile = "xxx", figure = "c5d145"}
}

function setUp(clicked_object, player, color)
  --[[
    setuplog=setuplog+1

    randomCards(MONSTER_CARDS)
    randomCards(ARTEFACT_CARDS)
    randomCards(PROPHECY_CARDS)

    randomCards(COMBAT_CARDS)

    randomCards(CONSTRUCT_CARDS)
    setContructCards()

    randomCards(TEMPLE_CARDS)
    setTempleCards()

    randomCards(EVENT_CARDS)
    randomCards(PANDORA_CARDS)
    setEventCards()

    Wait.time(function() setPandora() end , 3, 1)

    setLastGod()
]]
setEventCards()
end

function randomCards(cards)
  local cards = getObjectFromGUID(cards)
  cards.shuffle()
  cards.shuffle() 
end



function setTempleCards()
  local deck = getObjectFromGUID(TEMPLE_CARDS)
  local deckPos = deck.getPosition()
  local xPos = deckPos[1] - 26.7
  deck.takeObject({flip=true, position={xPos, deckPos[2]+3, deckPos[3]}})

end

function setContructCards()
    local deck = getObjectFromGUID(CONSTRUCT_CARDS)
    local deckPos = deck.getPosition()
    local yPos = deckPos[3] + 3
    for i = 1, 3 do
        deck.takeObject({flip=true, position={deckPos[1], deckPos[2], yPos}})
        yPos = yPos + 3
    end
end


function validateMonster(monsterList, monster)

  local monsterFounded=false
  for _,v in pairs(monsterList) do
    if v == monster then
      monsterFounded= true
      break
    end
  end
  return monsterFounded

end

function printeventscards()
  local deck = getObjectFromGUID(EVENT_CARDS)
  local deckPos = deck.getPosition()
  local indexCards=0
  while(indexCards<40)  do
    indexCards=indexCards+1
    local cardTaken=deck.takeObject({flip=false,smooth=true, position={deckPos[1], deckPos[2]+10, deckPos[3]}})
     
    local lista= cardTaken.getTags()
    --quiero recorrer todos los tags del deck las cartas del deck  
      local resultado = ""
  
      for i, valor in ipairs(lista) do
          resultado = resultado .. valor
          if i ~= #lista then  -- Si no es el último elemento, agrega una coma y un espacio
              resultado = resultado .. ", "
          end
      end
      print(resultado)
  end
end 

function setEventCards()
    local deck = getObjectFromGUID(EVENT_CARDS)
    local deckPos = deck.getPosition()
    local yPos = deckPos[3] - 8

    local questCounter=0
    local indexCards=0

    local monsterList={}
    while(indexCards<7)  do
        validate=true
        indexCards=indexCards+1
        local cardTaken=deck.takeObject({flip=false,smooth=true, position={deckPos[1], deckPos[2]+10, deckPos[3]}})
        if cardTaken.hasTag("questCard") then

          questCounter=questCounter+1

          if questCounter>3 then
             printToAll('questCard:'.. questCounter)
             validate=false
          end
        elseif  cardTaken.hasTag("oportunityCard")   then
            printToAll('oportunityCard:')
            validate=false
        else
            local ltags=cardTaken.getTags()
            local tagMostro=filtrarPorCard(ltags)
            local monsterName=tagMostro[1]
            printToAll(monsterName)
            if (validateMonster(monsterList,monsterName)) then
              validate=false
            else
              table.insert(monsterList,monsterName)
              
              setMonsterPosition(monsterName)
            end
        end

        if validate then
          yPos = yPos - 5
          cardTaken.flip()
          cardTaken.setPositionSmooth({deckPos[1], deckPos[2] , yPos})
 

        else
          indexCards=indexCards-1
        end
    end
end

function setMonsterPosition(monsterName) 
  local monster=  MONSTER_FIGURES[monsterName]
  local monsterFigure= getObjectFromGUID(monster.figure)
  printToAll(monster.figure)
  local monsterPos = monsterFigure.getPosition()
  
  monsterPos[2]=monsterPos[2]+20
  monsterFigure.setPositionSmooth(monsterPos)
  monsterPos[1]=monsterPos[1]+20
  monsterFigure.setPositionSmooth(monsterPos)    
end 

function filtrarPorCard(t)
  local resultado = {}
  for _, v in ipairs(t) do
      if string.sub(v, -4) == "Card" then
          table.insert(resultado, v)
      end
  end
  return resultado
end


function setPandora()
    local deckEvent = getObjectFromGUID(EVENT_CARDS)
    local deckPandora = getObjectFromGUID(PANDORA_CARDS)
    local cardZone = getObjectFromGUID(EVENTCARD_ZONE)


    local deckPos = cardZone.getPosition()

    for i = 1, 3 do
     deckEvent.takeObject({flip=false,smooth=false, position={deckPos[1], deckPos[2]+math.random(1, 20), deckPos[3]}})
   end
    deckPandora.takeObject({flip=false,smooth=false, position={deckPos[1], deckPos[2]+math.random(1, 20), deckPos[3]}})

end


function setLastGod()
  local godBag = getObjectFromGUID(GODS_BAG)
  local deckPos = godBag.getPosition()
  deckPos[1] = deckPos[1] - 28.5
  god=godBag.takeObject({smooth=true, position={deckPos[1], deckPos[2]+5, deckPos[3]}})


  if      god.guid == APOLLO_TILE   then setApollo()
  elseif  god.guid == HADES_TILE    then setHades()
  elseif  god.guid == POSEIDON_TILE then setPoseidon()
  else
    setHephestos()
  end
end

function setApollo()
   printToAll("APOLLO_TILE")
   local deck = getObjectFromGUID(APOLLO_CARDS)
   setGodsCards(deck)
   local godArtefact= getObjectFromGUID(APOLLO_ARTEFACT)
   setGodArtefact(godArtefact)
  local deckPos = getObjectFromGUID(GODCARD_ZONE).getPosition()
  local musaDeck= getObjectFromGUID(MUSA_DECK)
  musaDeck.setPosition(deckPos)
  musaDeck.shuffle()

  for i = 1, 2 do
      deckPos[1] = deckPos[1] -8
      musaDeck.takeObject({flip=true, position=deckPos})
  end

end

function setPoseidon ()
  printToAll("POSEIDON_TILE")
     local deck = getObjectFromGUID(POSEIDON_CARDS)
     setGodsCards(deck)
     local godArtefact= getObjectFromGUID(POSEIDON_ARTEFACT)
     setGodArtefact(godArtefact)

end

function setHephestos()
  printToAll("HEPHESTOS_TILE")
   local deck = getObjectFromGUID(HEPHESTOS_CARDS)
   setGodsCards(deck)
   local godArtefact= getObjectFromGUID(HEPHESTOS_ARTEFACT)
   setGodArtefact(godArtefact)

   local deckPos = getObjectFromGUID(GODCARD_ZONE).getPosition()
   local reliquiaDeck= getObjectFromGUID(RELIQUIA_DECK)
   reliquiaDeck.setPosition(deckPos)
   reliquiaDeck.shuffle()

   for i = 1, 3 do
       deckPos[1] = deckPos[1] -8
       reliquiaDeck.takeObject({flip=true, position=deckPos})
   end
   local alumbradoCard= getObjectFromGUID(ALUMBRADO_CARD)
    deckPos[1] = deckPos[1] -8

    alumbradoCard.setPosition(deckPos)
   for i = 1, 4 do
      local temp = alumbradoCard.clone()
      temp.setPosition(deckPos)
      temp.flip()
   end
   alumbradoCard.flip()
end

function setHades()
  printToAll("HADES_TILE")
   local deck = getObjectFromGUID(HADES_CARDS)
   setGodsCards(deck)
   local godArtefact= getObjectFromGUID(HADES_ARTEFACT)
   setGodArtefact(godArtefact)
end

function setGodsCards(godCards)
  local deck = getObjectFromGUID(BENDITION_CARDS)
  local deckPos = deck.getPosition()
  deckPos[2]=deckPos[2]+1
  godCards.setPosition(deckPos, false, false)
  Wait.time(function() deck.shuffle()  end , 3, 1)
end

function setGodArtefact(godArtefact)
   local athenArtefact= getObjectFromGUID(ATHENA_ARTEFACT)
   local deckPos = athenArtefact.getPosition()
   deckPos[3]=deckPos[3]-3
   godArtefact.setPositionSmooth(deckPos, false, false)
end