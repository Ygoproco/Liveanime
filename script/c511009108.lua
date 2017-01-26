--Shooting Star Sword
--fixed by MLD
function c511009108.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511009108.indes)
	c:RegisterEffect(e3)
	--chain atk
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(35884610,0))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EVENT_BATTLE_DESTROYING)
	e6:SetCondition(c511009108.atcon)
	e6:SetOperation(c511009108.atop)
	c:RegisterEffect(e6)
end
function c511009108.indes(e,c)
	local lv=e:GetHandler():GetEquipTarget():GetLevel()
	return c:IsLevelBelow(lv)
end
function c511009108.atcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetEquipTarget()
	local bc=tc:GetBattleTarget()
	return tc==eg:GetFirst() and bc and bc:IsControler(1-tp) and bc:IsLevelBelow(tc:GetLevel()) and not tc:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c511009108.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) or not tc then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	tc:RegisterEffect(e1)
end
