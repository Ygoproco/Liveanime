--Infection Extension
--インフェクション・エクステンション
--  By Shad3
--cleaned up and fixed by MLD
function c511005084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetCondition(c511005084.condition)
	e1:SetTarget(c511005084.target)
	e1:SetOperation(c511005084.activate)
	c:RegisterEffect(e1)
	--Summon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetTarget(c511005084.sumtg)
	c:RegisterEffect(e2)
	--[[local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e3)]]
	--IBToken Destroyed
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e4:SetCondition(c511005084.descon)
	e4:SetTarget(c511005084.destg)
	e4:SetOperation(c511005084.desop)
	c:RegisterEffect(e4)
end
function c511005084.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetActivityCount(tp,ACTIVITY_SUMMON)==0
end
function c511005084.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonMonster(tp,511005082,0,0x4011,300,300,1,RACE_FIEND,ATTRIBUTE_DARK) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c511005084.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not Duel.IsPlayerCanSpecialSummonMonster(tp,511005082,0,0x4011,300,300,1,RACE_FIEND,ATTRIBUTE_DARK) 
		or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.CreateToken(tp,511005082)
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e1:SetOperation(c511005084.damop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function c511005084.damop(e,tp,eg,ep,ev,re,r,rp)
	if ev>0 and Duel.SelectYesNo(tp,aux.Stringid(4001,14)) then
		Duel.ChangeBattleDamage(tp,0)
		Duel.ChangeBattleDamage(1-tp,0)
	end
end
function c511005084.sumtg(e,c,tp,sumtp,sumpos)
	return bit.band(sumpos,POS_DEFENSE)==POS_DEFENSE
end
function c511005084.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCode,1,nil,511005082)
end
function c511005084.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c511005084.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,300,REASON_EFFECT)
		end
	end
end
