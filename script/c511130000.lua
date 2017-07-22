--Dungeon Worm (Anime)
--fixed by MLD
function c511130000.initial_effect(c)
	--underground
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23204029,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,0xc)
	e1:SetCondition(c511130000.con)
	e1:SetOperation(c511130000.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511130000.effcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(aux.bdocon)
	e4:SetOperation(c511130000.atkop)
	c:RegisterEffect(e4)
end
function c511130000.con(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsStatus(STATUS_CHAINING) then return true end
	local te=Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
	return e~=te
end
function c511130000.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if c:GetFlagEffect(511130000)>0 then
			c:ResetFlagEffect(511130000)
		else
			c:RegisterFlagEffect(511130000,RESET_EVENT+0x1fe0000,0,0)
		end
	end
end
function c511130000.effcon(e)
	return e:GetHandler():GetFlagEffect(511130000)>0
end
function c511130000.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c:GetBaseAttack()*0.1)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
