--Cubic Ascension
function c511009101.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511009101.condition)
	e1:SetTarget(c511009101.target)
	e1:SetOperation(c511009101.operation)
	c:RegisterEffect(e1)
end
function c511009101.condition(e,tp,eg,ev,ep,re,r,rp)
	local a=Duel.GetAttacker()
	return a and a:IsControler(1-tp)
end
function c511009101.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and c:IsType(TYPE_MONSTER) and c:IsCode(15610297)
end
function c511009101.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511009101.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511009101.operation(e,tp,eg,ev,ep,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009101.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)~=0 then
		Duel.ChangeAttackTarget(tc)
	end
end