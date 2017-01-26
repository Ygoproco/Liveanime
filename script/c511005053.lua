--Galaxy Shot
--  By Shad3
--cleaned and updated by MLD
function c511005053.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0x107b))
	--eff
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c511005053.damcon)
	e3:SetTarget(c511005053.damtg)
	e3:SetOperation(c511005053.damop)
	c:RegisterEffect(e3)
end
function c511005053.damcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and eg:GetFirst()==e:GetHandler():GetEquipTarget()
end
function c511005053.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetEquipTarget()
	if chk==0 then return tc and tc:IsReleasable() end
	local atk=tc:GetAttack()
	Duel.Release(tc,REASON_COST)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511005053.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
