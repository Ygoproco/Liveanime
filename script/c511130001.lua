--Infernity Randomizer (Anime)
--cleaned up by MLD
function c511130001.initial_effect(c)
    --draw, send to grave and effect damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
    e1:SetCondition(c511130001.spcon)
    e1:SetTarget(c511130001.target)
    e1:SetOperation(c511130001.operation)
	c:RegisterEffect(e1)
end
function c511130001.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c511130001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511130001.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
    if Duel.Draw(tp,1,REASON_EFFECT)>0 then
		Duel.SendtoGrave(tc,REASON_EFFECT)
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,tc:GetLevel()*200,REASON_EFFECT)
		else
			Duel.Damage(tp,500,REASON_EFFECT)
		end
	end
end
