--Flame Swordman (DOR)
--scripted by GameMaster (GM)
function c511005651.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511005651,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511005651.con)
	e1:SetOperation(c511005651.op)
	c:RegisterEffect(e1)
end
function c511005651.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsRace(RACE_DINOSAUR)
end
function c511005651.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(300)
		c:RegisterEffect(e1)
			end
end
