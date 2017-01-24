--Raidraptor - Iron Heart
--fixed by MLD
function c511009317.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511009317.filter)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--summon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c511009317.sumcon)
	e4:SetTarget(c511009317.sumtg)
	e4:SetOperation(c511009317.sumop)
	c:RegisterEffect(e4)
end
function c511009317.filter(c)
	return c:IsSetCard(0xba) and c:IsType(TYPE_XYZ)
end
function c511009317.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()==Duel.GetTurnCount() and not e:GetHandler():IsReason(REASON_RETURN)
end
function c511009317.ovfilter(c,e)
	return c:IsSetCard(0xba) and c:IsType(TYPE_XYZ) and c:IsType(TYPE_MONSTER) and (not e or c:IsCanBeEffectTarget(e))
end
function c511009317.spfilter(c,e,tp,e2)
	return c:IsSetCard(0xba) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c511009317.ovfilter,tp,LOCATION_GRAVE,0,1,c) and (not e2 or c:IsCanBeEffectTarget(e2))
end
function c511009317.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511009317.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local sg=Duel.GetMatchingGroup(c511009317.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp,e)
	local og=Duel.GetMatchingGroup(c511009317.ovfilter,tp,LOCATION_GRAVE,0,nil,e)
	local g
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if sg:GetCount()==og:GetCount() then
		g=sg:Select(tp,2,2,nil)
	else
		g=sg:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g2=og:Select(tp,1,1,g:GetFirst())
		g:Merge(g2)
	end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511009317.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()~=2 then return end
	local sg=g:Filter(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false)
	if sg:GetCount()==0 then return end
	local tc
	if sg:GetCount()==1 then
		tc=sg:GetFirst()
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		g:RemoveCard(tc)
		Duel.Overlay(tc,g)
	end
end
