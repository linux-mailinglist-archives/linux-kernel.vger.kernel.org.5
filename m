Return-Path: <linux-kernel+bounces-1032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD9814981
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A476B237A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32BF2EB19;
	Fri, 15 Dec 2023 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAbLq0a4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439C2DF97;
	Fri, 15 Dec 2023 13:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B574C433C8;
	Fri, 15 Dec 2023 13:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702647704;
	bh=ofCPvhE3rPFrA60eGlM3ABSTLtZ1mI9JLqdMqmvW9mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAbLq0a4k8KxFFquNN34idVISj8/qphcRB/0zIg2gLy223GHS4OSCkrm2M0x/+q0x
	 7b8r9THOzs0M6mzYX3LHbNsrL9TJn3+BxVqyCopjz6pe/nAgDh7aiPAWgoHfvHN3OE
	 q6A3anYQ+c/1CytuIyuCOQVuDnxXK/Tegkc1PVAHXMsTsngIos6IIWdDgRNPoZ1ntE
	 mDVje97TaV5JHyLx5oyh04CqXYGGWFz5WH1hPQsGg1UcwZSZdZNy5SbrwnPLiRfJKl
	 UcCeyjO9BppBSPOgOmwex+qNQbSnGyeb61bvgINSCj1+EbNafYodkOBjrE7dIMiE7c
	 Eem1jJWp4fRZg==
Date: Fri, 15 Dec 2023 13:41:38 +0000
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
Message-ID: <20231215-gauze-sprinkled-172729f22b6c@spud>
References: <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TU1olG04/N/WRNt5"
Content-Disposition: inline
In-Reply-To: <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>


--TU1olG04/N/WRNt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:40:20PM +0800, Jie Luo wrote:
>=20
>=20
> On 12/15/2023 8:19 PM, Krzysztof Kozlowski wrote:
> > On 15/12/2023 12:42, Jie Luo wrote:
> > > > > > > > > > Which clocks are these mentioned in the property? From =
where do they come?
> > > > > > > > > >=20
> > > > > > > > > > Anyway, property is in existing form is not correct - t=
his is not a
> > > > > > > > > > generic property.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > This property cmn-reference-clock is just the hardware re=
gister
> > > > > > > > > configuration, since the different IPQ platform needs to =
select
> > > > > > > > > the different reference clock source for the CMN PLL bloc=
k that
> > > > > > > > > provides the various clock outputs to the all kinds of Et=
hernet
> > > > > > > > > devices, which is not from GCC provider.
> > > > > > > >=20
> > > > > > > > AGAIN: where do the clocks come from? Which device generate=
s them?
> > > > > > >=20
> > > > > > > Oh, OK, the reference clock is from wifi that provides 48MHZ =
to
> > > > > > > Ethernet block.
> > > > > >=20
> > > > > > Then WiFi should be providing you the clock and this device sho=
uld be
> > > > > > clock consumer, right?
> > > > >=20
> > > > > Yes, wifi provides 48MHz clock to CMM PLL block, there is no GCC
> > > > > for this 48MHZ clock output, it is the hardware PIN connection.
> > > >=20
> > > > All clocks are some hardware pin connections.
> > > >=20
> > > > Best regards,
> > > > Krzysztof
> > > >=20
> > >=20
> > > Yes, all reference clocks here are from hardware pin connection.
> >=20
> > You keep answering with short sentences without touching the root of the
> > problem. I don't know exactly why, but I feel this discussion leads
> > nowhere. After long discussion you finally admitted that clocks came
> > from another device - Wifi. It took us like 6 emails?
> >=20
> > So last statement: if you have clock provider and clock consumer, you
> > must represent it in the bindings or provide rationale why it should not
> > or must not be represented in the bindings. So far I do not see any of
> > such arguments.
> >=20
> > If you use arguments like:
> > "My driver....": sorry, bindings are not about drivers
> > "I don't have clock driver for WiFi": sorry, it does not matter if you
> > can write one, right?
> >=20
> > Please reach internally your colleagues to solve these problems and make
> > review process smoother.

> These reference clocks source do not need the hardware configuration,
> that is the reason why the clock provider is not needed, some reference
> clock source are even from external crystal.

I fail to understand how that makes this clock different to the clocks
on any other platform. Clocks from external crystals are present in many
many systems. See for example fixed-clock.yaml.

> There is also no enable control for the reference clocks since it is
> inputted by the hardware PIN connection, i will update these description
> in the DT to make it more clear.

Again, this does not justify having custom properties for this clock,
as it is no different to other platforms. As far as I can tell, the only
thing that a standard "clocks" property cannot convey here is the
internal reference. I would suggest that since there is only one
internal clock frequency, the absence of this particular clock in the
"clocks" property can be used to determine that the reference is the
internal one.

Thanks,
Conor.

--TU1olG04/N/WRNt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXxXjgAKCRB4tDGHoIJi
0ktnAQDXBBwhZHLj4sCIUSdyx4+oOH09y7pvBGaGOqmUTOcvqAEAzJuNBZWAf+Y6
Z4suZfbVe+CoDxDWfXUAiedmYQY7kgA=
=tykB
-----END PGP SIGNATURE-----

--TU1olG04/N/WRNt5--

