Return-Path: <linux-kernel+bounces-23935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC04F82B424
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F74D1F23ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7853813;
	Thu, 11 Jan 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/0K89YN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB110A20;
	Thu, 11 Jan 2024 17:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1373BC433F1;
	Thu, 11 Jan 2024 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704994276;
	bh=z3f/odDTmvi8sV0yAYFsEU4ayXJE1gJP66VKYOAb/+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/0K89YNryWipcKZQDcwm9mKjge8TqgqpVv+2H6jUVz0wQRfOYFQWeCfVVpuE8yUF
	 20I3mPDisNUeI7MfwGczoWH7GLwfkdJtfi3y06pY8N1h3SHdLIm+Dbp+ndfUEHymjB
	 ovC+S4CC6RCr99fH8EN1PIufe4wzNWYV0Cyts0d8oTQuo5hr6ilDd8dtEMnqcdXnQV
	 asgYIR3RAy2JRuC7bLILDzeduqSaol+0G7Nx8pD8li6RP7r8CNCN/+BnvkDPEyfPiL
	 wU7G6kH6pbkd3P13CYy30aZfvzVUyCC84/sWB9iYjoqAKAktWmBkmTQN8jVwybuRQK
	 p29hu3lf6/kvg==
Date: Thu, 11 Jan 2024 17:31:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Johnson Wang =?utf-8?B?KOeOi+iBlumRqyk=?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jason-ch Chen =?utf-8?B?KOmZs+W7uuixqik=?= <Jason-ch.Chen@mediatek.com>,
	Shawn Sung =?utf-8?B?KOWui+WtneismSk=?= <Shawn.Sung@mediatek.com>,
	Nancy Lin =?utf-8?B?KOael+aso+ieoik=?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Message-ID: <20240111-anthology-dock-c60d28ac7f1c@spud>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
 <20240110-grumbling-tattling-0202fc5e21f2@spud>
 <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QW5q1ZGC+crOHGMg"
Content-Disposition: inline
In-Reply-To: <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>


--QW5q1ZGC+crOHGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 04:36:20PM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> Hi Conor,
>=20
> Thanks for the reviews.
>=20
> On Wed, 2024-01-10 at 10:36 +0000, Conor Dooley wrote:
> > On Wed, Jan 10, 2024 at 02:35:30PM +0800, Jason-JH.Lin wrote:
> > > 1. Add "Provider" to the title to make it clearer.
> > > 2. Add reference to gce-props.yaml for adding mediatek,gce-events
> > > property.
> >=20
> > I can see this from the diff. There's still no explanation here as to
> > why the mailbox provider needs to have a gce-event id. NAK until you
> > can
> > explain that.
> >=20
> Sorry for missing the reason in commit message, I'll add it in the next
> version.
>=20
> There are 2 reasons why the mailbox provider needs gce-events:
> 1. The mailbox provider here is CMDQ mailbox driver. It configures GCE
> hardware register by CPU directly. If we want to set the default value
> from 0 to 1 for specific gce-events during the initialization of CMDQ
> driver. We need to tell CMDQ driver what gce-events need to be set and
> I think such GCE hardware setting can get from its device node.

Why would someone want to set it to 1 or 0?
At what level will that vary? Per SoC? Per board? Something else?

> 2. We'll have the secure CMDQ mailbox driver in the future patch [1].
> It will request or reserve a mailbox channel, which is a dedicate GCE
> thread, as a secure IRQ handler. This GCE thread executes a looping
> instruction set that keeps waiting for the gce-event set from another
> GCE thread in the secure world. So we also need to tell the CMDQ driver
> what gce-event need to be waited.

Ditto here, what level does this vary at? Do different SoCs or different
boards/platforms dictate the value?
Could this channel be determined from the soc-specific compatible?

In other words, please explain in your commit message why this requires
a property and is not detectable from any existing mechanism. From
reading this I don't know what is preventing the secure mailbox channel
=66rom picking a "random" unused channel.

Thanks,
Conor.

> [1] cmdq_sec_irq_notify_start() is where the GCE thread is requested to
> prepare a looping instruction set to wait for the gce-event.
> -=20
> https://patchwork.kernel.org/project/linux-mediatek/patch/20231222045228.=
27826-9-jason-jh.lin@mediatek.com/
>=20
> Regards,
> Jason-JH.Lin
>=20
> > Cheers,
> > Conor.
> >=20
> > >=20
> > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml   | 6
> > > ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > index cef9d7601398..728dc93117a6 100644
> > > --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > @@ -4,7 +4,7 @@
> > >  $id:=20
> > > http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
> > >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > =20
> > > -title: Mediatek Global Command Engine Mailbox
> > > +title: MediaTek Global Command Engine Mailbox Provider
> > > =20
> > >  maintainers:
> > >    - Houlong Wei <houlong.wei@mediatek.com>
> > > @@ -57,6 +57,8 @@ required:
> > >    - clocks
> > > =20
> > >  allOf:
> > > +  - $ref: mediatek,gce-props.yaml
> > > +
> > >    - if:
> > >        not:
> > >          properties:
> > > @@ -67,7 +69,7 @@ allOf:
> > >        required:
> > >          - clock-names
> > > =20
> > > -additionalProperties: false
> > > +unevaluatedProperties: false
> > > =20
> > >  examples:
> > >    - |
> > > --=20
> > > 2.18.0
> > >=20

--QW5q1ZGC+crOHGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaAl3gAKCRB4tDGHoIJi
0t/LAQCI0RfsupQbS0ZgyeRCcDU8ETflHOhbgCzGZesvWIxDzwEAmfV2pBcTpwM2
4/y9NkmnC5ZZaHe6S2NooLECB1DA9AA=
=Z03v
-----END PGP SIGNATURE-----

--QW5q1ZGC+crOHGMg--

