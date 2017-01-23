--Astrograph Sorcerer (Anime)
--アストログラフ・マジシャン
function c511012002.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511012002,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511012002.spcon)
	e1:SetTarget(c511012002.sptg)
	e1:SetOperation(c511012002.spop)
	c:RegisterEffect(e1)
	--special summon Zarc
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511012002,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511012002.hncost)
	e2:SetTarget(c511012002.hntg)
	e2:SetOperation(c511012002.hnop)
	c:RegisterEffect(e2)
end
function c511012002.spcfilter(c,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511012002.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511012002.spcfilter,1,nil,tp)
end
function c511012002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511012002.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		--if eg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(511012002,1)) then
		if eg:GetCount()>0 and Duel.SelectYesNo(tp,210) then
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		local tc=g:GetFirst()
		while tc do
		Duel.MoveToField(tc,tp,tc:GetPreviousControler(),tc:GetPreviousLocation(),tc:GetPreviousPosition(),true)
		Duel.MoveSequence(tc,tc:GetPreviousSequence())
		tc=g:GetNext()
		end
		end
		elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c511012002.cfilter(c)
	return (c:IsCode(16178681) or c:IsCode(16195942) or c:IsCode(82044279) or c:IsCode(41209827))
		and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c511012002.cfilter1(c,g,ft)
	local mg=g:Clone()
	mg:RemoveCard(c)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return c:IsCode(16178681) and mg:IsExists(c511012002.cfilter2,1,nil,mg,ft)
end
function c511012002.cfilter2(c,g,ft)
	local mg=g:Clone()
	mg:RemoveCard(c)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return c:IsCode(16195942) and mg:IsExists(c511012002.cfilter3,1,nil,mg,ft)
end
function c511012002.cfilter3(c,g,ft)
	local mg=g:Clone()
	mg:RemoveCard(c)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return c:IsCode(82044279) and mg:IsExists(c511012002.cfilter4,1,nil,ft)
end
function c511012002.cfilter4(c,ft)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return c:IsCode(41209827) and ft>0
end
function c511012002.hncost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local mg=Duel.GetMatchingGroup(c511012002.cfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return c:IsReleasable()
		and mg:IsExists(c511012002.cfilter1,1,nil,mg,ft+1) end
	local g=Group.CreateGroup()
	ft=ft+1
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rc1=mg:FilterSelect(tp,c511012002.cfilter1,1,1,nil,mg,ft):GetFirst()
	g:AddCard(rc1)
	mg:RemoveCard(rc1)
	if rc1:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rc2=mg:FilterSelect(tp,c511012002.cfilter2,1,1,nil,mg,ft):GetFirst()
	g:AddCard(rc2)
	mg:RemoveCard(rc2)
	if rc2:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rc3=mg:FilterSelect(tp,c511012002.cfilter3,1,1,nil,mg,ft):GetFirst()
	g:AddCard(rc3)
	mg:RemoveCard(rc3)
	if rc3:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rc4=mg:FilterSelect(tp,c511012002.cfilter4,1,1,nil,ft):GetFirst()
	g:AddCard(rc4)
	Duel.Release(c,REASON_COST)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511012002.hnfilter(c,e,tp)
	return c:IsCode(13331639) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,true,true)
end
function c511012002.hntg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511012002.hnfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511012002.hnop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511012002.hnfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,SUMMON_TYPE_FUSION,tp,tp,true,true,POS_FACEUP)
	end
end
