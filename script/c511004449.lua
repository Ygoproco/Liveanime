--Cubic Defense
--fixed by MLD
function c511004449.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c511004449.condition)
	e1:SetTarget(c511004449.target)
	e1:SetOperation(c511004449.activate)
	c:RegisterEffect(e1)
end
function c511004449.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(1-tp) then a,d=d,a end
	if not d or d:IsControler(1-tp) or d:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then return false end
	e:SetLabelObject(d)
	if a:IsPosition(POS_FACEUP_DEFENSE) then
		if not a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return false end
		if a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
			if a:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 then
				if d:IsAttackPos() then
					if a:GetDefense()==d:GetAttack() and not d:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return a:GetDefense()~=0
					else
						return a:GetDefense()>=d:GetAttack()
					end
				else
					return a:GetDefense()>d:GetDefense()
				end
			elseif a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
				if d:IsAttackPos() then
					if a:GetAttack()==d:GetAttack() and not a:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return a:GetAttack()~=0
					else
						return a:GetAttack()>=d:GetAttack()
					end
				else
					return a:GetAttack()>d:GetDefense()
				end
			end
		end
	else
		if d:IsAttackPos() then
			if a:GetAttack()==d:GetAttack() and not a:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
				return a:GetAttack()~=0
			else
				return a:GetAttack()>=d:GetAttack()
			end
		else
			return a:GetAttack()>d:GetDefense()
		end
	end
end
function c511004449.filter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511004449.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511004449.filter,tp,LOCATION_HAND,0,2,nil,e,tp,tc:GetCode()) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND)
end
function c511004449.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		if tc:RegisterEffect(e1)>0 then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
			local g=Duel.GetMatchingGroup(c511004449.filter,tp,LOCATION_HAND,0,nil,e,tp,tc:GetCode())
			if g:GetCount()>1 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sg=g:Select(tp,2,2,nil)
				Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
