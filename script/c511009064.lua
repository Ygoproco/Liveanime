--超重武者ホラガ－E
--fixed by MLD
function c511009064.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511009064.hspcon)
	e1:SetOperation(c511009064.hspop)
	c:RegisterEffect(e1)
end
function c511009064.filter(c)
	return c:IsSetCard(0x9a) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c511009064.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP) 
		and Duel.IsExistingMatchingCard(c511009064.filter,tp,LOCATION_HAND,0,1,c)
end
function c511009064.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511009064.filter,tp,LOCATION_HAND,0,1,1,c)
	Duel.SendtoGrave(g,REASON_COST)
end
