--Crown of Command
function c511002185.initial_effect(c)
	aux.AddEquipProcedure(c)
	--lose atk and def
	local e2=Effect.CreateEffect(c)	
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511002185.atkop)
	c:RegisterEffect(e2)
end
function c511002185.atkop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local bc=eq:GetBattleTarget()
	if not bc or not bc:IsRelateToBattle() then return end
	Duel.Hint(HINT_CARD,0,511002185)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-500)
	bc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	bc:RegisterEffect(e2)
end
