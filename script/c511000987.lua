--融合解除
function c511000987.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000987.target)
	e1:SetOperation(c511000987.activate)
	c:RegisterEffect(e1)
end
function c511000987.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and (c:IsAbleToExtra() or c:IsAbleToGrave())
end
function c511000987.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000987.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000987.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511000987.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c511000987.mgfilter(c,e,tp,fusc,mg)
	return c:IsControler(c:GetOwner()) and c:IsLocation(LOCATION_GRAVE)
		and bit.band(c:GetReason(),0x40008)==0x40008 and c:GetReasonCard()==fusc
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and fusc:CheckFusionMaterial(mg,c)
end
function c511000987.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	local sumable=true
	local sumtype=tc:GetSummonType()
	local p=tc:GetControler()
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	if tc:IsAbleToExtra() and tc:IsAbleToGrave() then
		op=Duel.SelectOption(tp,aux.Stringid(2407147,0),aux.Stringid(52823314,0))
	elseif tc:IsAbleToExtra() then
		Duel.SelectOption(tp,aux.Stringid(2407147,0))
		op=0
	else
		Duel.SelectOption(tp,aux.Stringid(52823314,0))
		op=1
	end
	local ch=0
	if op==0 then
		ch=Duel.SendtoGrave(tc,REASON_EFFECT)
	else
		ch=Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	end
	if ch~=0 and bit.band(sumtype,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and ct>0 and ct<=Duel.GetLocationCount(p,LOCATION_MZONE)
		and mg:FilterCount(aux.NecroValleyFilter(c511000987.mgfilter),nil,e,p,tc,mg)==ct
		and (ct<=1 or not Duel.IsPlayerAffectedByEffect(p,59822133)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,p,false,false,POS_FACEUP)
	end
end
