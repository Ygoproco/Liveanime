--Performapal Drago Remora (anime)
function c511009413.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
		--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c511009413.spcon)
	c:RegisterEffect(e1)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_DRAGON))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(500)
	c:RegisterEffect(e3)
end

function c511009413.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511009413.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and	Duel.IsExistingMatchingCard(c511009413.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end