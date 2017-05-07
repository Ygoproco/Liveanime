--No. 13: Cain's Doom
function c511015132.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1)
	e1:SetCondition(c511015132.con)
	e1:SetOperation(c511015132.op)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511015132.desreptg)
	e2:SetOperation(c511015132.desrepop)
	c:RegisterEffect(e2)
	
	if not c511015132.global_check then
		c511015132.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PREDRAW)
		ge1:SetCountLimit(1)
		ge1:SetOperation(c511015132.readLP)
		Duel.RegisterEffect(ge1,0)
	end
end
c511015132.xyz_number=13
c511015132.LP=-1
function c511015132.readLP(e,tp,eg,ev,ep,re,r,rp)
	c511015132.LP=Duel.GetLP(tp)
	Debug.Message(c511015132.LP)
	e:Reset()
end

function c511015132.filter(c)
	return c:IsFaceup() and c:IsCode(95442074)
end

function c511015132.con(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>0 and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,95442074) and 
		Duel.GetLP(tp)<=c511015132.LP/2 and Duel.GetLP(1-tp)<=c511015132.LP/2
end
function c511015132.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.SetLP(tp,1000)
	end
end

function c511015132.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup() end
	return Duel.IsExistingMatchingCard(c511015132.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c511015132.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,e:GetHandler():GetAttack(),REASON_EFFECT)
end