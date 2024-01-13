Return-Path: <linux-kernel+bounces-25172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32582C904
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A47A2862C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E118E0A;
	Sat, 13 Jan 2024 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1Q/ctXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A911A5B9;
	Sat, 13 Jan 2024 01:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AF7C433C7;
	Sat, 13 Jan 2024 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705111150;
	bh=PWQ6XDiZkF/02cmzi6L56v9vforZ7mEBwNN+MmzS5wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1Q/ctXpRolf1YnlafE1gF4GsNJ4ATaPva4KA2St8MT2jh3xF1AT3Wv7GCmdf/2/A
	 BPyDTkZUUJeCyEHqtBV9aF63nYk9DGzw3FMlbmkNLUx7ySi1ikgGPbtnYnNfoIhFRs
	 xVLhIbPdfPKQmf0WwEgPAygCMBWp27mZ9jRLxQiYsuebs/53ombS0K/msyc7OhxjpH
	 nfkE1ircdHa2OPmnAXrwTsVNaRyoU7FNHiQp1Q2c8t0xm4yowBGuU/SfOWluTrdWwL
	 7XiPLyC7uv6QsVT524Z4tkf16TXeuB3AVe35RYwM7D2vM7ppZWOo8gK/cEIuJZdonb
	 YZpRJPVaxi2WA==
Date: Fri, 12 Jan 2024 19:59:07 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] docs: dt: submitting-patches: add commit subject
 prefix in reversed format
Message-ID: <170511114687.3835042.2835996129362203327.robh@kernel.org>
References: <20240108083750.16350-1-krzysztof.kozlowski@linaro.org>
 <20240108083750.16350-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108083750.16350-2-krzysztof.kozlowski@linaro.org>


On Mon, 08 Jan 2024 09:37:50 +0100, Krzysztof Kozlowski wrote:
> ASoC, media, regulators and SPI subsystems prefer commits starting with
> subsystem name (e.g. "spi: dt-bindings:"), so document this to avoid
> confusing contributors.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!


