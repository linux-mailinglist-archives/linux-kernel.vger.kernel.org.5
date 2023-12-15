Return-Path: <linux-kernel+bounces-774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6F8145D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EA81F21A97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF831C28F;
	Fri, 15 Dec 2023 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asfeppbA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA801A704;
	Fri, 15 Dec 2023 10:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54598C433C8;
	Fri, 15 Dec 2023 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702636953;
	bh=cbq/for1fT1/aMAwkkiVODRQoqfzFgJjEOjBZSRK4lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asfeppbABUhdnqqjlY+HjF1MwY8p9z4KmnXK8DDjIFnkUA+sFd82ZXkMBpFACeS/0
	 tyWhZAA3t1IgZMZkv6sbGEzqEVocnZQKR9pHLVvqndlnkzcDWwHd04WUhFw3BAaVb8
	 zOXFAcB2B9mRxPYMR2pZWJZ4in8wq6gNqZYKZo31c9ktPvxkQIzhIJ9AhPJ8mXdWHw
	 7goo65zdQJr3ho79/bVMFw7rlv0bQ9v2PNoGtUdJYjzIcZ4wFytrq8wyLxAp+uvimD
	 SRHgw2idAcuJSnK1CF5IuLrYMtD9kQ7mLKvhacsqqAvNmk/aE9eyBseJ4+0LXgmeXM
	 0Zt+1E+TZxB3w==
Date: Fri, 15 Dec 2023 10:42:27 +0000
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
Message-ID: <20231215-junkyard-primate-64d32bbde12c@spud>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
 <20231214-outshine-shush-8a11c68607cd@spud>
 <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
 <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lPsoRtMa/4Vasazk"
Content-Disposition: inline
In-Reply-To: <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>


--lPsoRtMa/4Vasazk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > This is indeed not a generic property, which is the Ethernet
> > > function configs same as clock-frequency.
> >=20
> >=20
> > Then it should not be made as a generic property...
>=20
> sure, i saw your another comments, will prefix qcom_ on this property.

iff the property stays, that would be a prefix of "qcom," not "qcom_".

Cheers,
Conor.

--lPsoRtMa/4Vasazk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXwtkgAKCRB4tDGHoIJi
0omZAP9JSfFHjp1++gshgNWcCEiTlr90TUqSvd1rzXSVelfeqwD+Lra2OcWNoJ1x
iEoXqTpeaWcyqzifYrBHXenZ8sb17gg=
=Ozgz
-----END PGP SIGNATURE-----

--lPsoRtMa/4Vasazk--

