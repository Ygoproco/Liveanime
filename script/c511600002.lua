--Dimension Duel
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
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c511600002.ctcon)
	c:RegisterEffect(e3)
--not leaving
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_REMOVED)
	eb:SetTargetRange(LOCATION_REMOVED,LOCATION_REMOVED)
	eb:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	eb:SetTarget(c511600002.tgn)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	if not c511600002.global_check then
		c511600002.global_check=true
	--tribute
		local ge1=Effect.CreateEffect(c)
		ge1:SetDescription(aux.Stringid(25247218,0))
		ge1:SetCategory(CATEGORY_SUMMON)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_SUMMON_PROC)
		ge1:SetRange(LOCATION_REMOVED)
		ge1:SetTargetRange(0xff,0xff)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		ge1:SetTarget(function(e,c)return not c:IsHasEffect(EFFECT_LIMIT_SUMMON_PROC) end)
		ge1:SetCondition(c511600002.ntcon)
		Duel.RegisterEffect(ge1,tp)
		local ge2=ge1:Clone()
		ge2:SetTarget(function(e,c) return c:IsHasEffect(EFFECT_LIMIT_SUMMON_PROC) end)
		ge2:SetCode(EFFECT_LIMIT_SUMMON_PROC)
		Duel.RegisterEffect(ge2,tp)
	--no battle damage
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD)
		ge3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		ge3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge3:SetRange(LOCATION_REMOVED)
		ge3:SetTargetRange(1,1)
		ge3:SetCondition(c511600002.bcon)
		Duel.RegisterEffect(ge3,tp)
	--Damage
		local ge4=Effect.CreateEffect(c)
		ge4:SetCategory(CATEGORY_DAMAGE)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_DESTROYED)
		ge4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge4:SetRange(LOCATION_REMOVED)
		ge4:SetTarget(c511600002.damcon)
		ge4:SetOperation(c511600002.damop)
		Duel.RegisterEffect(ge4,tp)
	end
end
function c511600002.efcon(e)
	return e:GetLabel()~=0
end
--tribute
function c511600002.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
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
--no battle damage
function c511600002.bcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
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
	--remove
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,511600002) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		if Duel.Remove(c,POS_FACEUP,REASON_RULE)~=0 then
			local mg=Duel.GetMatchingGroup(Card.IsType,tp,0xff,0xff,nil,TYPE_MONSTER)
			local tc=mg:GetFirst()
			while tc do
			--zero
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SUMMON_COST)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
				e1:SetOperation(c511600002.lvop)
				tc:RegisterEffect(e1,true)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_SPSUMMON_COST)
				tc:RegisterEffect(e2,true)
				local e3=e1:Clone()
				e3:SetCode(EFFECT_FLIPSUMMON_COST)
				tc:RegisterEffect(e3,true)
				tc=mg:GetNext()
			end
		end
	end
		-- add ability Yell when Vanilla mode activated
		-- if Duel.IsExistingMatchingCard(c511600002.Vfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
			-- c511600002.tableAction.push(95000200)
		-- end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c511600002.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local catk=0
	local cdef=0
	tableatk={}
	tabledef={}
	oatk=c:GetTextAttack()
	odef=c:GetTextDefense()
	cctl=c:GetControler()
	local m=(oatk/50)
	local n=(odef/50)
	for i=0,m do
		local x = i*50
		table.insert(tableatk,x)
	end
	for i=0,n do
		local y = i*50
		table.insert(tabledef,y)
	end
	Duel.Hint(HINT_SELECTMSG,cctl,aux.Stringid(53714009,0))
	local catk=Duel.AnnounceNumber(cctl,table.unpack(tableatk))
	Duel.Hint(HINT_SELECTMSG,cctl,aux.Stringid(57043117,0))
	local cdef=Duel.AnnounceNumber(cctl,table.unpack(tabledef))
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(catk)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(cdef)
	c:RegisterEffect(e2,true)
end
----------------------------------
function c511600002.ctcon(e,re)
	return re:GetHandler()~=e:GetHandler()
end
----------------------------------
function c511600002.tgn(e,c)
	return c==e:GetHandler()
end