--Enchanted Sword Nothung
function c511000416.initial_effect(c)
	aux.AddEquipProcedure(c,nil,nil,nil,nil,c511000416.tg,c511000416.op)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP+CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000416.target)
	e1:SetOperation(c511000416.operation)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(400)
	c:RegisterEffect(e2)
	--destroy all Dragons that battle
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000416,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCondition(c511000416.descon)
	e4:SetTarget(c511000416.destg)
	e4:SetOperation(c511000416.desop)
	c:RegisterEffect(e4)
end
function c511000416.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup() and c:IsAbleToRemove()
end
function c511000416.tg(e,tp,eg,ep,ev,re,r,rp,tc)
	e:SetCategory(CATEGORY_EQUIP+CATEGORY_DESTROY+CATEGORY_REMOVE)
	local sg=Duel.GetMatchingGroup(c511000416.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c511000416.op(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511000416.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT,LOCATION_REMOVED)
end
function c511000416.descon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	if ec~=Duel.GetAttacker() and ec~=Duel.GetAttackTarget() then return false end
	local tc=ec:GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsRace(RACE_DRAGON)
end
function c511000416.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetLabelObject(),1,0,0)
end
function c511000416.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetLabelObject()
	if tc:IsFaceup() and tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
