--Dimension Duel
--scripted by Larry126
function c511600002.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetCondition(c511600002.con)
	e1:SetOperation(c511600002.op)
	c:RegisterEffect(e1)	 
--unaffectable
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_TO_DECK) 
	c:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e5)
--dimension summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(25247218,0))
	e6:SetCategory(CATEGORY_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_SUMMON_PROC)
	e6:SetRange(LOCATION_REMOVED)
	e6:SetTargetRange(0xff,0xff)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	--e6:SetTarget(function(e,c)return not c:IsHasEffect(EFFECT_LIMIT_SUMMON_PROC) end)
	e6:SetCondition(c511600002.ntcon)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	--e7:SetTarget(function(e,c) return c:IsHasEffect(EFFECT_LIMIT_SUMMON_PROC) end)
	e7:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	c:RegisterEffect(e7)
--no battle damage
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetRange(LOCATION_REMOVED)
	e8:SetTargetRange(1,1)
	e8:SetCondition(c511600002.bcon)
	c:RegisterEffect(e8)
--Damage
	local e9=Effect.CreateEffect(c)
	e9:SetCategory(CATEGORY_DAMAGE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_DESTROYED)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e9:SetRange(LOCATION_REMOVED)
	e9:SetTarget(c511600002.damcon)
	e9:SetOperation(c511600002.damop)
	c:RegisterEffect(e9)
--spirit
	local e10=Effect.CreateEffect(c)
	e10:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetRange(LOCATION_REMOVED)
	e10:SetCode(EVENT_SUMMON_SUCCESS)
	e10:SetTarget(c511600002.spttg)
	e10:SetOperation(c511600002.sptop)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e11)
	local e12=e10:Clone()
	e12:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e12)
end
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
		cctl=tc:GetControler()
		tableatk={}
		tabledef={}
		oatk=tc:GetTextAttack()
		odef=tc:GetTextDefense()
		if oatk~=-2 then
			local m=oatk/50
			for i=0,m do
				local x = i*50
				table.insert(tableatk,x)
			end
			Duel.Hint(HINT_SELECTMSG,cctl,aux.Stringid(53714009,0))
			local catk=Duel.AnnounceNumber(cctl,table.unpack(tableatk))
			local e1=Effect.CreateEffect(c)
			e1:SetCategory(CATEGORY_ATKCHANGE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(catk)
			e1:SetReset(RESET_EVENT+0xfe0000)
			tc:RegisterEffect(e1)
		end
		if odef~=-2 then
			local n=odef/50
			for i=0,n do
				local y = i*50
				table.insert(tabledef,y)
			end
			Duel.Hint(HINT_SELECTMSG,cctl,aux.Stringid(57043117,0))
			local cdef=Duel.AnnounceNumber(cctl,table.unpack(tabledef))
			local e2=Effect.CreateEffect(c)
			e2:SetCategory(CATEGORY_DEFCHANGE)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_BASE_DEFENSE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetValue(cdef)
			e2:SetReset(RESET_EVENT+0xfe0000)
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
			Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,1,ctl,atk)
			Duel.Damage(ctl,atk,REASON_RULE,true)
		elseif tc:IsPreviousPosition(POS_DEFENSE) then
			Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,1,ctl,def)
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
------------------------------------------------------------------------
--tribute
function c511600002.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
------------------------------------------------------------------------
--speed Duel Filter
function c511600002.SDfilter(c)
	return c:GetCode()==511004001
end
--vanilla mode filter
function c511600002.Vfilter(c)
	return c:GetCode()==511004400
end
function c511600002.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c511600002.op(e,tp,eg,ep,ev,re,r,rp,chk)
	--check if number of card >20 if speed duel or >40 if other duel
	if Duel.IsExistingMatchingCard(c511600002.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) and Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
	Duel.Win(1-tp,0x55)
	end
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,e:GetHandler()):GetCount()<40 and not Duel.IsExistingMatchingCard(c511600002.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
	Duel.Win(1-tp,0x55)
	end
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,511600002) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		if Duel.Remove(c,POS_FACEUP,REASON_RULE) then
			local mg=Duel.GetMatchingGroup(Card.IsType,tp,0xff,0xff,nil,TYPE_MONSTER)
			local tc=mg:GetFirst()
			while tc do
			--zero
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SUMMON_COST)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE)
				e1:SetOperation(c511600002.lvop)
				tc:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_SPSUMMON_COST)
				tc:RegisterEffect(e2)
				local e3=e1:Clone()
				e3:SetCode(EFFECT_FLIPSUMMON_COST)
				tc:RegisterEffect(e3)
				tc=mg:GetNext()
			end
		end
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND and Duel.IsPlayerCanDraw(e:GetHandlerPlayer(),1)then
		Duel.Draw(tp,1,REASON_RULE)
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
	e1:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	c:RegisterEffect(e2)
end
