Return-Path: <linux-kernel+bounces-2224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CB8159D8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04471F23BF8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B9E2E63A;
	Sat, 16 Dec 2023 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ6vKmeg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D92D7A6;
	Sat, 16 Dec 2023 14:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E476C433C8;
	Sat, 16 Dec 2023 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702736213;
	bh=t+y+M2JnxGrEOUAALEQCknie1oJTMkhmah2MAcB9pfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZ6vKmegJLHpPyCchb+m2KOseBHjiCzbJOcZFVCXoZbG4Ecwbr+ELIHorMLBSJ8+/
	 Dg5IjcwIDqMj4tlOivVTrTalKpzFh6XojsZhJHCJ4wqlG2WyCCPmi8f7vy2arzHyoC
	 weuYNGKTN3uaL9z5ggmLKiUATaQF1yUDAZbi+yxCzv1lJKQIQ0IGr8ywNvrCLkXNcM
	 fTgT4UAo0QI/NUsz59PuMmL3iDSqeTa9pEo9eOR9X+H2JNFNFWVgzU/KVbE90/Su0D
	 pipsiszoqrHvCkcOOnPx5IpAUXGuH0y9uu/AdkFyFG5oUBhdQkWjr+s9DQwfN/o8gK
	 9WymAOmAbA+KA==
Date: Sat, 16 Dec 2023 14:16:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, robert.marko@sartura.hr,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <20231216-unearned-lucid-4bd2ddcd4ac2@spud>
References: <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
 <20231215-gauze-sprinkled-172729f22b6c@spud>
 <9eab958e-d91f-4f3c-aadd-6b34eaed2cef@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lskATpY3N5YDan1V"
Content-Disposition: inline
In-Reply-To: <9eab958e-d91f-4f3c-aadd-6b34eaed2cef@quicinc.com>


--lskATpY3N5YDan1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 09:16:49PM +0800, Jie Luo wrote:
>=20
>=20
> On 12/15/2023 9:41 PM, Conor Dooley wrote:
> > On Fri, Dec 15, 2023 at 08:40:20PM +0800, Jie Luo wrote:
> > >=20
> > >=20
> > > On 12/15/2023 8:19 PM, Krzysztof Kozlowski wrote:
> > > > On 15/12/2023 12:42, Jie Luo wrote:
> > > > > > > > > > > > Which clocks are these mentioned in the property? F=
rom where do they come?
> > > > > > > > > > > >=20
> > > > > > > > > > > > Anyway, property is in existing form is not correct=
 - this is not a
> > > > > > > > > > > > generic property.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > This property cmn-reference-clock is just the hardwar=
e register
> > > > > > > > > > > configuration, since the different IPQ platform needs=
 to select
> > > > > > > > > > > the different reference clock source for the CMN PLL =
block that
> > > > > > > > > > > provides the various clock outputs to the all kinds o=
f Ethernet
> > > > > > > > > > > devices, which is not from GCC provider.
> > > > > > > > > >=20
> > > > > > > > > > AGAIN: where do the clocks come from? Which device gene=
rates them?
> > > > > > > > >=20
> > > > > > > > > Oh, OK, the reference clock is from wifi that provides 48=
MHZ to
> > > > > > > > > Ethernet block.
> > > > > > > >=20
> > > > > > > > Then WiFi should be providing you the clock and this device=
 should be
> > > > > > > > clock consumer, right?
> > > > > > >=20
> > > > > > > Yes, wifi provides 48MHz clock to CMM PLL block, there is no =
GCC
> > > > > > > for this 48MHZ clock output, it is the hardware PIN connectio=
n.
> > > > > >=20
> > > > > > All clocks are some hardware pin connections.
> > > > > >=20
> > > > > > Best regards,
> > > > > > Krzysztof
> > > > > >=20
> > > > >=20
> > > > > Yes, all reference clocks here are from hardware pin connection.
> > > >=20
> > > > You keep answering with short sentences without touching the root o=
f the
> > > > problem. I don't know exactly why, but I feel this discussion leads
> > > > nowhere. After long discussion you finally admitted that clocks came
> > > > from another device - Wifi. It took us like 6 emails?
> > > >=20
> > > > So last statement: if you have clock provider and clock consumer, y=
ou
> > > > must represent it in the bindings or provide rationale why it shoul=
d not
> > > > or must not be represented in the bindings. So far I do not see any=
 of
> > > > such arguments.
> > > >=20
> > > > If you use arguments like:
> > > > "My driver....": sorry, bindings are not about drivers
> > > > "I don't have clock driver for WiFi": sorry, it does not matter if =
you
> > > > can write one, right?
> > > >=20
> > > > Please reach internally your colleagues to solve these problems and=
 make
> > > > review process smoother.
> >=20
> > > These reference clocks source do not need the hardware configuration,
> > > that is the reason why the clock provider is not needed, some referen=
ce
> > > clock source are even from external crystal.
> >=20
> > I fail to understand how that makes this clock different to the clocks
> > on any other platform. Clocks from external crystals are present in many
> > many systems. See for example fixed-clock.yaml.
>=20
> The reference clock rate has no meaning to the CMN PLL block, since the
> software can't control the behavior of CMN PLL, and various output
> clocks of CMN PLL block are fixed, adding this custom property is just
> for selecting the different reference clock source, since different
> IPQ platform needs to be configured the different reference clock source
> for the CMN PLL block.

Many, many other systems are in the same situation, where clocks are
provided to a peripheral that has no control over the clock rate, but
has to pick internal dividers or set bits in a config register depending
on what clock rate is provided to it. That is not something special
about this particular platform and other systems are able to use the
clocks property for this purpose.

> let's say if we register 48MHZ reference clock as the fix clock, we
> can't distinguish it is internal 48MHZ or external 48MHZ, for these
> two reference clock sources, there are different hardware configuration
> of CMN PLL block

That's easy, if the reference is external, it is provided by the clocks
property. If it internal, then there will be no clocks property
providing it.

> and this reference clock selection is not applicable
> for the IPQ4019 platform.

Isn't this a patch for the IPQ4019? Why would it not be relevant?

> > > There is also no enable control for the reference clocks since it is
> > > inputted by the hardware PIN connection, i will update these descript=
ion
> > > in the DT to make it more clear.
> >=20
> > Again, this does not justify having custom properties for this clock,
> > as it is no different to other platforms. As far as I can tell, the only
> > thing that a standard "clocks" property cannot convey here is the
> > internal reference. I would suggest that since there is only one
> > internal clock frequency, the absence of this particular clock in the
> > "clocks" property can be used to determine that the reference is the
> > internal one.

I'm surprised you didn't pick up on this, but there are actually _2_
internal references, which I have just noticed while double checking the
binding patch.

What is the impact of using the 48 MHz or 96 MHz internal reference?

Thanks,
Conor.

> Yes, we can get the clock rate of the clocks property if we register
> these as the fix clock to distinguish the different clock source.
>=20
> Since the reference clock rate value has no matter with the CMN clock
> configuration, it is just the reference clock source selection, so
> i did not use the fix clock for this.
>
> Thanks for this suggestion, i will verify the fix clock register solution.

--lskATpY3N5YDan1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX2xTwAKCRB4tDGHoIJi
0psiAPwOjDlpx9TwSrv5c3aiBLP8ykDC5q3w39hpCmuz8eQLZgD/V8nYISfPXZY8
IBfmbcjtQYNPCAgQZSYXk2eYrs8/fw4=
=Tk8X
-----END PGP SIGNATURE-----

--lskATpY3N5YDan1V--

