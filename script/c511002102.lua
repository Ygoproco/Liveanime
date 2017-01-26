--Xyz Unity
function c511002102.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_XYZ))
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98649372,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002102.postg)
	e2:SetOperation(c511002102.posop)
	c:RegisterEffect(e2)
	--multi attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511002102.macon)
	e4:SetCost(c511002102.macost)
	e4:SetOperation(c511002102.maop)
	c:RegisterEffect(e4)
end
function c511002102.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipTarget():IsDefensePos() end
end
function c511002102.atkfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsType(TYPE_XYZ)
end
function c511002102.posop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.ChangePosition(eq,POS_FACEUP_ATTACK)
	local atk=0
	local g=Duel.GetMatchingGroup(c511002102.atkfilter,tp,LOCATION_MZONE,0,eq)
	local bc=g:GetFirst()
	while bc do
		atk=atk+bc:GetAttack()
		bc=g:GetNext()
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(atk)
	eq:RegisterEffect(e1)
end
function c511002102.macon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511002102.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToGraveAsCost()
end
function c511002102.macost(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return Duel.IsExistingMatchingCard(c511002102.cfilter,tp,LOCATION_MZONE,0,1,eq) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002102.cfilter,tp,LOCATION_MZONE,0,1,1,eq)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002102.maop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
