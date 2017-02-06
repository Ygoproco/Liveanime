--デストーイ・マーチ
function c511003004.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511003004.condition)
	e1:SetTarget(c511003004.target)
	e1:SetOperation(c511003004.activate)
	c:RegisterEffect(e1)
	if not c511003004.global_check then
		c511003004.global_check=true
		c511003004[0]=Group.CreateGroup()
		c511003004[0]:KeepAlive()
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511003004.setop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511003004.setop(e,tp,eg,ep,ev,re,r,rp)
	if c511003004[0]:GetCount()>0 then return end
	for i=1,5 do
		local tc=Duel.CreateToken(0,419)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511002961)
		tc:RegisterEffect(e1)
		c511003004[0]:AddCard(tc)
	end
	for i=1,5 do
		local tc=Duel.CreateToken(1,419)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511002961)
		tc:RegisterEffect(e1)
		c511003004[0]:AddCard(tc)
	end
end
function c511003004.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0xad)
end
function c511003004.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g then return false end
	local tg=g:Filter(c511003004.cfilter,nil,tp)
	return rp~=tp and re:IsActiveType(TYPE_MONSTER) and g:GetCount()==1 and Duel.IsChainDisablable(ev)
end
function c511003004.filter(c,e,tp)
	return c:IsCanBeEffectTarget(e) and Duel.IsExistingMatchingCard(c511003004.tgfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c511003004.tgfilter(c,e,tp,tc)
	return c:IsSetCard(0xad) and c:GetLevel()==tc:GetLevel() and c:IsAbleToGrave() and Duel.IsChainDisablable(ev) 
		and Duel.IsExistingMatchingCard(c511003004.spfilter,tp,LOCATION_EXTRA,0,1,c,e,tp,tc)
end
function c511003004.spfilter(c,e,tp,tc)
	return c:IsSetCard(0xad) and c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
		and c:CheckFusionMaterial(c511003004[0],tc,tp)
end
function c511003004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(c511003004.cfilter,nil,tp)
	local tc=tg:GetFirst()
	if chkc then return chkc==tc and c511003004.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and c511003004.filter(tc,e,tp) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511003004.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.NegateEffect(ev)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=Duel.SelectMatchingCard(tp,c511003004.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
		if tg:GetCount()>0 then
			Duel.BreakEffect()
			if Duel.SendtoGrave(tg,REASON_EFFECT)>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sg=Duel.SelectMatchingCard(tp,c511003004.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
				if sg:GetCount()>0 then
					Duel.SpecialSummon(sg,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
					sg:GetFirst():CompleteProcedure()
				end
			end
		end
	end
end
