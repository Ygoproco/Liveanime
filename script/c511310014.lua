--Bubble Barrier (Anime)
--AlphaKretin
function c511310014.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--adjust
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511310014.op)
	c:RegisterEffect(e2)
end
function c511310014.fil(c)
	return c:IsFaceup() and (c:IsSetCard(0x9f) or c:IsSetCard(0xc6)) and c:GetAttack()<1501
end
function c511310014.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511310014.fil,tp,LOCATION_MZONE,0,nil)
	if c:IsDisabled() then return end
	for tc in aux.Next(g) do
		if tc:GetFlagEffect(511310014)==0 then
			tc:RegisterFlagEffect(511310014,RESET_EVENT+0x1fe0000,0,1)
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(276357,1)) --Negate attack
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
			e1:SetCode(EVENT_BE_BATTLE_TARGET)
			e1:SetLabelObject(c)
			e1:SetCountLimit(1)
			e1:SetTarget(c511310014.target)
			e1:SetOperation(c511310014.operation)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
	end
end
function c511310014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,nil,nil,0,tp,1)
end
function c511310014.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end