--Fruit of Destruction
--fixed by MLD
function c511004409.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511004409.cost)
	c:RegisterEffect(e1)
	--sp
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511004409.sptg)
	e2:SetOperation(c511004409.spop)
	c:RegisterEffect(e2)
	--sb
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511004409.mtcon)
	e3:SetTarget(c511004409.mttg)
	e3:SetOperation(c511004409.mtop)
	c:RegisterEffect(e3)
end
function c511004409.costfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c511004409.cost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004409.costfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c511004409.costfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SendtoGrave(tg,REASON_COST)
end
function c511004409.spfilter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) 
		and c:IsCanBeSpecialSummoned(e,tp,SUMMON_TYPE_SPECIAL,false,false) and c:IsCanBeEffectTarget(e)
end
function c511004409.atkfilter(c)
	return c:GetAttack()>=3000
end
function c511004409.sptg(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	local g=eg:Filter(c511004409.spfilter,nil,e,tp)
	if chkc then return g:IsContains(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and g:GetCount()>0 and Duel.IsExistingMatchingCard(c511004409.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	local tg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,1,0,0)
	Duel.BreakEffect()
	local sg=Duel.SelectMatchingCard(tp,c511004409.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=sg:GetFirst()
	Duel.HintSelection(sg)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-3000)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
end
function c511004409.spop(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511004409.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511004409.tgfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsFaceup() and c:IsAbleToGrave()
end
function c511004409.mttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsOnField() and c511004409.tgfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c511004409.tgfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	if g:GetCount()==0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,3000)
	end
end
function c511004409.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoGrave(tc,REASON_EFFECT)==0 then
		Duel.Damage(tp,3000,REASON_EFFECT)
	end
end
