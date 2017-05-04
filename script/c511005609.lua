-- Kageningen 
--scripted by GameMaster (GM)
function c511005609.initial_effect(c)
--spsummon
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511005609,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c511005609.target)
	e1:SetOperation(c511005609.operation)
	c:RegisterEffect(e1)
	--damage change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c511005609.damop)
	c:RegisterEffect(e2)
end
function c511005609.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511005609.filter(c,e,tp)
	return  c:GetOriginalCode()==511005609 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511005609.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511005609.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c511005609.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(e,0)
end
