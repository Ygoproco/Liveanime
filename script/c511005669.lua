--Milus Radiant(DOR)
--scripted by GameMaster(GM)
function c511005669.initial_effect(c)
	 local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_BE_BATTLE_TARGET)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c511005669.con)
    e1:SetOperation(c511005669.op)
    e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
    c:RegisterEffect(e1)
	--destroy zombie typed monster when FLIPPED
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511005669,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e2:SetTarget(c511005669.destg)
	e2:SetOperation(c511005669.desop)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c511005669.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsRace(RACE_ZOMBIE) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c511005669.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
	
function c511005669.con(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPosition(POS_FACEDOWN)
end

function c511005669.op(e,tp,eg,ep,ev,re,r,rp)
    local te=e:GetLabelObject()
    local tetype=te:GetType()
    local tecode=te:GetCode()
    te:SetType(EFFECT_TYPE_ACTIVATE)
    te:SetCode(EVENT_FREE_CHAIN)
    local act=false
    if te:IsActivatable(tp) then act=true end
    te:SetType(tetype)
    te:SetCode(tecode)
    if not act then return end
    Duel.ChangePosition(e:GetHandler(),POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
end
