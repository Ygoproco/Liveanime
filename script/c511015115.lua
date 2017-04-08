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
	if g:GetCount()>0 and m:GetCount()>1 then
		local tc=g:GetFirst()
		Duel.Overlay(tc,m)
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
			
		--Destroy
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetOperation(c511015115.desop)
		e:GetHandler():RegisterEffect(e1)
		e1:SetLabelObject(tc)
	end
end

function c511015115.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		local m = tc:GetOverlayGroup():Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false)
		if m:GetCount()>0 and Duel.Destroy(tc,REASON_EFFECT)>0 then
			local zones = Duel.GetLocationCount(tp,LOCATION_MZONE)
			if m:GetCount()>zones then
				m=m:Select(tp,zones,zones,nil)
			end
			Duel.SpecialSummon(m,0,tp,tp,true,false,POS_FACEUP)
		end
	end
	e:Reset()
end