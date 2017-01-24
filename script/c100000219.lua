--破滅の紋章
function c100000219.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c100000219.filter)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c100000219.damtg)
	e4:SetOperation(c100000219.damop)
	c:RegisterEffect(e4)
end
function c100000219.filter(c)
	local code=c:GetCode()
	return c:IsSetCard(0x76) or code==23649496 or code==47387961
end
function c100000219.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local dam=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*300
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,dam)
end
function c100000219.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local dam=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*300
	Duel.Damage(tp,dam,REASON_EFFECT,true)
	Duel.Damage(1-tp,dam,REASON_EFFECT,true)
	Duel.RDComplete()
end
