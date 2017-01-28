--C/C/C Sonic Halberd of Battle
--fixed by MLD
function c511009382.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,511009400,c511009382.ffilter,1,true,true)
	--multiattack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c511009382.val)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46132282,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c511009382.effop)
	c:RegisterEffect(e2)
end
function c511009382.ffilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_WIND) and c:IsLevelAbove(7)
end
function c511009382.attfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c511009382.val(e,c)
	if Duel.IsExistingMatchingCard(c511009382.attfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil) then
		return 2
	else 
		return 1
	end
end
function c511009382.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		c:RegisterEffect(e2)
	end
end
