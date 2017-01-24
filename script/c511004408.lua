--Predator Germination
function c511004408.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004408.tg)
	e1:SetOperation(c511004408.op)
	c:RegisterEffect(e1)
end
function c511004408.tg(e,tp,eg,ev,ep,re,r,rp,chk)
	local t1=Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and Duel.GetAttacker() and Duel.GetAttacker():IsCanBeEffectTarget(e) and Duel.GetAttackTarget() and Duel.GetAttackTarget():IsAttribute(ATTRIBUTE_DARK)
	local t2=not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and Duel.IsPlayerCanSpecialSummonMonster(tp,123456789,0xf3,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_DARK)
	if chk==0 then return t1 or t2 end
	local opt=0
	if t1 and t2 then
		opt=Duel.SelectOption(tp,aux.Stringid(123456789,0),aux.Stringid(123456789,1),aux.Stringid(123456789,2))
	elseif t1 then
		opt=Duel.SelectOption(tp,aux.Stringid(123456789,0))
	else
		opt=Duel.SelectOption(tp,aux.Stringid(123456789,1))+1
	end
	if opt==0 or opt==2 then
		Duel.SetTargetCard(Duel.GetAttacker())
	end
	if opt==1 or opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	end
	e:SetLabel(opt)
end
function c511004408.op(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local opt=e:GetLabel()
	if opt==0 or opt==2 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE)
		e1:SetValue(1)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e1)
		Duel.Destroy(a,REASON_EFFECT)
	end
	if opt==1 or opt==2 then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and Duel.IsPlayerCanSpecialSummonMonster(tp,123456789,0xf3,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_DARK) then
			for i=1,3 do
				local token=Duel.CreateToken(tp,123456789)
				Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			end
			Duel.SpecialSummonComplete()
		end
	end
end