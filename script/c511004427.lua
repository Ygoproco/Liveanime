--Black Feather Reverse
function c511004427.initial_effect(c)
	--activate 1 (battle damage)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511004427.condition1)
	e1:SetOperation(c511004427.operation1)
	c:RegisterEffect(e1)
	--activate 2 (effect damage)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511004427.condition2)
	e2:SetOperation(c511004427.operation2)
	c:RegisterEffect(e2)
end
function c511004427.condition1(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetBattleDamage(tp)>0 or Duel.GetBattleDamage(1-tp)>0
end
function c511004427.operation1(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local dam=0
	if Duel.GetBattleDamage(tp)>0 then dam=Duel.GetBattleDamage(tp) end
	if Duel.GetBattleDamage(1-tp)>0 then dam=dam+Duel.GetBattleDamage(1-tp) end
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e1:SetValue(1)
	e1:SetCountLimit(1)
	Duel.RegisterEffect(e1,tp)
	c511004427.blackwingspam(e,tp,dam)
end
function c511004427.condition2(e,tp,eg,ev,ep,re,r,rp)
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp) or aux.damcon1(e,1-tp,eg,ep,ev,re,r,rp)
end
function c511004427.operation2(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_CHAIN)
	e1:SetValue(c511004427.val)
	e1:SetCountLimit(1)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCondition(c511004427.condition3)
	e2:SetOperation(c511004427.operation3)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e2,tp)
	--c511004427.blackwingspam(e,tp,dam)
end
function c511004427.val(e,tp,ev)
	if not e:GetLabel() then
		e:SetLabel(ev)
	else
		e:SetLabel(ev+e:GetLabel())
	end
	return 0
end
function c511004427.condition3(e,tp,eg,ev,ep,re,r,rp)
	e:SetLabel(e:GetLabelObject():GetLabel())
	return e:GetLabelObject():GetLabel()~=0
end
function c511004427.operation3(e,tp,eg,ev,ep,re,r,rp)
	local dam=e:GetLabel()
	c511004427.blackwingspam(e,tp,dam)
end
function c511004427.filter(c,e,tp,dam)
	return c:IsType(TYPE_MONSTER) and c:IsType(TYPE_SYNCHRO) and c:IsSetCard(0x33) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and c:GetAttack()==dam
end
function c511004427.blackwingspam(e,tp,dam)
	local tg=Duel.SelectMatchingCard(tp,c511004427.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,dam)
	local tc=tg:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
	end
end