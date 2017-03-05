--Gorgon's Eye (Anime)
--scripted by GameMaster (GM)
function c511002444.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002444.target)
	e1:SetOperation(c511002444.activate)
	c:RegisterEffect(e1)
	--cannot change pos and negate/cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511002444.tg2)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(0,1)
	c:RegisterEffect(e4)
	--damage LP
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EVENT_BATTLE_DESTROYED)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511002444.condition)
	e5:SetTarget(c511002444.target1)
	e5:SetOperation(c511002444.activate1)
	c:RegisterEffect(e5)
	--pos
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(335599118,0))
	e6:SetCategory(CATEGORY_POSITION)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_MSET)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTarget(c511002444.tg6)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c511002444.condition2)
	e6:SetOperation(c511002444.operation2)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetCode(EVENT_CHANGE_POS)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCondition(c511002444.con555)
	e7:SetOperation(c511002444.op555)
	c:RegisterEffect(e7)
end



function c511002444.deffilter(c)
	return c:IsPreviousPosition(POS_FACEUP_ATTACK) and c:IsPosition(POS_FACEUP_DEFENSE)
end
function c511002444.con555(e,tp,eg,ep,ev,re,r,rp)
if	Duel.IsExistingMatchingCard(c511002444.deffilter,1-tp,LOCATION_MZONE,0,1,nil) then return true
else return false
end
end
 
 

function c511002444.op555(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		local c=e:GetHandler()
		while tc do
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
        tc=tg:GetNext()
	end
end
end


function c511002444.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDefensePos,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511002444.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
local tg=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		local c=e:GetHandler()
		while tc do
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
        tc=tg:GetNext()
	end
end
end
end

function c511002444.cfilter(c)
	return c:IsFacedown() and c:IsDefensePos()
end
function c511002444.tg6(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511002444.cfilter,1,nil) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,eg:GetCount(),0,0)
end
function c511002444.filter(c,e)
	return c:IsFacedown() and c:IsRelateToEffect(e)
end
function c511002444.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c511002444.filter,nil,e)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
local tg=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		local c=e:GetHandler()
		while tc do
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
        tc=tg:GetNext()
	end
end
end

function c511002444.tg2(e,c)
	return c:IsDefensePos()
end
function c511002444.condition2(e,tp,eg,ep,ev,re,r,rp)
return tp~=eg:GetFirst():GetControler()
end

function c511002444.condition(e,tp,eg,ep,ev,re,r,rp)
	local bc=eg:GetFirst()
	return bc:GetPreviousControler()==1-tp and bc:GetPreviousPosition()==POS_FACEUP_DEFENSE
end
function c511002444.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local def=eg:GetFirst():GetDefense()/2
	if def<0 then def=0 end
	Duel.SetTargetParam(def)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,def)
end
function c511002444.activate1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end