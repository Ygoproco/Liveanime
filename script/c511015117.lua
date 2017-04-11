--Armoroid (Manga)
function c511015117.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x16),3,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511015117.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511015117.spcon)
	e2:SetOperation(c511015117.spop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c511015117.damcon)
	e3:SetTarget(c511015117.damtg)
	e3:SetOperation(c511015117.damop)
	c:RegisterEffect(e3)
end
function c511015117.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA+LOCATION_GRAVE)
end
function c511015117.spcon(e,c)
	local tp = e:GetHandler():GetControler()
	return Duel.GetLocationCount(tp,LOCATION_SZONE)>2
		and Duel.IsExistingMatchingCard(Card.IsFusionSetCard,tp,LOCATION_MZONE,0,3,nil,0x16)
end
function c511015117.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectMatchingCard(tp,Card.IsFusionSetCard,tp,LOCATION_MZONE,0,3,3,nil,0x16)
	local tc = g:GetFirst()
	while tc do
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		tc=g:GetNext()
	end
	e:GetHandler():SetMaterial(g)
	
	--equip
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetOperation(c511015117.operation)
	e:GetHandler():RegisterEffect(e2)
end

function c511015117.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511015117.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetMaterial()
	local tc = g:GetFirst()
	while tc do
		Duel.Equip(tp,tc,e:GetHandler(),false)
		
		--Add Equip limit
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511015117.eqlimit)
		tc:RegisterEffect(e1)
	
		--lower atk
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCategory(CATEGORY_ATKCHANGE)
		e2:SetCode(EVENT_DESTROYED)
		e2:SetOperation(c511015117.atkop)
		e2:SetLabelObject(e:GetHandler())
		tc:RegisterEffect(e2)
	
		tc=g:GetNext()
	end
	
	--destroy
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511015117.descon)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e3)
	
	e:Reset()
end
function c511015117.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-600)
		tc:RegisterEffect(e1)
	end
end
function c511015117.descon(e,c)
	return e:GetHandler():GetEquipGroup():FilterCount(Card.IsSetCard,nil,0x16)==0
end


function c511015117.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsType(TYPE_MONSTER) and bit.band(bc:GetBattlePosition(),POS_DEFENSE)~=0
end
function c511015117.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetHandler():GetAttack()/2
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511015117.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end