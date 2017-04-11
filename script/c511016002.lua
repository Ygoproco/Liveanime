--アルカナフォース０－THE FOOL
function c511016002.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetCondition(c511016002.poscon)
	c:RegisterEffect(e2)
	--coin
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(62892347,0))
	e3:SetCategory(CATEGORY_COIN)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c511016002.cointg)
	e3:SetOperation(c511016002.coinop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
	--coin selection
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(511016002)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	c:RegisterEffect(e6)
	--function overwrite scripted by MLD
	local f=Duel.TossCoin
	Duel.TossCoin=function(tp,ct)
		if Duel.IsPlayerAffectedByEffect(tp,511016002) and Duel.SelectYesNo(tp,1623) then
			local tct=ct
			local t={}
			for i=1,ct do
				local res=1-Duel.SelectOption(tp,60,61)
				table.insert(t,res)
			end
			return table.unpack(t)
		else
			return f(tp,ct)
		end
	end
end
function c511016002.poscon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c511016002.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511016002.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local res=0
	if c:IsHasEffect(73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else res=Duel.TossCoin(tp,1) end
	c511016002.arcanareg(c,res)
end
function c511016002.arcanareg(c,coin)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511016002.tgval)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c511016002.unval)
	c:RegisterEffect(e2)
	c:RegisterFlagEffect(36690018,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,coin,63-coin)
end
function c511016002.tgval(e,re,rp)
	if e:GetHandler():GetFlagEffectLabel(36690018)==1 then
		return rp==e:GetHandlerPlayer()
	else return rp~=e:GetHandlerPlayer() end
end
function c511016002.unval(e,te)
	if e:GetHandler():GetFlagEffectLabel(36690018)==1 then
		return te:GetOwnerPlayer()==e:GetHandlerPlayer() and te:GetOwner()~=e:GetHandler()
	else return te:GetOwnerPlayer()~=e:GetHandlerPlayer() end
end
