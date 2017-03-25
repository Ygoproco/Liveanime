--Magnet Chameleon
function c450000354.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c450000354.condition)
	e1:SetTarget(c450000354.target)
	e1:SetOperation(c450000354.operation)
	c:RegisterEffect(e1)
	--[[
	if not c450000354.global_check then
		c450000354.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c450000354.archchk)
		Duel.RegisterEffect(ge2,0)
	end
	--]]
end
function c450000354.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c450000354.filterloli(c,mc)
	if mc then
		return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsCode(mc:GetCode()) and c~=mc
	end
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(c450000354.filterloli,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,c)
end
function c450000354.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.IsExistingMatchingCard(c450000354.filterloli,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,nil)
end
function c450000354.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and not c:IsImmuneToEffect(e) and not c:IsDisabled()
end
function c450000354.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c450000354.filter,tp,0,LOCATION_ONFIELD,1,nil,e,tp) end
	Duel.SelectTarget(tp,c450000354.filter,tp,0,LOCATION_ONFIELD,1,1,nil,e,tp)
end
function c450000354.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tg:RegisterEffect(e1)
end
