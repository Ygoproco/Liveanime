--Odd-Eyes Phantasma Dragon
function c511004423.initial_effect(c)
	function Auxiliary.PConditionFilter(c,e,tp,lscale,rscale)
		local lv=0
		if c.pendulum_level then
			lv=c.pendulum_level
		else
			lv=c:GetLevel()
		end
		return (c:IsLocation(LOCATION_HAND) or (c:IsFaceup() and c:IsType(TYPE_PENDULUM)))
			and ((lv>lscale and lv<rscale) or c:IsHasEffect(511004423)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_PENDULUM,tp,false,false)
			and not c:IsForbidden()
	end
	aux.EnablePendulumAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(511004423)
	e1:SetCondition(c511004423.spcon)
	c:RegisterEffect(e1)
	--attack
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetOperation(c511004423.op)
	c:RegisterEffect(e2)
end
function c511004423.spcon(e)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_EXTRA,0,1,nil,0x99)
end
function c511004423.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c511004423.op(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.GetMatchingGroupCount(c511004423.filter,tp,LOCATION_EXTRA,0,nil)*1000
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-ct)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
