Return-Path: <linux-kernel+bounces-2874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E757F816388
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FA02821DD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC04B12A;
	Sun, 17 Dec 2023 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVZTe05u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054174B122;
	Sun, 17 Dec 2023 23:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C22EC433C8;
	Sun, 17 Dec 2023 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702857203;
	bh=sgxwfsweJRuqYU5fL/zEBQhjR1M4/d2P7ekPhOvmAVg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mVZTe05uw2KFjrFpifEAM1LxSmxnYK+vbZD/uS7DWtUoiGA7SAkoOey0hyKbrWJAx
	 iw70oHJ1r6RXVeY+ekY6R67wnHxq9qGVkplD5bz929CKQXpnha9JKNxL02yJDRmH9G
	 SiB+2QEKPiuVVbC0ZaLzQ3D9ZPEiquXt29XYg1oCpKSsoTRlRJOEuh+Ylz2Vbj8Tyz
	 2nD+KFU0yvIkUojXRLN4tx4gJsMxWsNwNxLr6iujuD+JEM5AH5ghKrP1kRp00H1eOM
	 PWf433SWcUeMDkTFpgwS6RiLPigIKPhQkzoX8iBm2GHZLonPI08jcwgJJJ/qzQH50A
	 q9hwwAGw6/hoA==
Message-ID: <67c89fcb076df1ba5332c8840eb01dfc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231208143700.354785-2-gabriel.fernandez@foss.st.com>
References: <20231208143700.354785-1-gabriel.fernandez@foss.st.com> <20231208143700.354785-2-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v6 1/5] clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Sun, 17 Dec 2023 15:53:20 -0800
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2023-12-08 06:36:56)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Move all STM32MP clock drivers into same directory (stm32).
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

