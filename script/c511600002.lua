--Dimension Duel
--scripted by Larry126
--note: Please contact with me if wanting to edit this script
function c511600002.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(0xff)
	e1:SetCondition(c511600002.con)
	e1:SetOperation(c511600002.op)
	c:RegisterEffect(e1)
end
function Auxiliary.ComposeNumberDigitByDigit(tp,min,max)
	if min>max then min,max=max,min end
	local mindc=#tostring(min)
	local maxdc=#tostring(max)
	local dbdmin={}
	local dbdmax={}
	local mi=maxdc-1
	local aux=min
	for i=1,maxdc do
		dbdmin[i]=math.floor(aux/(10^mi))
		aux=aux%(10^mi)
		mi=mi-1
	end
	aux=max
	mi=maxdc-1
	for i=1,maxdc do
		dbdmax[i]=math.floor(aux/(10^mi))
		aux=aux%(10^mi)
		mi=mi-1
	end
	local chku=true
	local chkl=true
	local dbd={}
	mi=maxdc-1
	for i=1,maxdc do
		local maxval=9
		local minval=0
		if chku and i>1 and dbd[i-1]<dbdmax[i-1] then
			chku=false
		end
		if chkl and i>1 and dbd[i-1]>dbdmin[i-1] then
			chkl=false
		end
		if chku then
			maxval=dbdmax[i]
		end
		if chkl then
			minval=dbdmin[i]
		end
		local r={}
		local j=1
		for k=minval,maxval do
			r[j]=k
			j=j+1
		end
		dbd[i]=Duel.AnnounceNumber(tp,table.unpack(r))
		mi=mi-1
	end
	local number=0
	mi=maxdc-1
	for i=1,maxdc do
		number=number+dbd[i]*10^mi
		mi=mi-1
	end
	return number
end
function c511600002.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c511600002.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	--check if number of card >20 if speed duel or >40 if other duel
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,0xff,0xff,1,nil,511004001)
		and Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND+LOCATION_DECK,0,c)<20 then
		return Duel.Win(1-tp,0x60)
	elseif Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND+LOCATION_DECK,0,c)<40 
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,0xff,0xff,1,nil,511004001) then
		return Duel.Win(1-tp,0x60)
	end
	if Duel.GetFlagEffect(tp,511600002)==0 and Duel.GetFlagEffect(1-tp,511600002)==0 then
		if c:IsLocation(LOCATION_HAND) then
			Duel.ConfirmCards(1-tp,c)
		else
			Duel.ConfirmCards(tp,c)
			Duel.ConfirmCards(1-tp,c)
		end
		Duel.RegisterFlagEffect(tp,511600002,0,0,0)
	--zero
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCondition(c511600002.zerocon)
		e1:SetOperation(c511600002.zerop)
		Duel.RegisterEffect(e1,tp)
	--limit summon
		local e2=e1:Clone()
		e2:SetCondition(c511600002.limitcon)
		e2:SetOperation(c511600002.limitop)
		Duel.RegisterEffect(e2,tp)
	--Damage
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_DESTROYED)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE
			+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetTarget(c511600002.damcon)
		e3:SetOperation(c511600002.damop)
		Duel.RegisterEffect(e3,tp)
	--no battle damage
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE
			+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e4:SetTargetRange(1,1)
		e4:SetCondition(c511600002.bcon)
		Duel.RegisterEffect(e4,tp)
	--Dimension Summon
		local e5=Effect.CreateEffect(c)
		e5:SetDescription(aux.Stringid(4010,0))
		e5:SetType(EFFECT_TYPE_FIELD)
		e5:SetCode(EFFECT_SUMMON_PROC)
		e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
		e5:SetTarget(function(e,c)return c:GetFlagEffect(51160002)==0 end)
		e5:SetCondition(c511600002.ntcon)
		e5:SetValue(6)
		Duel.RegisterEffect(e5,tp)
		local e6=e5:Clone()
		e6:SetTarget(function(e,c)return c:GetFlagEffect(51160002)>0 end)
		e6:SetCode(EFFECT_LIMIT_SUMMON_PROC)
		e6:SetValue(6)
		Duel.RegisterEffect(e6,tp)
	--spirit
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e7:SetCode(EVENT_SUMMON_SUCCESS)
		e7:SetTarget(c511600002.spttg)
		e7:SetOperation(c511600002.sptop)
		e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		Duel.RegisterEffect(e7,tp)
		local e8=e7:Clone()
		e8:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
		Duel.RegisterEffect(e8,tp)
		local e9=e7:Clone()
		e9:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(e9,tp)
	end
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	if c:GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c511600002.limitfilter(c)
	return c:IsHasEffect(EFFECT_LIMIT_SUMMON_PROC) and c:GetFlagEffect(51160002)<=0
end
function c511600002.limitcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511600002.limitfilter,tp,0xff,0xff,1,nil)
end
function c511600002.limitop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511600002.limitfilter,tp,0xff,0xff,nil)
	if g:GetCount()>0 then
		for tc in aux.Next(g) do
			tc:RegisterFlagEffect(51160002,0,0,0)
		end
	end
end
function c511600002.zerofilter(c)
	return c:IsType(TYPE_MONSTER) and c:GetFlagEffect(511600002)<=0
end
function c511600002.zerocon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511600002.zerofilter,tp,0xff,0xff,1,nil)
end
function c511600002.zerop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511600002.zerofilter,tp,0xff,0xff,nil,TYPE_MONSTER)
	if g:GetCount()>0 then
		for tc in aux.Next(g) do
		--zero
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SUMMON_COST)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetOperation(c511600002.lvop)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SPSUMMON_COST)
			tc:RegisterEffect(e2)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_FLIPSUMMON_COST)
			tc:RegisterEffect(e3)
			tc:RegisterFlagEffect(511600002,0,0,0)
		end
	end
end
function c511600002.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+0xec0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	c:RegisterEffect(e2)
end
------------------------------------------------------------------------
--tribute
function c511600002.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
------------------------------------------------------------------------
function c511600002.sptfilter(c)
	return c:IsType(TYPE_MONSTER+TYPE_TRAPMONSTER+TYPE_TOKEN) and c:IsOnField()
end
function c511600002.spttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511600002.sptfilter,1,nil) end
end
function c511600002.sptop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511600002.sptfilter,nil)
	local c=e:GetHandler()
	local catk=0
	local cdef=0
	local tc=g:GetFirst()
	while tc do
		tableatk={}
		tabledef={}
		textatk=tc:GetTextAttack()
		textdef=tc:GetTextDefense()
		ctl=tc:GetControler()
		if textatk~=-2 and textatk~=0 then
			Duel.Hint(HINT_SELECTMSG,ctl,aux.Stringid(4010,4))
			local atkop=Duel.SelectOption(ctl,aux.Stringid(4010,1),aux.Stringid(4010,2),aux.Stringid(4010,3))
			if atkop==0 then
				catk=textatk
			elseif atkop==1 then
				catk=0
			else
				catk=aux.ComposeNumberDigitByDigit(ctl,0,textatk)
			end
			local e1=Effect.CreateEffect(c)
			e1:SetCategory(CATEGORY_ATKCHANGE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(catk)
			e1:SetReset(RESET_EVENT+0xec0000)
			tc:RegisterEffect(e1)
		end
		if textdef~=-2 and textdef~=0 then
			Duel.Hint(HINT_SELECTMSG,ctl,aux.Stringid(4010,5))
			local defop=Duel.SelectOption(ctl,aux.Stringid(4010,1),aux.Stringid(4010,2),aux.Stringid(4010,3))
			if defop==0 then
				cdef=textdef
			elseif defop==1 then
				cdef=0
			else
				cdef=aux.ComposeNumberDigitByDigit(ctl,0,textdef)
			end
			local e2=Effect.CreateEffect(c)
			e2:SetCategory(CATEGORY_DEFCHANGE)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_BASE_DEFENSE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetValue(cdef)
			e2:SetReset(RESET_EVENT+0xec0000)
			tc:RegisterEffect(e2)
		end
		tc=g:GetNext()
	end
end
------------------------------------------------------------------------
--inflict battle damage
function c511600002.damfilter(c)
	return c:IsType(TYPE_MONSTER+TYPE_TRAPMONSTER+TYPE_TOKEN) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511600002.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511600002.damfilter,1,nil)
end
function c511600002.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511600002.damfilter,nil)
	local dam1=0
	local dam2=0
	if g:GetCount()<1 then return end
	local tc=g:GetFirst()
	while tc do 
		local def=tc:GetPreviousDefenseOnField()
		local atk=tc:GetPreviousAttackOnField()
		local ctl=tc:GetControler()
		if tc:IsPreviousPosition(POS_ATTACK) then
			Duel.Damage(ctl,atk,REASON_RULE,true)
		elseif tc:IsPreviousPosition(POS_DEFENSE) then
			Duel.Damage(ctl,def,REASON_RULE,true)
		end
		tc=g:GetNext()
	end
	Duel.RDComplete()
end
------------------------------------------------------------------------
--no battle damage
function c511600002.bcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end