--王家之劍
function c100000370.initial_effect(c)
	c:EnableCounterPermit(0x95)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,6614221))
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c100000370.value)
	c:RegisterEffect(e2)
	--DAMAGE
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c100000370.dacost)
	e4:SetOperation(c100000370.daop)
	c:RegisterEffect(e4)	
	--add
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c100000370.drcon)
	e5:SetOperation(c100000370.drop)
	c:RegisterEffect(e5)
end
function c100000370.value(e,c)
	return e:GetHandler():GetCounter(0x95)*800
end
function c100000370.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:GetControler()==c:GetEquipTarget():GetControler()
		and c:GetEquipTarget():IsAbleToGraveAsCost() and e:GetHandler():GetCounter(0x95)>3 end
	local g=Group.FromCards(c,c:GetEquipTarget())
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000370.daop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,4000,REASON_EFFECT)
end
function c100000370.drcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and (ec==Duel.GetAttacker() or ec==Duel.GetAttackTarget())
end
function c100000370.drop(e,tp,eg,ep,ev,re,r,rp)
	local e6=Effect.CreateEffect(e:GetHandler())
	e6:SetCategory(CATEGORY_COUNTER)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c100000370.actg)
	e6:SetOperation(c100000370.acop)
	e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e6)
end
function c100000370.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanAddCounter(0x95,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x95)
end
function c100000370.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c and c:IsFaceup() and c:IsRelateToEffect(e) then
		c:AddCounter(0x95,1)
	end
end
