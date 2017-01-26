--機関連結
function c450000001.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),nil,c450000001.cost)
	--Pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--double original atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ADJUST)
	e5:SetRange(LOCATION_SZONE)
	e5:SetOperation(c450000001.atkop)
	c:RegisterEffect(e5)
	--check for doubling
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(511000694)
	c:RegisterEffect(e6)
end
function c450000001.costfilter(c)
	return c:IsRace(RACE_MACHINE) and c:GetLevel()>=8 and c:IsAbleToRemoveAsCost()
end
function c450000001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c450000001.costfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c450000001.costfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c450000001.chkfilter(c,eq)
	local ec=c:GetEquipTarget()
	return c:IsHasEffect(511000694) and ec and ec==eq and not c:IsDisabled()
end
function c450000001.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=c:GetEquipTarget()
	local g=Duel.GetMatchingGroup(c450000001.chkfilter,tp,LOCATION_SZONE,LOCATION_SZONE,c,eq)
	if eq and c:GetFlagEffect(511000695)==0 then
		c:ResetEffect(RESET_DISABLE,RESET_EVENT)
		local tc=g:GetFirst()
		while tc do
			tc:RegisterFlagEffect(511000695,RESET_EVENT+0x1ff0000,0,0)
			tc=g:GetNext()
		end
		local atk=eq:GetBaseAttack()
		for i=1,g:GetCount()+1 do
			atk=atk*2
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
