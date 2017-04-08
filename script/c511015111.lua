--Constellar Tempest (Anime)
function c511015111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511015111.condition)
	c:RegisterEffect(e1)
	--lp
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511015111,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c511015111.lpop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511015111.descon)
	e3:SetOperation(c511015111.desop)
	c:RegisterEffect(e3)
end
function c511015111.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x53) and c:IsType(TYPE_XYZ)
end
function c511015111.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c511015111.filter,tp,LOCATION_MZONE,0,2,nil)
end
function c511015111.lpop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end

function c511015111.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSetCard,1,nil,0x53)
end
function c511015111.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
