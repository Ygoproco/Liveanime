--Cyberse Annihilation
--scripted by Larry126
function c511600015.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511600015.filter,c511600015.eqlimit,nil,nil,c511600015.operation,nil)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47274077,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetRange(LOCATION_SZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511600015.damcon)
	e1:SetTarget(c511600015.damtg)
	e1:SetOperation(c511600015.damop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY)
	e2:SetCondition(c511600015.atkcon)
	e2:SetValue(c511600015.atkval)
	c:RegisterEffect(e2)
end
function c511600015.atkcon(e)
	local ec=e:GetHandler():GetEquipTarget()
	local tc=ec:GetBattleTarget()
	return ec and tc and ec:IsFaceup() and tc:IsFaceup() and tc:IsControler(1-ec:GetControler()) and Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL 
end
function c511600015.atkval(e,c)
	return e:GetHandler():GetEquipTarget():GetBattleTarget():GetAttack()
end
function c511600015.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	return ec==e:GetHandler():GetEquipTarget() and bc:IsReason(REASON_BATTLE)
end
function c511600015.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	local dam=bc:GetPreviousAttackOnField()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511600015.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511600015.eqlimit(e,c)
	return c:IsRace(RACE_CYBERS)
end
function c511600015.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERS)
end
function c511600015.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end