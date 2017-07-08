--Infernity Destroyer
function c511023004.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511023004,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCondition(c511023004.damcon)
	e1:SetTarget(c511023004.damtg)
	e1:SetOperation(c511023004.damop)
	c:RegisterEffect(e1)
end
function c511023004.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttacker()
	if d==c then d=Duel.GetAttackTarget() end
	return c:IsRelateToBattle() and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
		and d:IsReason(REASON_BATTLE) and d:IsType(TYPE_MONSTER)
end
function c511023004.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c511023004.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
