Return-Path: <linux-kernel+bounces-24919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6682C4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF0D284E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD817540;
	Fri, 12 Jan 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/5NauOD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7922612;
	Fri, 12 Jan 2024 17:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB54C433F1;
	Fri, 12 Jan 2024 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705080377;
	bh=G13ttglQZFvIxRzYqlByAFmV0GTC0NKlv+puvnh+HkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/5NauODxWkrXBrumGRvhpsDdjKxFAqtxEfpKF3YSbeKlLwFN6SfLMplnny9zcrN4
	 +BOdPfmazJpUY71pjnhP10h4i9xABe4qVBTVEy8orFrkXXKOas0oJQAXluJ/aH6Q6t
	 UZdhzWpfJgedTCCGf368LPN6ZAHw5Sh8QScp4sQWFrAXFTT+RUgUElUGpclPGseY/B
	 auCN1400aQevegXgvydK2D3fbbtMs5MbYijVUBS7rYOFsQ50kmTpr/eDhpdIL9g8ra
	 8qgjFUzuJ6h9QLzOxAr29fjiA9T+ei1OmcBxm+iZKnok4NhzbKv3UL4IF59Sq5mCH0
	 6f3FDQLZ7CLkQ==
Date: Fri, 12 Jan 2024 17:26:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: KyuHyuk Lee <lee@kyuhyuk.kr>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1S
 board
Message-ID: <20240112-headsman-concur-1d47da7e3e14@spud>
References: <20240112134230.28055-1-lee@kyuhyuk.kr>
 <20240112-granola-underline-36a525dc789c@spud>
 <dc4e9808-cd36-4b99-afd9-8dd4cd16a2a9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BlTaGf17Fz4L1eNA"
Content-Disposition: inline
In-Reply-To: <dc4e9808-cd36-4b99-afd9-8dd4cd16a2a9@linaro.org>


--BlTaGf17Fz4L1eNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 06:02:09PM +0100, Krzysztof Kozlowski wrote:
> On 12/01/2024 17:58, Conor Dooley wrote:
> > On Fri, Jan 12, 2024 at 10:42:30PM +0900, KyuHyuk Lee wrote:
> >> Add device tree binding for Hardkernel ODROID-M1S board based on
> >> RK3566 SoC.
> >>
> >> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> >> ---
> >>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Doc=
umentation/devicetree/bindings/arm/rockchip.yaml
> >> index 5cf5cbef2cf5..cc37d2118131 100644
> >> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> >> @@ -566,6 +566,11 @@ properties:
> >>            - const: rockchip,rk3568-odroid-m1
> >>            - const: rockchip,rk3568
> >> =20
> >> +      - description: Hardkernel Odroid M1S
> >=20
> > if the vendor for this board is hardkernel...
> >=20
> >> +        items:
> >> +          - const: rockchip,rk3566-odroid-m1s
> >=20
> > ...why is the vendor prefix here rockchip?
>=20
> Uh, good catch. I missed it when acking their earlier mistake year ago
> :( Would be nice if they fixed that one too.

Maybe they will if they got your email, they did not get mine
apparently:
<lee@kyuhyuk.kr>: host mx02.mail.icloud.com[17.57.155.34] said: 554 5.7.1
    [HM08] Message rejected due to local policy. Please visit
    https://support.apple.com/en-us/HT204137 (in reply to end of DATA comma=
nd)


--BlTaGf17Fz4L1eNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaF2NAAKCRB4tDGHoIJi
0m7FAQCuvT9Rcw0zZGt/yZ0NOireQ5ZqcA+Vh5bLT+YEF7jv5QD6A8iGqsl6Cz2q
UGZPQh2gBpqx2DAGHZ+yLKZv9WOaQA4=
=J3G+
-----END PGP SIGNATURE-----

--BlTaGf17Fz4L1eNA--

