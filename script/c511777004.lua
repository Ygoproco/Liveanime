--魔法の歯車
function c511777004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511777004.cost)
	e1:SetTarget(c511777004.target)
	e1:SetOperation(c511777004.activate)
	c:RegisterEffect(e1)
end
function c511777004.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x7) and c:IsAbleToGraveAsCost()
end
function c511777004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	local tg=Duel.GetMatchingGroup(c511777004.cfilter,tp,LOCATION_ONFIELD,0,nil)
	if chk==0 then
		e:SetLabel(1)
		return ct<=3 and tg:GetCount()>=3
			and (ct<=0 or tg:IsExists(Card.IsLocation,ct,nil,LOCATION_MZONE))
	end
	local g=nil
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=tg:FilterSelect(tp,Card.IsLocation,ct,ct,nil,LOCATION_MZONE)
		if ct<3 then
			tg:Sub(g)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g2=tg:Select(tp,3-ct,3-ct,nil)
			g:Merge(g2)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=tg:Select(tp,3,3,nil)
	end
	Duel.SendtoGrave(g,REASON_COST)
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
end
function c511777004.filter(c,e,tp)
	return c:IsCode(83104731) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511777004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511777004.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511777004.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local ct=0
	if ft==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511777004.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
		ct=Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c511777004.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g1:GetCount()>0 and Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,true,false,POS_FACEUP) then ct=ct+1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c511777004.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g2:GetCount()>0 and Duel.SpecialSummonStep(g2:GetFirst(),0,tp,tp,true,false,POS_FACEUP) then ct=ct+1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g3=Duel.SelectMatchingCard(tp,c511777004.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g3:GetCount()>0 and Duel.SpecialSummonStep(g3:GetFirst(),0,tp,tp,true,false,POS_FACEUP) then ct=ct+1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g4=Duel.SelectMatchingCard(tp,c511777004.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g4:GetCount()>0 and Duel.SpecialSummonStep(g4:GetFirst(),0,tp,tp,true,false,POS_FACEUP) then ct=ct+1 end
		Duel.SpecialSummonComplete()
	end
end
