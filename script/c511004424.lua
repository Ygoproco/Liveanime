--supreme king dance
--fixed by MLD
function c511004424.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004424.target)
	c:RegisterEffect(e1)
	--target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4004,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511004424.atcon)
	e2:SetTarget(c511004424.attg)
	e2:SetOperation(c511004424.atop)
	c:RegisterEffect(e2)
	--prevent destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(c511004424.adescon)
	e3:SetOperation(c511004424.adesop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(8873112,1))
	e4:SetType(EFFECT_TYPE_QUICK_F)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCondition(c511004424.edescon)
	e4:SetTarget(c511004424.edestg)
	e4:SetOperation(c511004424.edesop)
	c:RegisterEffect(e4)
	--attack
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(4004,1))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511004424.atcon2)
	e5:SetCost(c511004424.atcost2)
	e5:SetTarget(c511004424.attg2)
	e5:SetOperation(c511004424.atop2)
	c:RegisterEffect(e5)
end
function c511004424.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511004424.filter(chkc) end
	if chk==0 then return true end
	if c511004424.atcon(e,tp,eg,ep,ev,re,r,rp) and c511004424.attg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,94) then
		e:SetOperation(c511004424.atop)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		c511004424.attg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511004424.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf8)
end
function c511004424.atcon(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE 
		and Duel.IsExistingMatchingCard(c511004424.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511004424.filter(c)
	return c:IsFaceup() and not c:IsHasEffect(EFFECT_CANNOT_ATTACK) and not c:IsHasEffect(EFFECT_CANNOT_ATTACK_ANNOUNCE) 
		and (c:IsAttackPos() or c:IsHasEffect(EFFECT_DEFENSE_ATTACK))
end
function c511004424.attg(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511004424.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511004424.filter,tp,0,LOCATION_MZONE,1,nil) and e:GetHandler():GetFlagEffect(511004424)==0 end
	Duel.SelectTarget(tp,c511004424.filter,tp,0,LOCATION_MZONE,1,1,nil,0)
	e:GetHandler():RegisterFlagEffect(511004424,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511004424.atop(e,tp,eg,ev,ep,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MUST_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if tc:GetAttackAnnouncedCount()~=0 then
			local e2=e1:Clone()
			e2:SetCode(EFFECT_EXTRA_ATTACK)
			e2:SetValue(1)
			tc:RegisterEffect(e2)
		end
		tc=g:GetNext()
	end
end
function c511004424.adescon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsSetCard(0xf8) and tc:IsRelateToBattle()
end
function c511004424.adesop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	if not e:GetHandler():IsRelateToEffect(e) or not tc or not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
end
function c511004424.cdfilter(c,tp)
	return c:IsOnField() and c:IsControler(tp) and c:IsSetCard(0xf8)
end
function c511004424.edescon(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c511004424.cdfilter,nil,tp)-tg:GetCount()>0
end
function c511004424.edestg(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	local g=tg:Filter(c511004424.cdfilter,nil,tp)
	Duel.SetTargetCard(g)
end
function c511004424.edesop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(1)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c511004424.atcon2(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE 
end
function c511004424.atcost2(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511004424.attg2(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004424.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c511004424.atop2(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetMatchingGroup(c511004424.filter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MUST_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	if g:GetCount()==0 then return end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PATRICIAN_OF_DARKNESS)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetReset(RESET_PHASE+PHASE_BATTLE)
	e2:SetTargetRange(0,1)
	Duel.RegisterEffect(e2,tp)
end
