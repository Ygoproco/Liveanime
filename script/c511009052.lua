--D - Pressure
--fixed by MLD
function c511009052.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009052.tg)
	e1:SetOperation(c511009052.op)
	c:RegisterEffect(e1)
	if not c511009052.global_check then
		c511009052.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511009052.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511009052.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:GetFlagEffect(511009052)==0 then
			tc:RegisterFlagEffect(511009052,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end
function c511009052.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xc008) and c:GetFlagEffect(511009052)>0 
		and Duel.IsExistingMatchingCard(c511009052.spfilter,tp,LOCATION_HAND,0,1,nil,c:GetAttack(),e,tp)
end
function c511009052.spfilter(c,atk,e,tp)
	return c:IsSetCard(0xc008) and c:GetAttack()<=atk and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009052.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009052.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009052.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009052.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
end
function c511009052.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511009052.spfilter,tp,LOCATION_HAND,0,1,1,nil,tc:GetAttack(),e,tp)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
