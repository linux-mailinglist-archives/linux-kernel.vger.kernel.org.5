Return-Path: <linux-kernel+bounces-27611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529482F2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A139A28772A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D261CA93;
	Tue, 16 Jan 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYvDD04n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11541CA87;
	Tue, 16 Jan 2024 17:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105ADC433C7;
	Tue, 16 Jan 2024 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705424863;
	bh=+J6OFZXz7AZ/IBScI79H1TDKdTdYLnQ20QFDaLANvjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYvDD04nkNrSO8ZRyS7yRyGFsjR6Z7Y96CF44xNwonJpYfFMEdbBgYaqs7aReVNX5
	 66UQXzE9JBMftPjbAsPj82gySETMtBRo7dSd0COGTzOnhHk5seBW6cwe627prxXvFQ
	 2XihRMGBDHrIBVArT7mMRmsHfJnUHp8p4sKNIuv6kM/Gcj9/FKZt0Wql2bXftTLQ2s
	 /d60jK/oNgYRPEADnVLFEqy6i4Q+5K/Rfy5AWR8RKuFeZMw3cp8olskt4Y4hR89hJ2
	 77Oo2pej9I6APxNc6rz0l5X/g5Kekzh+a3PfUB19SUgP6c2IZ3PTUVO+IrFacrr1es
	 u5bXDdFojtaYg==
Date: Tue, 16 Jan 2024 17:07:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: rockchip: rk809 fix existing example
Message-ID: <20240116-flick-ungraded-b36f8db15dcc@spud>
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-3-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BDyGpo91jO6xcf5l"
Content-Disposition: inline
In-Reply-To: <20240116132102.3272682-3-tim@feathertop.org>


--BDyGpo91jO6xcf5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:21:01AM +1100, Tim Lunn wrote:
> Fix typo in the example specifying wrong compatible string for rk809.
> Remove additional vccX-supply properties that dont exist on rk809.
>=20
> Signed-off-by: Tim Lunn <tim@feathertop.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

A fixes tag would be nice too I suppose. Not worth resending for IMO
since b4 will pick it up if you reply with one.

Thanks,
Conor.

--BDyGpo91jO6xcf5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa32gAKCRB4tDGHoIJi
0uG0AQDC2ImT5MjKTf4HGa7Ioch+YiRhKQ18P0S1aRyfoi7xPQEAoaDxLxpXf1JJ
Ownp4v0mP3JoN5oGLPMAitAyk9wdYAY=
=PzrD
-----END PGP SIGNATURE-----

--BDyGpo91jO6xcf5l--

