--Brave-Eyes Pendulum Dragon (Anime)
--Scripted By TheOnePharaoh
--Battle Destruction Effect will need to be updated with the new core functions (same as Quasar)
function c511010508.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x10f2),aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),true)
	--ATK Change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_COST)
	e1:SetOperation(c511010508.atkop)
	c:RegisterEffect(e1)
	--always Battle destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCondition(c511010508.descon)
	e2:SetOperation(c511010508.desop)
	c:RegisterEffect(e2)
end

function c511010508.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetMatchingGroup(aux.nzatk,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	if tg:GetCount()>0 and Duel.SelectYesNo(tp,94) then
	Duel.Hint(HINT_CARD,0,511010508)
	local numatk=0
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		numatk=numatk+1
		tc=tg:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(numatk*100)
	e1:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e1)
	end
	--Duel.BreakEffect()
	Duel.Readjust()
end
function c511010508.descon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return e:GetHandler():IsRelateToBattle() and bc~=nil
end
function c511010508.desfilter(c,ca)
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and (not ca or ca==c)
end
function c511010508.desop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsStatus(STATUS_BATTLE_DESTROYED) or not d:IsStatus(STATUS_BATTLE_DESTROYED) then
		local g=Group.FromCards(a,d)
		if a:IsAttackPos() and d:IsAttackPos() then
			if a:GetAttack()==d:GetAttack()  then
				g=g:Filter(c511010508.desfilter,nil,nil)
			elseif a:GetAttack()<d:GetAttack() then
				g=g:Filter(c511010508.desfilter,nil,a)
			elseif a:GetAttack()>d:GetAttack() then
				g=g:Filter(c511010508.desfilter,nil,d)
			else
				g=Group.CreateGroup()
			end
		elseif a:IsAttackPos() and d:IsDefensePos() then
			if a:GetAttack()>d:GetDefense() then
				g=g:Filter(c511010508.desfilter,nil,d)
			else
				g=Group.CreateGroup()
			end
		else
			g=Group.CreateGroup()
		end
		local tc=g:GetFirst()
		while tc do
			local bc=e:GetHandler():GetBattleTarget()
			if tc==bc then
			Duel.Hint(HINT_CARD,0,511010508)
				if tc:SetStatus(STATUS_BATTLE_DESTROYED,true)~=0 and tc:IsLocation(LOCATION_ONFIELD) then
					Duel.Destroy(tc,REASON_BATTLE)
					if tc:SetStatus(STATUS_BATTLE_DESTROYED,true)~=0 and tc:IsLocation(LOCATION_ONFIELD) then
						Duel.SendtoGrave(tc,REASON_DESTROY+REASON_BATTLE)
					end
				end
			end
			tc=g:GetNext()
		end
	end
end