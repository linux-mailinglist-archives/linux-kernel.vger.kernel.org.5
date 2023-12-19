Return-Path: <linux-kernel+bounces-5569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B10818C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE01B2314E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFED1DDEE;
	Tue, 19 Dec 2023 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXnU1sRU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C731D54D;
	Tue, 19 Dec 2023 16:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50975C433C7;
	Tue, 19 Dec 2023 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703003986;
	bh=DT67ZW2+7W7SD3PMRmJ/cCFJ+tiSAVkDYvY8fK5VSCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXnU1sRUlssrMaubs35Weig4mJ7cexODuIlPLyIjQc1AVB7EucGeE4Kg5R0hyInKx
	 jYBnrb+zt9e7od6NvxkNy752We/zA12wkv711DjK0nom9uw+e3kGVrwjP0aJIB9Ez3
	 D9jXbtX8UG79fw+JwMgjZ1oXV69MHi9lkBWg4VkIOGbdoFB9DJ4tpTuF+U5j2fvSwt
	 El82HnryXouUWO9Yw+QGYn7HwbBoaEZci0CFfw/+b66mMfjFQVdQkfNPLTjFeMpIwO
	 kDsivo1zuCFSFul0ozEH16dwaEMcSZhoMOoAbv5/fZ8I0xlz6lDWvwZKDZ+jhZLO3O
	 1UA5kTwXIotzg==
Date: Tue, 19 Dec 2023 16:39:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Erwan Leray <erwan.leray@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: spi: stm32: add st,stm32mp25-spi
 compatible
Message-ID: <20231219-subwoofer-aversion-385ee53dc6be@spud>
References: <20231218155721.359198-1-alain.volmat@foss.st.com>
 <20231218155721.359198-3-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4JfhjNn4JBeIfO3a"
Content-Disposition: inline
In-Reply-To: <20231218155721.359198-3-alain.volmat@foss.st.com>


--4JfhjNn4JBeIfO3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--4JfhjNn4JBeIfO3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYHHTAAKCRB4tDGHoIJi
0hGNAP0WWifqG0WIUZAm9584zAolrMPgrTHdyBtimolc18oB7wD/fb/NYoQ375mc
QjQs2n6rDOzLOQS4euFbxvdah5N8FQs=
=RwnB
-----END PGP SIGNATURE-----

--4JfhjNn4JBeIfO3a--

