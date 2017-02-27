--Electrode Beast Cation
-- [Monster / Effect]
-- [Thunder:Light 2* 300/300]
function c511008507.initial_effect(c)
	-- [Effect e1 and e2] this card is successfully summoned (normal and flip)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511008507,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511008507.sptg)
	e1:SetOperation(c511008507.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end

---------- ################# < Effect e1|e2|e3 > ################# ----------


function c511008507.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	-- Target: If can be Special Summon of Deck a 'Electrode Beast Anion (511008506)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511008507.filterCanBeSpecialThisCard,tp,LOCATION_DECK,0,1,nil,e,tp, 511008506) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end

function c511008507.spop(e,tp,eg,ep,ev,re,r,rp)
	-- Operation: Special Summon of Deck a 'Electrode Beast Anion
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511008507.filterCanBeSpecialThisCard,tp,LOCATION_DECK,0,1,1,nil,e,tp, 511008506)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c511008507.filterCanBeSpecialThisCard(c,e,tp,codeOfCard)
	return c:IsCode(codeOfCard) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

---------- ################# < /Effect e1|e2|e3 > ################# ----------