--Miracle Fire
function c511015122.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511015122.thtg)
	e1:SetOperation(c511015122.thop)
	c:RegisterEffect(e1)
	if not c511015122.global_check then
		c511015122.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c511015122.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511015122.checkop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsType(TYPE_SPELL) and rc:IsSetCard(0xac1) then
		rc:RegisterFlagEffect(511015122,RESET_PHASE+PHASE_END,0,0)
	end
end
function c511015122.filter(c)
	return c:GetFlagEffect(511015122)>0 and c:CheckActivateEffect(false,false,false)~=nil
end
function c511015122.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c511015122.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511015122.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
end
function c511015122.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tg=Duel.SelectMatchingCard(tp,c511015122.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	if not tg then return end
	local te=tg:GetFirst():GetActivateEffect()
	local cost=te:GetCost()
	local target=te:GetTarget()
	local operation=te:GetOperation()
	if cost then cost(e,tp,eg,ep,ev,re,r,rp) end
	if target then target(e,tp,eg,ep,ev,re,r,rp) end
	if operation then operation(e,tp,eg,ep,ev,re,r,rp) end
end