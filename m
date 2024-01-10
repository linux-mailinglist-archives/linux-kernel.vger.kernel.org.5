Return-Path: <linux-kernel+bounces-22473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC1829E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CE6B22092
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3CD4C62C;
	Wed, 10 Jan 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Nh8JmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E34C614;
	Wed, 10 Jan 2024 16:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF9C433C7;
	Wed, 10 Jan 2024 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704902704;
	bh=59+le7fXjctIPbpN9qB4BCB8QpLgl+kvZFwrdOVqGm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0Nh8JmSeLh/gTbSgK2b8WTCaIEeipH7goasBhQCrfZRmSBahEj7Ky+DgX3NKgGY9
	 XmMx0nZ48ovzcOigjXBme91g0Flmneme/+y8Qq3/scWgw7C4pAq7i5AmjZU7FkFuiO
	 DHpMk91c0Dnv/NF0jVcLrOwtsVFeUJHovwkCSyLBGpX85CtJ0eYMHlHEfRwNIqrkhC
	 Gh10IjhW7kGVzJzIXkqKEXxHUEQfn01/05HGM/fE9vnioT2NkjFONmYLfW10uVjAGX
	 7ejdWnX5AEX+aztvzw0Z3hCwdNjAdIJE8B5f5XbmRGnxEMEjuJaC9KtQLlfE+rSVdI
	 4viU2fkU8tuew==
Date: Wed, 10 Jan 2024 16:04:58 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi
 AX3000T
Message-ID: <20240110-commend-scrunch-847e224918c6@spud>
References: <20240110095118.25598-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFyTv1x5d4o5hpfV"
Content-Disposition: inline
In-Reply-To: <20240110095118.25598-1-zajec5@gmail.com>


--nFyTv1x5d4o5hpfV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:51:17AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7981B (AKA Filogic 820) is MediaTek's dual-core ARM Cortex-A53 SoC.
> One of market devices using this SoC is Xiaomi AX3000T.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--nFyTv1x5d4o5hpfV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ7AKgAKCRB4tDGHoIJi
0m1ZAP9HShIib21NY/hwAr4GUciP78tQnAWEozG/x6/G0PZt9AD+KcxphqD4ptPZ
d2WQOFJ3JjaujTk+7/mNVeIdBsQMDA0=
=2AMC
-----END PGP SIGNATURE-----

--nFyTv1x5d4o5hpfV--

