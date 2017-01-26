--Cicada Illusion
--scripted by: UnknownGuest
--fixed by MLD
function c810000084.initial_effect(c)
	aux.AddPersistentProcedure(c,0,c810000084.filter,nil,nil,nil,0x1c0)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c810000084.tg)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c810000084.descon)
	e2:SetOperation(c810000084.desop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetDescription(aux.Stringid(810000084,0))
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHANGE_POS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c810000084.con)
	e3:SetOperation(c810000084.op)
	c:RegisterEffect(e3)
end
function c810000084.filter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsRace(RACE_INSECT)
end
function c810000084.tg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c810000084.con(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetFirstCardTarget()
	return tg and eg:IsContains(tg)
end
function c810000084.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c:GetDefense())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c810000084.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c810000084.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
