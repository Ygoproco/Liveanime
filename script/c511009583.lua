--White Stungray
function c511009583.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87255382,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c511009583.cost)
	e1:SetTarget(c511009583.sptg)
	e1:SetOperation(c511009583.spop)
	c:RegisterEffect(e1)
	
end
--White monster collection
c511009126.collection={
	[1571945]=true;[3557275]=true;[9433350]=true;[13429800]=true;
	[15150365]=true;[20193924]=true;[24644634]=true;[32269855]=true;
	[38517737]=true;[73398797]=true;[73891874]=true;[79473793]=true;
	[79814787]=true;[89631139]=true;[92409659]=true;[98024118]=true;
	[22804410]=true;[71039903]=true;[84812868]=true;
	[501000016]=true;
	[511002341]=true;
	[511001977]=true;[511001978]=true;[511001979]=true;[511001980]=true;
	[511001090]=true;[511001091]=true;	
	[95100846]=true;[95100847]=true;
	
}
function c511009583.cfilter(c)
	return (c511009126.collection[c:GetCode()] or c:IsSetCard(0x202)) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c511009583.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009583.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c511009583.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c511009583.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511009583.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
