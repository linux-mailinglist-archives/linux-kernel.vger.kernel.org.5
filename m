Return-Path: <linux-kernel+bounces-7411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8281A78D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E627CB23C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4517487BC;
	Wed, 20 Dec 2023 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/ToVQy+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17541482E3;
	Wed, 20 Dec 2023 20:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695E1C433C8;
	Wed, 20 Dec 2023 20:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703103334;
	bh=5ZO7c/EmXJZ5eHRchpNh4PpVHM8dWDHI/0a2pQcgH/M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l/ToVQy+NnJuffzdtVgHuyqriaBsyymX0DqIu8IUdFu3FeM2d0/+2mLMeM6FziJIg
	 KNCEzjIqtFH7sUyqGypNU0swocwH5dAHfynKBqtsb6a/gs1lVVL2cE3Mq2kV6ltAAK
	 NqXbflr4qkxrKsIHIO/eHJl6fFh7AD1+Y3Q6z0jTnq1dQRU0UXsLEayXMNSBd6bnBD
	 oHMGpfOGo3kLK+NMUfsqluwSg46h6q6amYlwX68xMInl8OgcMRhhgcx+WkzNngbgLQ
	 QwR9ypiR5kaJCBmV7lju/V+k2ycHLlRQnqMFA/gAHJhFC3X8FcGeJj9mNq0TWme3iB
	 ang6h31avR2Ag==
Message-ID: <00ac7920c506f6a0bb8d11d45c37993c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231220084043.21549-1-krzysztof.kozlowski@linaro.org>
References: <20231220084043.21549-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.8
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 20 Dec 2023 12:15:32 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2023-12-20 00:40:43)
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.8
>=20
> for you to fetch changes up to 5583e92be5c45448e6ea461e1780d46c17d14963:
>=20
>   clk: samsung: Improve kernel-doc comments (2023-11-16 20:46:03 +0100)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

