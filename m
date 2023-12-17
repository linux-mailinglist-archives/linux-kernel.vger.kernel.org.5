Return-Path: <linux-kernel+bounces-2875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FD81638C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFAB21272
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F974B131;
	Sun, 17 Dec 2023 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9i0K6/m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641334AF92;
	Sun, 17 Dec 2023 23:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EEEC433C7;
	Sun, 17 Dec 2023 23:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702857214;
	bh=0bExTtZ+AFUEv9qhiNeUzHa2Awe6uWq0MksJYM0Uvz4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=i9i0K6/mEsgNlw0Q7SWFdL3BBZTgciM0RyQ+sy535u0TIzMxY5SxwB3nkJO5dzh97
	 W6JOswAzH0ksAgwjbEEOutNQaBzV9rwVek+iA9z3lbwNlgqWTf8vNUVTxHhYmhGsB2
	 3h+SK4vIO8gKCe/pSsL6WWkW5SFMdlfKUxnKTViWWneQ6hYm4HQNtmXsmZ2sydeJhA
	 TBGanDFDCrQSBAFz7x6yPjurC+BpPhqqsPtssPKquzJR+oLKheQ4qF9LX7Zr/7d175
	 Z0i8rHgCPJa4n8udN3mIAjoljatnS5XfDi+BTfaP05fujhIuc6jjRYrEYzDE+yIgxz
	 Vn6t8Oo3tqFIw==
Message-ID: <b4151a2bb19f18fbeb83dc872b3f1deb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231208143700.354785-3-gabriel.fernandez@foss.st.com>
References: <20231208143700.354785-1-gabriel.fernandez@foss.st.com> <20231208143700.354785-3-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v6 2/5] clk: stm32mp1: use stm32mp13 reset driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Sun, 17 Dec 2023 15:53:32 -0800
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2023-12-08 06:36:57)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> STM32MP15 is now using the same reset driver as STM32MP13 as they
> have the same binding requirement.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

