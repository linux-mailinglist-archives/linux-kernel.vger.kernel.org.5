Return-Path: <linux-kernel+bounces-9219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9F81C272
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774FF1F2453E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9200A41;
	Fri, 22 Dec 2023 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opWdrDgA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBEA23;
	Fri, 22 Dec 2023 00:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF0BC433C8;
	Fri, 22 Dec 2023 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703206327;
	bh=e51dEZBey8a5Rgc9VZ3hmXmY0WnCqjWipBVnU/5EzGA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=opWdrDgAPG2+3vtz8ifzXTX5v2DLGzbEJ/si7pjNZHOkCIFQ7U8Iqm+eizpMagmUj
	 ekoLLzVuYAYZIYQmb8wsD1ZDhKe7niEyrE+JmFVdyRKo6vY4G3p/5ZaEr2QEZ6n4EM
	 WPdo9hsKBdakUp7e4/Xi1BWmucMc6c3yJIZMwFOBsyAdpMmaXP/NUNax1mw52eRG95
	 /MSdYFPzxAD4VkdxqekwlQ4jJWS0s4Q77UDdsngq7m5yEwb/5miKUn2ub09j7E49XI
	 mhtY/linOsAKQU58/vLBzDOJcDtpLWdHc1pwlafUIpts9pTO7wsf4XCUtFbyyz+3Q6
	 5DztEM40ktOMg==
Message-ID: <8367d4fee209087702a354fd1df1f754.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231221132634.3008144-1-abel.vesa@linaro.org>
References: <20231221132634.3008144-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.8
From: Stephen Boyd <sboyd@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>, Mike Turquette <mturquette@baylibre.com>
Date: Thu, 21 Dec 2023 16:52:05 -0800
User-Agent: alot/0.10

Quoting Abel Vesa (2023-12-21 05:26:34)
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.8
>=20
> for you to fetch changes up to f52f00069888e410cec718792b3e314624f209ea:
>=20
>   clk: imx: pll14xx: change naming of fvco to fout (2023-12-21 15:00:00 +=
0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

