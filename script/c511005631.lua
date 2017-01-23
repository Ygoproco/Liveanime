--Attribute Bomb
--modified by GameMaster (GM)
function c511005631.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511005631.target)
	e1:SetOperation(c511005631.operation)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511005631.destg)
	e2:SetOperation(c511005631.desop)
	e2:SetCondition(c511005631.condition)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end

function c511005631.condition(e)
	local tc=e:GetHandler():GetEquipTarget()
return Duel.GetAttacker()==tc or Duel.GetAttackTarget()==tc
end	

function c511005631.target(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)	
	Duel.Hint(HINT_SELECTMSG,tp,562)
	local rc=Duel.AnnounceAttribute(tp,1,0xffff)
	e:GetLabelObject():SetLabel(rc)
	e:GetHandler():SetHint(CHINT_ATTRIBUTE,rc)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511005631.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end

function c511005631.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local q=e:GetLabel()
	local c=e:GetHandler():GetEquipTarget()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc  and tc:IsAttribute(q) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,tp,1,0,0)
end
function c511005631.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetEquipTarget()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() then Duel.Damage(1-tp,1000,REASON_EFFECT) end
end
