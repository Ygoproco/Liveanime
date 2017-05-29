--CNo.96 ブラック・ストーム (Anime)
--fixed by MLD
function c511010196.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),3,4)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511010196.rankupregcon)
	e1:SetOperation(c511010196.rankupregop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010196.indes)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabelObject(e2)
	e3:SetOperation(c511010196.damop)
	c:RegisterEffect(e3)
	if not c511010196.global_check then
		c511010196.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010196.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010196.xyz_number=96
function c511010196.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	local bc=c:GetBattleTarget()
	if not te then
		te=Effect.CreateEffect(c)
		te:SetType(EFFECT_TYPE_SINGLE)
		te:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		te:SetValue(c511010196.indes)
		c:RegisterEffect(te)
	end
	te:Reset()
	if not c:IsHasEffect(81674782) and bc and bc:IsSetCard(0x48) and not c:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
		local a=Duel.GetAttacker()
		local d=Duel.GetAttackTarget()
		local chk=false
		if d~=c then a,d=d,a end
		if a:IsPosition(POS_FACEUP_DEFENSE) then
			if not a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return end
			if a:IsHasEffect(75372290) then
				if d:IsAttackPos() then
					if a:GetDefense()==d:GetAttack() then
						chk=a:GetDefense()~=0
					else
						chk=a:GetDefense()>=d:GetAttack()
					end
				else
					chk=a:GetDefense()>d:GetDefense()
				end
			else
				if d:IsAttackPos() then
					if a:GetAttack()==d:GetAttack() then
						chk=a:GetAttack()~=0
					else
						chk=a:GetAttack()>=d:GetAttack()
					end
				else
					chk=a:GetAttack()>d:GetDefense()
				end
			end
		else
			if d:IsAttackPos() then
				if a:GetAttack()==d:GetAttack() then
					chk=a:GetAttack()~=0
				else
					chk=a:GetAttack()>=d:GetAttack()
				end
			else
				chk=a:GetAttack()>d:GetDefense()
			end
		end
		if chk then
			Duel.ChangeBattleDamage(1-ep,ev,false)
		end
	end
	te=Effect.CreateEffect(c)
	te:SetType(EFFECT_TYPE_SINGLE)
	te:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	te:SetValue(c511010196.indes)
	c:RegisterEffect(te)
	e:SetLabelObject(te)
end
function c511010196.rumfilter(c)
	return c:IsCode(55727845) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511010196.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511015134)~=0 then return true end
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581,111011002,511000580,511002068,511002164,93238626)) 
		and e:GetHandler():GetMaterial():IsExists(c511010196.rumfilter,1,nil)
end
function c511010196.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010196,0))
	e1:SetProperty(0,EFFECT_FLAG2_XMDETACH)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511010196.atkcost)
	e1:SetTarget(c511010196.atktg)
	e1:SetOperation(c511010196.atkop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511010196.negfilter1(c)
	return c:IsFaceup() and c:GetOriginalCode()==513000031 and not c:IsStatus(STATUS_DISABLED) 
end
function c511010196.negfilter2(c)
	return c:IsFaceup() and c:GetOriginalCode()==511001603 and not c:IsStatus(STATUS_DISABLED) 
end
function c511010196.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010196.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:GetAttack()>0 and c:GetFlagEffect(511010196)==0 end
	c:RegisterFlagEffect(511010196,RESET_PHASE+PHASE_DAMAGE,0,0)
	Duel.SetTargetCard(bc)
end
function c511010196.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>0 then
		local atk=tc:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end
function c511010196.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,77205367)
	Duel.CreateToken(1-tp,77205367)
end
function c511010196.indes(e,c)
	return not c:IsSetCard(0x48)
end
