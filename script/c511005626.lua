--Curse of Dragon (DOR)
--scripted by GameMaster (GM)
function c511005626.initial_effect(c)
	--field treated as wasteland
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetOperation(c511005626.operation)
	c:RegisterEffect(e1)
	--Atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE+RACE_ROCK+RACE_DINOSAUR))
	e3:SetCondition(c511005626.sdcon)
	e3:SetValue(200)
	c:RegisterEffect(e3)
	--Def
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end

function c511005626.sdcon(e)
	return  Duel.IsEnvironment(23424603)
end

function c511005626.filter(c)
    return c and c:IsCode(code) and c:IsFaceUp()
end
function c511005626.condition(e)
    return
      not c511005626.filter(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
      not c511005626.filter(Duel.GetFieldCard(1,LOCATION_SZONE,5))
end




function c511005626.operation(e)
    local c=e:GetHandler()
    
    --field
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCondition(c511005626.condition)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_CHANGE_ENVIRONMENT)
    e3:SetValue(23424603)
    c:RegisterEffect(e3)
   end
    
