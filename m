Return-Path: <linux-kernel+bounces-5512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DECA818B88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F86428515F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C61CF9B;
	Tue, 19 Dec 2023 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfBdTNfY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61D20323;
	Tue, 19 Dec 2023 15:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A09CC433C8;
	Tue, 19 Dec 2023 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703000855;
	bh=AQxZwJRyYCooBacAcfE0Fb4AC5RHSeGYjU873ITYdfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfBdTNfYCV6BQGry70i7MLGYb0fzhAolflTHDvxtGgXwPbjM57mUcaup+xey/0AtG
	 /z3g3PMxMJZVBbZrULs+E5yhLNDH6Q/LgCPldK1JSoLPa4fwBbPZdaqn/XxTkr7r1y
	 SkINU2hAo3c25uH9Dg8D6kTwoJwZvU+AfP/3po0454K2tzhl6JjGhUrDqVvE4qyFGu
	 nAUIBaZc1VWzGUY5AvfCJVsmLA+568fw9v22vmeXhdNx2Jb7b20+2BGVEUYRYch0m6
	 ByHy5l+mTmDUrKcYWfAmBRWrozXehl+TFzBBJWnklI8sxLXc/g5b7/VJzIozE4ovXG
	 SeyKjmo8x8y4Q==
Date: Tue, 19 Dec 2023 15:47:25 +0000
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
Message-ID: <20231219-childcare-sugar-d1ecde8bd0b0@spud>
References: <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
 <20231215-gauze-sprinkled-172729f22b6c@spud>
 <9eab958e-d91f-4f3c-aadd-6b34eaed2cef@quicinc.com>
 <20231216-unearned-lucid-4bd2ddcd4ac2@spud>
 <af1dff98-a63e-47b3-a709-6f4110a97529@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JTFjFNDxZB5U8yyN"
Content-Disposition: inline
In-Reply-To: <af1dff98-a63e-47b3-a709-6f4110a97529@quicinc.com>


--JTFjFNDxZB5U8yyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:37:08PM +0800, Jie Luo wrote:
> On 12/16/2023 10:16 PM, Conor Dooley wrote:
> > On Sat, Dec 16, 2023 at 09:16:49PM +0800, Jie Luo wrote:
> > > On 12/15/2023 9:41 PM, Conor Dooley wrote:
> > > > On Fri, Dec 15, 2023 at 08:40:20PM +0800, Jie Luo wrote:
> > > > > On 12/15/2023 8:19 PM, Krzysztof Kozlowski wrote:
> > > > > > On 15/12/2023 12:42, Jie Luo wrote:

> > > > > There is also no enable control for the reference clocks since it=
 is
> > > > > inputted by the hardware PIN connection, i will update these desc=
ription
> > > > > in the DT to make it more clear.
> > > >=20
> > > > Again, this does not justify having custom properties for this cloc=
k,
> > > > as it is no different to other platforms. As far as I can tell, the=
 only
> > > > thing that a standard "clocks" property cannot convey here is the
> > > > internal reference. I would suggest that since there is only one
> > > > internal clock frequency, the absence of this particular clock in t=
he
> > > > "clocks" property can be used to determine that the reference is the
> > > > internal on
> >=20
> > I'm surprised you didn't pick up on this, but there are actually _2_
> > internal references, which I have just noticed while double checking the
> > binding patch.
>=20
> i noticed this, the reference clock source can be supported by clocks as
> you suggested here, it is really helpful.
>=20
> > What is the impact of using the 48 MHz or 96 MHz internal reference?
> They works on the different IPQ platform, 96MHZ internal reference is
> used on IPQ5018, the internal 48MHZ is used on the IPQ5332, that is
> same as what you describe above, the different clock source rate is
> selected as the different register value, then the PLL can do the
> corresponding config to output the correct clock rate, the external
> clock source is also same if the clock rate is same, just the different
> hardware PIN is selected if the external reference source is configured.


Ah, so there is only one internal reference frequency per device. Then
my suggestion to use the presence of the clock in the clocks property
should work, just the fallback to the internal reference is going to
depend on the compatible.

Thanks,
Conor.

--JTFjFNDxZB5U8yyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYG7DQAKCRB4tDGHoIJi
0sQKAP4mXSd9a5WjFFFYzWyxIoAUNBcprwl/NsXSqqrKn6kK7AEA7AWjD2ekqZ3g
JIMhnM9SUbdhSKHeDHZyFPsKgr/Kxww=
=ZI05
-----END PGP SIGNATURE-----

--JTFjFNDxZB5U8yyN--

