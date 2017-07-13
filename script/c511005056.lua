--Reservation Reward
--	By Shad3
--fixed by MLD
function c511005056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c511005056.atktg)
	c:RegisterEffect(e2)
	--Set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511005056.settg)
	e3:SetOperation(c511005056.setop)
	c:RegisterEffect(e3)
	if not c511005056.global_check then
		c511005056.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetOperation(c511005056.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511005056.checkop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) 
		or bit.band(re:GetActiveType(),TYPE_SPELL+TYPE_QUICKPLAY)~=TYPE_SPELL+TYPE_QUICKPLAY then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511005056,RESET_EVENT+0x1fe0000,0,0)
		tc=g:GetNext()
	end
end
function c511005056.atktg(e,c)
	return c:GetFlagEffect(511005056)>0
end
function c511005056.filter(c)
	return bit.band(c:GetType(),TYPE_SPELL+TYPE_QUICKPLAY)==TYPE_SPELL+TYPE_QUICKPLAY and not c:IsPublic() and c:IsSSetable()
end
function c511005056.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingMatchingCard(c511005056.filter,tp,LOCATION_HAND,0,1,nil) end
end
function c511005056.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.SelectMatchingCard(tp,c511005056.filter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if tc then
		local fid=c:GetFieldID()
		Duel.ConfirmCards(1-tp,tc)
		Duel.BreakEffect()
		Duel.SSet(tp,tc)
		tc:SetStatus(STATUS_SET_TURN,false)
		tc:RegisterFlagEffect(511005055,RESET_EVENT+0x1fe0000,0,1,fid)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BECOME_TARGET)
		e1:SetLabelObject(tc)
		e1:SetLabel(fid)
		e1:SetCondition(c511005056.atkcon)
		e1:SetOperation(c511005056.atkop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511005056.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if not tc or tc:GetFlagEffectLabel(511005055)~=e:GetLabel() then
		e:Reset()
		return false
	else return re:GetHandler()==tc end
end
function c511005056.atkfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c511005056.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511005056.atkfilter,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetOwner())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetCondition(c511005056.acon)
		e1:SetValue(c511005056.aval)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c511005056.acon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c511005056.aval(e,c)
	return c:GetAttack()*2
end
