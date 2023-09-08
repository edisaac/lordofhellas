

dRoll=0

COMBAT_CARDS=Global.getVar("COMBAT_CARDS")

HEROS_BAG=Global.getVar("HEROS_BAG")


function onload()
  -- clickable area
  self.createButton({
      click_function="pickPlayer", function_owner=self,
      position={0.4, 0.2, 0}, height=1000, width=700, color={1,1,1,0}, label=""
  })
  -- button label
  self.createButton({
      click_function="pickPlayer", function_owner=self,
      position={0.7, 0.2, 1}, height=1, width=1, color={255,255,255,1}, label=self.getName(), font_size=300
  })
end

function pickPlayer(clicked_object, player, color)
  dRoll=dRoll+1
  local sittingPlayers = {}
  for k,v in pairs({'White','Brown','Red','Orange','Yellow','Green','Teal','Blue','Purple','Pink','Black'}) do
    if Player[v].seated then
      table.insert(sittingPlayers,v)
    end
  end

  local pickedColor = sittingPlayers[math.random(#sittingPlayers)]
  printToAll('(#' .. dRoll .. ') ' .. Player[player].steam_name .. ' (' ..  player ..') picks ' .. Player[pickedColor].steam_name .. ' (' ..  pickedColor ..')', {self.getColorTint().r,self.getColorTint().g,self.getColorTint().b})


  Turns.enable=true
  Turns.turn_color = pickedColor
  deal(COMBAT_CARDS)
  deal(HEROS_BAG)

end

function deal(dealType)
    local dealObject = getObjectFromGUID(dealType)
    dealObject.shuffle()
    dealObject.deal(1)
end