--Lord of D. (DOR)
--scripted by GameMaster(GM)
function c511005692.initial_effect(c)
	--dragon-type immune to opponents spell/traps
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(function(e) return e:GetHandler():IsDefensePos() end)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_DRAGON))
	e1:SetValue(c511005692.efilter)
	c:RegisterEffect(e1)
end

function c511005692.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetOwner()~=e:GetOwner()
		and te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end