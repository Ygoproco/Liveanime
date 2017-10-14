--Time Machine (Anime)
function c511247012.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511247012.target)
	e1:SetOperation(c511247012.activate)
	c:RegisterEffect(e1)
end
function c511247012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tc:GetPreviousControler(),LOCATION_MZONE)>0 and eg:GetCount()==1
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,tc:GetPreviousPosition(),tc:GetPreviousControler()) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,eg,1,0,0)
end
function c511247012.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tc:GetPreviousControler(),false,false,tc:GetPreviousPosition())
		Duel.MoveToField(tc,tc:GetPreviousControler(),tc:GetPreviousControler(),LOCATION_MZONE,tc:GetPreviousPosition(),true)
	end
end

