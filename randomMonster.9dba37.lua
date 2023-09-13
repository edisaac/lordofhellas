MONSTER_DICE_GUID=Global.getVar("MONSTER_DICE_GUID")

israndoming=false

function rollMonsterDie()

  local die = getObjectFromGUID(MONSTER_DICE_GUID)
  if  die.resting then


   randomTime=0
   printToAll("-------random -------- ")
    Timer.create({
         identifier     = "repeatRandomize",
         function_name  = "repeatRandomize",
         parameters     = dataTable,
         delay          = 0.1,
         repetitions    = 10,
     })

     Wait.condition(
      function() -- Executed after our condition is met
          if die.isDestroyed() then
              printToAll("Die was destroyed before it came to rest.")
          end
      end,
          function() -- Condition function
              return die.isDestroyed() or die.resting
          end
    )
 else
     print("Is Randoming.")
  end
end

function repeatRandomize()
  local die = getObjectFromGUID(MONSTER_DICE_GUID)
  randomTime=randomTime + 1
  printToAll("random time: " ..  randomTime)
  die.randomize()
end