--Sonic Cyclone
--fixed by MLD
function c511018018.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511018018.target)
	e1:SetOperation(c511018018.operation)
	c:RegisterEffect(e1)
	--count destroyed card
	if not c511018018.global_check then
		c511018018.global_check=true
		c511018018.dt=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c511018018.chkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511018018.clearop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511018018.chkop(e,tp,eg,ev,ep,re,r,rp)
	c511018018.dt=c511018018.dt+eg:FilterCount(Card.IsType,nil,TYPE_MONSTER)
end
function c511018018.clearop()
	c511018018.dt=0
end
function c511018018.target(e,tp,eg,ev,ep,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c511018018.dt
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,c,TYPE_SPELL+TYPE_TRAP) end
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c,TYPE_SPELL+TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,ct,0,0)
end
function c511018018.operation(e,tp,eg,ev,ep,re,r,rp)
	local ct=c511018018.dt
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler(),TYPE_SPELL+TYPE_TRAP)
	if g:GetCount()>=ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,ct,ct,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
