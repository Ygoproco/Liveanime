--D - doom dance 
function c511004415.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511004415.condition)
	e1:SetTarget(c511004415.target)
	e1:SetOperation(c511004415.operation)
	c:RegisterEffect(e1)
end
function c511004415.filter1(c,e,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_MONSTER)
end
function c511004415.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg and eg:IsExists(c511004415.filter1,1,nil,e,tp) and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_MAIN2
end
function c511004415.filter2(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xc008) and c:IsAbleToRemove()
end
function c511004415.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return eg and eg:IsExists(c511004415.filter1,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511004415.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local tg1=eg:FilterSelect(tp,c511004415.filter1,1,1,nil,e,tp)
	local tg2=Duel.SelectMatchingCard(tp,c511004415.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp):GetFirst()
	Duel.SetTargetCard(tg1)
	e:SetLabel(tg2:GetAttack())
	Duel.Remove(tg2,0,REASON_EFFECT)
end
function c511004415.filter3(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xc008) and c:GetAttackedGroupCount()~=0
end
function c511004415.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	if tg then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-e:GetLabel())
		tg:RegisterEffect(e1)
		if Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(c511004415.filter3,tp,LOCATION_MZONE,0,1,nil,e,tp) then
		   local destiny=Duel.SelectMatchingCard(tp,c511004415.filter3,tp,LOCATION_MZONE,0,1,1,nil,e,tp):GetFirst()
		   local e1=Effect.CreateEffect(c)
		   e1:SetType(EFFECT_TYPE_SINGLE)
		   e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		   e1:SetValue(1)
		   e1:SetReset(RESET_EVENT+0x1e0000+RESET_PHASE+PHASE_END)
		   destiny:RegisterEffect(e1)
		   local e2=e1:Clone()
		   e2:SetType(EFFECT_TYPE_FIELD)
		   e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		   e2:SetRange(LOCATION_MZONE)
		   e2:SetTargetRange(0,LOCATION_MZONE)
		   e2:SetLabelObject(tg)
		   e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		   e2:SetCondition(c511004415.ocon1)
		   e2:SetTarget(c511004415.tg)
		   destiny:RegisterEffect(e2)
		end
	end
end
function c511004415.ocon1(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c
end
function c511004415.tg(e,c)
	return c~=e:GetLabelObject()
end