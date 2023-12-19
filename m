Return-Path: <linux-kernel+bounces-5453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB410818AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA61F25529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CCF1C69D;
	Tue, 19 Dec 2023 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAW6DuX4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096331C694;
	Tue, 19 Dec 2023 15:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EEAC433C7;
	Tue, 19 Dec 2023 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702998530;
	bh=kgy9sZBro//FLGYH8KGkNLmotXB9hwJPcByau9Ewpck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAW6DuX48a64d/n2lNIyIXFbFdutTcY8Gdd7NNktzq072mh30nxn02b1SDsSMnJOO
	 UmocrDVkHvzjXcIxitWEpa676I6i65lYx76Ux78VBp72KwIKMpP/UfKj6HkHRL7E3H
	 S5M9k4YRyM4wQXS+d3i2pjG+7wuNAxK9jGRJshZt+aLYAAle/V7xcvnS8Vob+nCNua
	 w+Fg+Q3u7I7cbUsg08xs3ex9a5TZBNn3zWvLRe3GQNDmNZz0dskMjSfhzcnTUvkNVx
	 8cyHpPtFqVfoDsx/NMnY+dbhl658hcPsmtWAmK6A85NXLnr/MgPVQIllbsmwFKWdJK
	 pf2BWnZjhXfhw==
Date: Tue, 19 Dec 2023 15:08:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mailbox: starfive: Add StarFive Meu
 Mailbox Driver
Message-ID: <20231219-dispute-voicing-0e1c93640954@spud>
References: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
 <20231218061201.98136-3-joshua.yeong@starfivetech.com>
 <20231218-pawing-unripe-e45ad62ff8c7@spud>
 <60d091af-95d0-6f26-d535-4c3d8f38b5c1@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aBlE0UIWogrl2WXb"
Content-Disposition: inline
In-Reply-To: <60d091af-95d0-6f26-d535-4c3d8f38b5c1@starfivetech.com>


--aBlE0UIWogrl2WXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 01:52:53PM +0800, Joshua Yeong wrote:
> On 18/12/2023 7:17 PM, Conor Dooley wrote:
> > On Mon, Dec 18, 2023 at 02:12:00PM +0800, Joshua Yeong wrote:
> > > The StarFive Meu Mailbox allow communication between AP and SCP cores
> > > through mailbox doorbell.
> > >=20
> > > Co-developed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > ---
> > >   .../bindings/mailbox/starfive-meu.yaml        | 66 ++++++++++++++++=
+++
> > >   1 file changed, 66 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/mailbox/starfi=
ve-meu.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mailbox/starfive-meu.y=
aml b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
> > > new file mode 100644
> > > index 000000000000..dbc5cfdb90ff
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mailbox/starfive-meu.yaml#

Filename should match the compatible.

> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: StarFive MEU Mailbox Controller
> > > +
> > > +maintainers:
> > > +  - Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > > +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> > > +
> > > +description: |

This | is not needed, there's no formatting here to preserve.

> > > +  StarFive's Message-Exchange-Unit (MEU) is a mailbox controller tha=
t has 62
> > > +  independent doorbells. Each MEU channel consist of 31 doorbells an=
d consist of
> > > +  a pair of Tx/Rx links that shall communicates with remote processo=
r. The
> > > +  sender set the bit in the SET register to indicate data readiness =
for the
> > > +  receiver. An interrupt will be raised whenever receiving notificat=
ion doorbell
> > > +  from remote processor. The receiver will clear the bit in the CLR =
register
> > > +  upon handling the doorbell notification. The sender should poll th=
e STAT
> > > +  register before starting any transaction to ensure all on-going do=
orbells are
> > > +  processed.
> > What is/are the consumer(s) of this mailbox?
> > Is part of your RPMI implementation?
> >=20
> > Cheers,
> > Conor.
>=20
> Yes, it would be part of StarFive RPMI implementation.

I see. Seems a bit weird to submit the mailbox provider without a
consumer, since it'll be dead code until a provider arrives, but that's
for the mailbox driver maintainer to decide if he has a problem with.

>=20
> Regards,
> Joshua
>=20
> >=20
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - starfive,jh8100-meu

I would just make this const: starfive,jh8100-meu unless you already
expect your other SoCs to use a different programming model.

> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: mailbox0
> > > +      - description: mailbox1
> > > +
> > > +  '#mbox-cells':
> > > +    description: represents index of the mailbox/doorbell paired cha=
nnel

> > > +      channel  0 - 30 for mailbox0 doorbell
> > > +      channel 31 - 61 for mailbox1 doorbell

I'd probably move this channel to doorbell interrupt mapping into the
main description and leave this as just

'#mbox-cells':
  const: 1

> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - '#mbox-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    soc {
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +
> > > +        meu: mailbox@1f370000 {

Drop the label here, it has no user.

> > > +            compatible =3D "starfive,jh8100-meu";
> > > +            reg =3D <0x0 0x1f370000 0 0x8000>;
> > > +            interrupts =3D <170>, /* Mailbox0 */
> > > +                         <171>; /* Mailbox1 */

I'd also probably drop the comments here, since the binding enforces
this ordering.

Cheers,
Conor.

> > > +            #mbox-cells =3D <1>;
> > > +        };
> > > +    };
> > > +
> > > +...
> > > --=20
> > > 2.25.1
> > >=20

--aBlE0UIWogrl2WXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYGx/QAKCRB4tDGHoIJi
0vlKAQCjD4w6/DZKidDRl0fUjMIzi/elCXT4grZ4VQpnGQKvQAD+MDdCJhakiSxg
c1Pi6auSGQqDh4XyM8IHMbwp24hjCgA=
=61gP
-----END PGP SIGNATURE-----

--aBlE0UIWogrl2WXb--

