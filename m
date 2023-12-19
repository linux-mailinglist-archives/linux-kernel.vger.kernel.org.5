Return-Path: <linux-kernel+bounces-5607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69CF818D06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E51F24947
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933A224EE;
	Tue, 19 Dec 2023 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4xd/pGN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79323778;
	Tue, 19 Dec 2023 16:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30B4C433C8;
	Tue, 19 Dec 2023 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004875;
	bh=hMMTJJLnbJZI7eeaAsFFenoqHPm3dmFrvvkbbNL6DWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4xd/pGNfaBEvLKT+79F5NQd9tEbwzcz0ewGVgKRdSHdwGZ5O1PQSaej6Si+HFsqU
	 KKRvkWmKXWFs6ANpQ5FMt3sS4xIsYOgV6hU1Pg0QPIlz7X/bPvNwANTRLKIaOMG3Mz
	 yg4w6V+WUgtHV6w+2Cns1GaBroyBlZQPv23qJzZfXW/8VSUDs8GQCgtNYC3ddfOhkj
	 rlSOW8wKefUA1dLy/TVCd/XpelGq8fbRUT83KO2aWmj2rhZ9z6qdfIYSApaajecN2Y
	 vt2n5KpcQ/b6r1Et4TODcsSNtPQMxgtLRRXNzKOorq6MxZh8jBiqEVMVrcVE62px3d
	 5qaLCw6gOSt7g==
Date: Tue, 19 Dec 2023 16:54:29 +0000
From: Conor Dooley <conor@kernel.org>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 0/3] Add mediatek,gce-events definition to
 mediatek,gce-mailbox bindings
Message-ID: <20231219-joyous-tarmac-aaf601623859@spud>
References: <20231218083604.7327-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i+MCw2cELYYzOA1i"
Content-Disposition: inline
In-Reply-To: <20231218083604.7327-1-jason-jh.lin@mediatek.com>


--i+MCw2cELYYzOA1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 04:36:01PM +0800, Jason-JH.Lin wrote:
> From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
>=20
> Since mediatek,gce-events property is a HW event signal from GCE,
> it should be defined in mediatek,gce-mailbox.yaml.
>=20
> Change the description of mediatek,gce-events property existed in
> other bindings to reference mediatek,gce-mailbox.yaml.

I don't understand this series. I would understand it if the property
should be related to the mailbox provider and it is moved there from the
mailbox consumer, but this series does not do that. Instead the series
now documents this property for both consumers and providers.

Secondly it removes the typedef from the consumers, which makes no sense
if this is a valid property there.

Is your intention to document a property that should be common across
all consumers in a single place? If that is your goal, then something
like spi-peripheral-props.yaml is what you need here.

Confused,
Conor.

--i+MCw2cELYYzOA1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYHKxQAKCRB4tDGHoIJi
0oiDAQCnS/e4ChdhTrIMgLXWQjCO4EzlP4LIjirHyIs1A+qTtAD/b4JZtsykUGPz
pLSkPCj6WxQKyOcdkpUxoanC2mDwUAE=
=MQP9
-----END PGP SIGNATURE-----

--i+MCw2cELYYzOA1i--

