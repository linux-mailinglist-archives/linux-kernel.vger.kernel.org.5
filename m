Return-Path: <linux-kernel+bounces-2807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86781623C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B8EB219D1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF8481DE;
	Sun, 17 Dec 2023 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiF/bvFK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B7347C9;
	Sun, 17 Dec 2023 21:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA003C433C9;
	Sun, 17 Dec 2023 21:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846854;
	bh=dLUn35UA/Sb7ArEyYqHx1uehSdc2aOYdk53eZo+sKBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiF/bvFKOuhi9o3eUE3ldiUAhidrwQRSR4Gvx941UVTpumuCEQPu9kibJJu+omMRe
	 myLYIVyfrjWI+VqfSxdmfxzchQObPmQL0uqPKCqKS1t5ABtWKdMD8bbk/P7PSDL2Tu
	 g3jGGfLVFnCQYd7q9UE04budmM6coiSToB9zDL4zbyYorEbqOKrR/e5XBKvgKgZGWU
	 C36R0DZeySZw0oMI9KBt1VeNPQmwmq7A/CxOo/3qNmuw2JanhGOEP8x9GOBbeW/JH+
	 uVsE5D29fpIy5BjYoIAzX328HV4xJfkvY81qSrKVeRK8w+KgBk9kyf9sRw4csnP2eN
	 ppE0YtyB8Vx8A==
Date: Sun, 17 Dec 2023 21:00:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/27] dt-bindings: display: rockchip,inno-hdmi:
 Document RK3128 compatible
Message-ID: <20231217-anime-ammonia-0c21d756aa9f@spud>
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YGZ6xIC/6d6TbrZP"
Content-Disposition: inline
In-Reply-To: <20231216162639.125215-2-knaerzche@gmail.com>


--YGZ6xIC/6d6TbrZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 16, 2023 at 05:26:12PM +0100, Alex Bee wrote:
> The integration for this SoC is different from the currently existing: It
> needs it's PHY's reference clock rate to calculate the DDC bus frequency
> correctly. The controller is also part of a powerdomain, so this gets added
> as an mandatory property for this variant.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--YGZ6xIC/6d6TbrZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9hgQAKCRB4tDGHoIJi
0gmdAQCoq35UjFbaHME9UwkwUjJmL1alYK13VWsogsFJyz1XMAEAncMIoDK2K0j/
ScWGK8GBr5Ctm+tYm8iWoY9txXEbxwE=
=mlNV
-----END PGP SIGNATURE-----

--YGZ6xIC/6d6TbrZP--

