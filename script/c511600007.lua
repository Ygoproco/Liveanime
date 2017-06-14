--Cloning (Anime)
--scripted by Larry126
--fixed by MLD
function c511600007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511600007.condition)
	e1:SetTarget(c511600007.target)
	e1:SetOperation(c511600007.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)	
end
function c511600007.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:GetSummonPlayer()==1-tp
end
function c511600007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,ec:GetOriginalCode(),0,ec:GetOriginalType(),ec:GetTextAttack(),ec:GetTextDefense(),
		ec:GetOriginalLevel()+ec:GetOriginalRank(),ec:GetOriginalRace(),ec:GetOriginalAttribute()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,nil)
end
function c511600007.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,ec:GetOriginalCode(),0,ec:GetOriginalType(),ec:GetTextAttack(),ec:GetTextDefense(),
		ec:GetOriginalLevel()+ec:GetOriginalRank(),ec:GetOriginalRace(),ec:GetOriginalAttribute()) then return end
	local tc=Duel.CreateToken(tp,ec:GetOriginalCode())
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
