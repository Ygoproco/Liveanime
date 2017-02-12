--Magnet Saurcer
function c450000353.initial_effect(c)
   --destroy effect
   local e1=Effect.CreateEffect(c)
   e1:SetCategory(CATEGORY_ATKCHANGE)
   e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
   e1:SetCode(EVENT_DESTROY)
   e1:SetRange(LOCATION_MZONE)
   e1:SetCondition(c450000353.condition)
   e1:SetOperation(c450000353.operation)
   c:RegisterEffect(e1)
   --[[
   if not c450000353.global_check then
		c450000353.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c450000353.archchk)
		Duel.RegisterEffect(ge2,0)
	end
	--]]
end
function c450000353.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c450000353.filterloli(c)
	return (c:IsSetCard(0x800) or c:IsSetCard(0x2066)) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_ONFIELD)
	--return c420.IsMagnet(c) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_ONFIELD)
end
function c450000353.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c450000353.filterloli,1,nil)
end
function c450000353.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
