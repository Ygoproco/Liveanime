--Shadow of Eyes (DOR)
--scripted by GameMaster(GM)
function c511005672.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c511005672.condition)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetCode(EVENT_MSET)
	e1:SetCondition(c511005672.con2)
	c:RegisterEffect(e1)
	--Pos Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsFaceup))
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsFacedown))
	e3:SetValue(POS_FACEDOWN_ATTACK)
	c:RegisterEffect(e3)
end
function c511005672.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end

function c511005672.cfilter(c,tp)
	return  c:IsPreviousPosition(POS_ATTACK) and c:IsPosition(POS_DEFENSE) 
end

function c511005672.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511005672.cfilter,1,nil,1-tp)
end
