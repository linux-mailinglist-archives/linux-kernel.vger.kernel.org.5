Return-Path: <linux-kernel+bounces-2877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D775816392
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22381F21AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185044B12B;
	Sun, 17 Dec 2023 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHTE7p3h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DB4B132;
	Sun, 17 Dec 2023 23:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FC2C433C7;
	Sun, 17 Dec 2023 23:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702857275;
	bh=hUw/dqLJ8c9mp0C2ocR/kSRcZ8F+vi76KvW9vcL+1TA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YHTE7p3hbgb/pUEPYH2XW/kIJtcmQ7uQy+BluxzlQYQcr2faxjNTHzxzkEmJKe89X
	 IJZagjZjFgs3UNL2kYJGOJfk0pOZSzRq3IJfJBCNscXuyc5IVuyI4om43UxEizE4YV
	 0FHjRFqrhFANzkIKXWMjgFqEM0exCa9LMF0PcxA5QRKPci3NRqFldrgt3TF7CRMWhB
	 9/+ICgIJwmyAf18+X/jhkAJBDEMHTTO7Jrk+cgY5EJtLXj+5Ior3hy7pVXgoSH3ThD
	 CSo4CKvXfmF3Vr7BMse75V7lveOY2qkr1GI+BYhWxVtMhfTyJ6XVfpZCAu/N2TEdPj
	 axOBN5DXMcJ4A==
Message-ID: <d833e349ad841b1a3389ba475833e903.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231208143700.354785-4-gabriel.fernandez@foss.st.com>
References: <20231208143700.354785-1-gabriel.fernandez@foss.st.com> <20231208143700.354785-4-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v6 3/5] dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Sun, 17 Dec 2023 15:54:33 -0800
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2023-12-08 06:36:58)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Adds clock and reset binding entries for STM32MP25 SoC family
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

