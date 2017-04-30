--Magical Silk Hat
--fixed by MLD
function c511009375.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511009375.condition)
	e1:SetTarget(c511009375.target)
	e1:SetOperation(c511009375.activate)
	c:RegisterEffect(e1)
end
function c511009375.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511009375.filter1(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),nil,0x11,0,0,1,RACE_SPELLCASTER,ATTRIBUTE_LIGHT,POS_FACEDOWN_ATTACK)
		and Duel.IsExistingMatchingCard(c511009375.filter2,tp,LOCATION_HAND,0,1,c,e,tp)
end
function c511009375.filter2(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),nil,0x11,0,0,1,RACE_SPELLCASTER,ATTRIBUTE_LIGHT,POS_FACEDOWN_ATTACK)
end
function c511009375.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009375.filter1,tp,LOCATION_HAND,0,1,nil,e,tp)
		and not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c511009375.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g1=Duel.GetMatchingGroup(c511009375.filter1,tp,LOCATION_HAND,0,nil,e,tp)
	if g1:GetCount()<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg2=Duel.SelectMatchingCard(tp,c511009375.filter2,tp,LOCATION_HAND,0,1,1,sg1:GetFirst(),e,tp)
	sg1:Merge(sg2)
	local tc=sg1:GetFirst()
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEDOWN_ATTACK)
		tc:RegisterFlagEffect(51109375,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
		e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RACE)
		e2:SetValue(RACE_SPELLCASTER)
		tc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e3:SetValue(ATTRIBUTE_LIGHT)
		tc:RegisterEffect(e3,true)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_SET_BASE_ATTACK)
		e4:SetValue(0)
		tc:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_SET_BASE_DEFENSE)
		e5:SetValue(0)
		tc:RegisterEffect(e5,true)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CHANGE_LEVEL)
		e6:SetValue(1)
		tc:RegisterEffect(e6,true)
		tc=sg1:GetNext()
	end
	Duel.ShuffleSetCard(sg1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCondition(c511009375.atkcon)
	e1:SetTarget(c511009375.atktg)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetOperation(c511009375.checkop)
	e2:SetLabelObject(e2)
	Duel.RegisterEffect(e2,tp)
	sg1:KeepAlive()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCountLimit(1)
	e3:SetLabel(fid)
	e3:SetLabelObject(sg1)
	e3:SetCondition(c511009375.descon)
	e3:SetOperation(c511009375.desop)
	Duel.RegisterEffect(e3,tp)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetLabel(fid)
	e4:SetLabelObject(sg1)
	e4:SetCondition(c511009375.damcon)
	e4:SetOperation(c511009375.damop)
	Duel.RegisterEffect(e4,tp)
end
function c511009375.atkcon(e)
	return e:GetHandler():GetFlagEffect(30606547)~=0
end
function c511009375.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel()
end
function c511009375.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(30606547)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	e:GetHandler():RegisterFlagEffect(30606547,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c511009375.desfilter(c,fid)
	return c:GetFlagEffectLabel(51109375)==fid
end
function c511009375.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g or not g:IsExists(c511009375.desfilter,1,nil,e:GetLabel()) then
		if g then
			g:DeleteGroup()
		end
		e:Reset()
		return false
	else return true end
end
function c511009375.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511009375.desfilter,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end
function c511009375.damfilter(c,fid)
	return c:GetFlagEffectLabel(51109375)==fid and Duel.GetAttackTarget()==c
end
function c511009375.damcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g or not g:IsExists(c511009375.desfilter,1,nil,e:GetLabel()) then
		if g then
			g:DeleteGroup()
		end
		e:Reset()
		return false
	else return g:IsExists(c511009375.damfilter,1,nil,e:GetLabel()) end
end
function c511009375.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tc=g:Filter(c511009375.damfilter,nil,e:GetLabel()):GetFirst()
	if tc:IsType(TYPE_SPELL+TYPE_TRAP) then
		Duel.ChangeBattleDamage(tp,0)
		Duel.ChangeBattleDamage(1-tp,0)
	else
		Duel.ChangeBattleDamage(tp,ev*2)
		Duel.ChangeBattleDamage(1-tp,ev*2)
	end
end
