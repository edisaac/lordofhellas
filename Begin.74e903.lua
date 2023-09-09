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
  adrestiaCard= {tile = "83fdfa", figure = "8e8838",artefact ="f3c98b"},
  arachneCard= {tile = "328194", figure = "c13beb",artefact="cecef8"},
  cerberoCard= {tile = "e02036", figure = "199e8c",artefact="17d2fe"},
  cetusCard= {tile = "e755c6", figure = "cb9de8",artefact="f928d4"},
  chironCard= {tile = "ed83e1", figure = "b48b93",artefact="6d00b6"},
  ciclopeCard= {tile = "20b72f", figure = "848536",artefact="9ed304"},
  esfingeCard= {tile = "e21844", figure = "5c9b8e",artefact="7cfab3"},
  hidraCard= {tile = "31f47b", figure = "2030fe",artefact="307d8e"},
  medusaCard= {tile = "318d5b", figure = "398c4a",artefact="5055a4"},
  minotauroCard= {tile = "71b89e", figure = "230e3e",artefact="583202"},
  pythonCard= {tile = "ff9a68", figure = "e3b2a7",artefact="660577"},
  quimeraCard= {tile = "f64ba6", figure = "e5e7bd",artefact="4c51df"},
  sirenaCard= {tile = "ea5d09", figure = "1c7ceb",artefact="7e256b"},
  typhonCard= {tile = "c00dac", figure = "c5d145",artefact="8dec4f"}
}

REGION_ZONES={ 
_EPIRUS="6600dc",
_MACEDONIA="9a2ccf",
_THESSALIA="fee39b",
_CHALKIDIKI="1c4222",
_ARCARNANIA="9cf871",
_AETOLIA="540e72",
_LOCRIS="a691a1",
_PHOSIS="8062e5",
_BOEOTIA="f9c87b",
_EUBOEA="1003dd",
_CORINTHIA="6d5229",
_ATTICA="0c3fe4",
_ELIS="9436cf",
_ACHAEA="57b897",
_ARCADIA="44512d",
_MESSENIA="c876c1",
_LACONIA="4f1180",
_ARGOLIS="f61d7f",
_CRETE="fb7816"
}

QUEST_CARDS={
__gerion="c4550d",
__piritus="7c0920",
__establos="86afa2",
__vellocino="2d13a8",
__amazona="0c444d",
__estinfalo="d12b5c",
__toro="8735b6",
__calidon="70322e",
__prometeo="a7006f",
__atlas="435762",
__tyndareus="c69a8b"
}

EJE_Y=1
EJE_Z=2
EJE_X=3

function setUp(clicked_object, player, color)
  
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
 
 
end

function randomCards(cards)
  local cards = getObjectFromGUID(cards)
  cards.shuffle()
 
 
  cards.randomize() 

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

function printTags(lista)
  local resultado = ""

  for i, valor in ipairs(lista) do
      resultado = resultado .. valor
      if i ~= #lista then  -- Si no es el último elemento, agrega una coma y un espacio
          resultado = resultado .. ", "
      end
  end
  print(resultado)
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
        local ltags=cardTaken.getTags()

        if cardTaken.hasTag("questCard") then
          questCounter=questCounter+1
          if questCounter>3 then
             validate=false
          else 
            local zoneUUID= obtenerUUIDListado(REGION_ZONES, ltags)             
            local questUUID= obtenerUUIDListado(QUEST_CARDS, ltags)
            moveToZone(questUUID,zoneUUID)
          end
        elseif  cardTaken.hasTag("oportunityCard")   then
            validate=false
        else            
            local tagMostro=filtrarPorCard(ltags)
            local monsterName=tagMostro[1]            
            if (validateMonster(monsterList,monsterName)) then
              validate=false
            else
              table.insert(monsterList,monsterName)
            
              local zoneUUID= obtenerUUIDListado(REGION_ZONES, ltags)             
              
              setMonster(monsterName)
              setMonsterPosition(monsterName,zoneUUID)
                           
            end
        end

        if validate then
          printTags(ltags)
          yPos = yPos - 5
          cardTaken.flip()
          cardTaken.setPositionSmooth({deckPos[1], deckPos[2] , yPos})
 
        else
          indexCards=indexCards-1
        end
    end
end

function setMonster(monsterName) 
  local monster=  MONSTER_FIGURES[monsterName]
  local monsterTile= getObjectFromGUID(monster.tile)
  local monsterArtefact= getObjectFromGUID(monster.artefact)

 
  local monsterPos = monsterTile.getPosition()
   
  monsterPos[EJE_Z]=monsterPos[EJE_Z]+5
  monsterPos[EJE_Y]=monsterPos[EJE_Y]+20
  monsterTile.setPositionSmooth(monsterPos )
  monsterPos[EJE_Z]=monsterPos[EJE_Z]+5
  monsterArtefact.setPositionSmooth(monsterPos )
 
end 

function setMonsterPosition ( monsterName,zoneUUID)
  
  local monster=  MONSTER_FIGURES[monsterName]
  
  moveToZone(monster.figure,zoneUUID)
end

function moveToZone(objectUUID, zoneUUID)
  local objectToMove= getObjectFromGUID(objectUUID)
  local zone= getObjectFromGUID(zoneUUID)
  local zonePos = zone.getPosition()
  Z_POS=zonePos[EJE_Z]
  zonePos[EJE_Z]=Z_POS+10
  objectToMove.setPositionSmooth(zonePos,false,false)
end

function filtrarPorCard(tags)
  local resultado = {}
  for _, v in ipairs(tags) do
      if string.sub(v, -4) == "Card" then
          table.insert(resultado, v)
      end
  end
  return resultado
end

function obtenerUUIDListado(listado, tags)
  for _, tag in ipairs(tags) do
      if listado[tag] then
           return listado[tag]
      end
  end
  return nil  
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