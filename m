Return-Path: <linux-kernel+bounces-5596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B3818CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4657B252BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B412D603;
	Tue, 19 Dec 2023 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgWzghve"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCF31755;
	Tue, 19 Dec 2023 16:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C99C433C7;
	Tue, 19 Dec 2023 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004447;
	bh=we6gDnHjzWtXB38iDs3+0ZZ94OTyknFvETc+KMtcjk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgWzghveC/CRQRZaO2+TeTtzgcafaW+zJzJSBPLv9vhdHye219lc7binmqGDJnp2P
	 nL9VqeU+kwG7R2BU4EqO1AbijJHFynaPyygbgB9DoTEK8wXIsb1sQuudIPcmA5LB1x
	 PX/I1q8xjG2tPy/fgvLhOuvyQ/2oyjZ4ciCOoynAGDqw6j2IhN6PMqx7taXYb4emT6
	 08MDiqgdivBxPFwfwxMPMvtF+vHPirbLV9l60gqmxQDWM7PPP+sykht8oHU+1Xcyoj
	 1oUEAf9dnvIyKWLpzNSQIPgwYHldEq/1evQ2s7dIIlCGHdANit3vtTL3ZwEOl6vZqA
	 YvJXVaOf3jxgw==
Date: Tue, 19 Dec 2023 16:47:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Matyas, Daniel" <Daniel.Matyas@analog.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as compatible
 string
Message-ID: <20231219-scraggly-gravel-d677a6eba3cc@spud>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <20231214143648.175336-2-daniel.matyas@analog.com>
 <43c3f6cb-aeb2-40c8-a79d-c2222414b49c@linaro.org>
 <a5bc25d5-f59c-43ce-a44a-3eabc4b2d06c@roeck-us.net>
 <SJ0PR03MB67643A8DD1F7AD8CEF66BBBE8990A@SJ0PR03MB6764.namprd03.prod.outlook.com>
 <86e0e357-5b31-4984-a66f-d27128178470@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDv1AnXBRXc1GwHh"
Content-Disposition: inline
In-Reply-To: <86e0e357-5b31-4984-a66f-d27128178470@roeck-us.net>


--oDv1AnXBRXc1GwHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 09:22:19AM -0800, Guenter Roeck wrote:
> On 12/18/23 01:08, Matyas, Daniel wrote:
> >=20
> >=20
> > > -----Original Message-----
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > Sent: Friday, December 15, 2023 6:03 PM
> > > To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Matyas, Dan=
iel
> > > <Daniel.Matyas@analog.com>
> > > Cc: Jean Delvare <jdelvare@suse.com>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
> > > hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-doc@vger.kernel.org
> > > Subject: Re: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as
> > > compatible string
> > >=20
> > > [External]
> > >=20
> > > On 12/15/23 00:49, Krzysztof Kozlowski wrote:
> > > > On 14/12/2023 15:36, Daniel Matyas wrote:
> > > > > In the device ada4224 the max31827 temperature sensor will be use=
d,
> > > > > so the default values corresponding to adaq4224_temp are the same
> > > for
> > > > > max31827.
> > > > >=20
> > > > > Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> > > >=20
> > > > Please use subject prefixes matching the subsystem. You can get them
> > > > for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
> > > > directory your patch is touching.
> > > >=20
> > > > > ---
> > > > >    Documentation/devicetree/bindings/hwmon/adi,max31827.yaml | 5
> > > ++++-
> > > > >    1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > > > > b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > > > > index f60e06ab7d0a..9f3b0839aa46 100644
> > > > > --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > > > > +++
> > > b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > > > > @@ -20,6 +20,7 @@ properties:
> > > > >          - const: adi,max31827
> > > > >          - items:
> > > > >              - enum:
> > > > > +              - adi,adaq4224_temp
> > > >=20
> > > > Underscores are not allowed
> > > >=20
> > >=20
> > > That isn't the main problem with this patch.
> > > https://urldefense.com/v3/__https://github.com/analogdevicesinc/linux/
> > > tree/dev_adaq4224_dts__;!!A3Ni8CS0y2Y!_2D1w1DD5sjJrNyArZYZ3QW9
> > > nS8URmP6X0n6R7q1sBnDB1HPL6jROhD_w9u3fJixt2hDDNtO6VpgLM1Jka
> > > Q$
> > > suggests that it may be a development system which utilizes the
> > > max31827.
> > >   From there, we can see that there is a devicetree description of a =
board
> > > with that name which uses
> > >=20
> > >                   temperature1: temperature@5f {
> > >                           compatible =3D "adi,adaq4224_temp";
> > >                           reg =3D <0x5f>;
> > >                           vref-supply =3D <&vio>;
> > >=20
> > >                           adi,comp-int;
> > >                           adi,alarm-pol =3D <0>;
> > >                           adi,fault-q =3D <1>;
> > >                           adi,timeout-enable;
> > >                   };
> > >=20
> > > That doesn't make sense to me. I don't know why they don't just
> > > reference max31827.
> > > I am most definitely not going to accept a driver change just to map
> > > adi,adaq4224_temp (or adi,adaq4224-temp) to the actually used
> > > temperature sensor chip. If we start accepting that, we'd end up with=
 no
> > > end of "<vendor>,<board_name>-{temp,voltage,current,power,...}"
> > > compatibles.
> > >=20
> > > Looking more into the above mentioned repository/branch, an earlier
> > > version of the dts file did reference adi,max31827 for that chip. It =
also
> > > looks like there may be an adaq4224 ADC (per drivers/iio/adc/ad4630.c=
),
> > > but that would be a SPI chip. It seems highly unlikely that a SPI ADC=
 would
> > > have a separate I2C interface connected to a temperature sensor.
> > > Confusing.
> > >=20
> > > There is also some indication that this may some IP to be loaded into=
 an
> > > FPGA.
> > > which utilizes an FPGA implementation of max31827 (or maybe connects
> > > to one).
> > > If that is the case, it should still be referenced as max31827.
> > >=20
> > > All that wasted time because of "let's provide as little as possible
> > > information about what we are actually doing" :-(.
> > >=20
> > > Guenter
> >=20
> > I asked around to get some more clarification on the matter. There will=
 be a new chip released, named adaq4224. This chip will have the max31827 i=
mplemented in the silicon, so the driver used to get temperature informatio=
n would be max31827.c. The chip will have spi and i2c communication too. Th=
e other driver you mentioned, the ad4630.c will communicate through spi.
> >=20
> > Because the chip has a different name, I was asked to add a new label f=
or the max31827, so that it will be clear for the user, that the max31827 i=
s part of the chip.
> >=20
>=20
> It is still a max31827 core. If there is no difference in programming
> to max31827, it can possibly be reflected in devicetree as
> "adi,adaq4224-temp", in addition to "adi,max31827". This would not
> require a change in the driver code as "adi,max31827" would still
> be mandatory.

I am inclined to agree, but it is very hard to review these bindings
when only partial functionality of the hardware is submitted. Then
subtract any documentation of the device from the picture and clearly
reviewing becomes quite challenging.

--oDv1AnXBRXc1GwHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYHJGgAKCRB4tDGHoIJi
0r5ZAQD2OUq3Tet+pNyBthNr4GLGNP/UcqLAwUxJQEQkwFYTQgD+PmkagnoaRIHv
7KA7azTlh3z0MCTtg6pX4n35iw06SwU=
=y1Tm
-----END PGP SIGNATURE-----

--oDv1AnXBRXc1GwHh--

