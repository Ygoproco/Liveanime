--cosmo queen (DOR)
--scripted by GameMaster (GM)
function c511005625.initial_effect(c)
  --flip
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
  e1:SetOperation(c511005625.op)
  c:RegisterEffect(e1)
    --Atk up by 200 fiend / spellcaster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FIEND+RACE_SPELLCASTER))
	e2:SetCondition(c511005625.sdcon)
	e2:SetValue(200)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	 --Atk down fairy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FAIRY))
	e4:SetCondition(c511005625.sdcon)
	e4:SetValue(-200)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
end

function c511005625.sdcon(e)
	return  Duel.IsEnvironment(59197169)
end

function c511005625.filter(c)
  return c and c:IsFaceup()
end

function c511005625.condition(e)
  return
   not c511005625.filter(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
   not c511005625.filter(Duel.GetFieldCard(1,LOCATION_SZONE,5))
end

function c511005625.op(e)
  local c=e:GetHandler()
     --field
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_CHANGE_ENVIRONMENT)
  e3:SetRange(LOCATION_MZONE)
  e3:SetCondition(c511005625.condition)
  e3:SetValue(59197169)
  e3:SetReset(RESET_EVENT+0x1fe0000)
  c:RegisterEffect(e3)
end

