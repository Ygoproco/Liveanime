--Performapal Ignition Eagle
--scripted by Larry126
function c511600000.initial_effect(c)
--pendulum summon
	aux.EnablePendulumAttribute(c)
--mzone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511600000,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511600000.atkcon)
	e1:SetTarget(c511600000.atktg)
	e1:SetOperation(c511600000.atkop)
	c:RegisterEffect(e1) 
--pzone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511600000,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_BATTLE_STEP_END,TIMING_BATTLE_STEP_END)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c511600000.pencon)
	e2:SetCost(c511600000.pencost)
	e2:SetTarget(c511600000.pentg)
	e2:SetOperation(c511600000.penop)
	c:RegisterEffect(e2) 
end
function c511600000.emfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x9f)
end
function c511600000.stfilter(c)
	return c:GetSequence()<5
end
function c511600000.pencon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE_STEP
end
function c511600000.pcfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c511600000.pencost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local lsc=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rsc=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local g=Group.FromCards(lsc,rsc)
	local st=Duel.GetMatchingGroupCount(c511600000.stfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if chk==0 then return g:GetCount()==g:Filter(Card.IsAbleToRemoveAsCost,nil):GetCount() and Duel.GetFieldGroupCount(c511600000.emfilter,tp,LOCATION_DECK,0,nil)>=st end
	local gc=Duel.SelectMatchingCard(tp,c511600000.emfilter,tp,LOCATION_DECK,0,st,st,nil)
	Duel.SendtoGrave(gc,REASON_COST)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511600000.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local g=Duel.GetMatchingGroup(c511600000.stfilter,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511600000.penop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(c511600000.stfilter,tp,LOCATION_SZONE,0,nil)
	if g:GetCount()>0 then
		if tc:IsFaceup() and tc:IsControler(tp) and tc:IsRelateToEffect(e) and Duel.Destroy(g,REASON_EFFECT) and Duel.IsExistingMatchingCard(c511600000.pcfilter,tp,LOCATION_MZONE,0,1,nil) then
			Duel.BreakEffect()
			local pc=Duel.GetMatchingGroupCount(c511600000.pcfilter,tp,LOCATION_MZONE,0,nil)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(pc*500)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
--------------------------------------------------
function c511600000.atkfilter(c)
	return c:IsFaceup()
end
function c511600000.spfilter(c,e,tp)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511600000.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp)
end
function c511600000.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return chkc==at end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511600000.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) and at:IsControler(tp) and at:IsRelateToBattle() and at:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(at)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511600000.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local cp=tc:GetControler()
	if Duel.GetLocationCount(cp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511600000.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	if g:GetCount()==0 then return end
	local sc=g:GetFirst()
	if Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(sc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
		if c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end