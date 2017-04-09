--Commander Covington (Manga)
function c511015115.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015115,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511015115.target)
	e1:SetOperation(c511015115.operation)
	c:RegisterEffect(e1)
end
function c511015115.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x36)
end
function c511015115.filter(c,e,tp)
	return c:IsCode(58054262) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511015115.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015115.cfilter,tp,LOCATION_MZONE,0,2,nil)
		and Duel.IsExistingMatchingCard(c511015115.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015115.operation(e,tp,eg,ep,ev,re,r,rp)
	local m=Duel.GetMatchingGroup(c511015115.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511015115.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if e:GetHandler():IsRelateToEffect(e) and g:GetCount()>0 and m:GetCount()>1 then
		local tc=g:GetFirst()
		
		local c=m:GetFirst()
		while c do
			Duel.Overlay(tc,c:GetOverlayGroup())	
			c=m:GetNext()
		end
		
		Duel.Overlay(tc,m)
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
			
		--Destroy
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetOperation(c511015115.desop)
		e:GetHandler():RegisterEffect(e1)
		e1:SetLabelObject(tc)
		
		-- Adjust
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EVENT_ADJUST)	
		e2:SetRange(LOCATION_MZONE)
		e2:SetOperation(c511015115.adjop)
		e:GetHandler():RegisterEffect(e2)
		e2:SetLabelObject(tc)
	end
end
function c511015115.desop(e,tp,eg,ep,ev,re,r,rp)	
	local tc=e:GetLabelObject()
	local m = tc:GetOverlayGroup():Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false)
	if tc and tc:IsLocation(LOCATION_MZONE) and Duel.Destroy(tc,REASON_EFFECT)>0 and m:GetCount()>0 then	
		local zones = Duel.GetLocationCount(tp,LOCATION_MZONE)
		if m:GetCount()>zones then
			m=m:Select(tp,zones,zones,nil)
		end
		Duel.SpecialSummon(m,0,tp,tp,false,false,POS_FACEUP)
	end
	e:Reset()
end
function c511015115.adjop(e,tp,eg,ep,ev,re,r,rp)	
	if e:GetLabelObject() and e:GetHandler():IsDisabled() then
		c511015115.desop(e,tp,eg,ep,ev,re,r,rp)
	end
end