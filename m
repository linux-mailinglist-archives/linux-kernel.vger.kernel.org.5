Return-Path: <linux-kernel+bounces-57940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215084DF4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC101F2BD8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A37AE55;
	Thu,  8 Feb 2024 11:01:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547467E78;
	Thu,  8 Feb 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390084; cv=none; b=QWywTksNfk3flqJTeMLJ//x0aPJEEjyUNY+6nEvUwCC1p6Z1v7w0JMiZ4ftYuAtnYoNkpeKuLMi3BiBurJFGQYypNrn4vr6yFOEtzJ5cym+hr/5AXazOPjcsDxvMSjMSAoAfrCLR1KXEWNtDAwEBsVq4iQ8qGnqPscyakzxzEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390084; c=relaxed/simple;
	bh=RQiY2x/kbfGJWd67E0x5M+DvHL5FS0x/+1pqAG6y19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmhKhe+l+ZQFBHk5GeiaCwQBR1/ic6wbJymNmixX59mQydgIiXe9PzokqEn+rbo+k5RVsulCloJCz2Q5jYtaFjaccdLFUg2fVvPqhOHOloMhbe4YwyDAr2oenDhtQ7gLj22T+fcfvpVDXbYpivp6ZQNHxnb1GtozHCFYeiAZsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 894111FB;
	Thu,  8 Feb 2024 03:02:03 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5323F762;
	Thu,  8 Feb 2024 03:01:19 -0800 (PST)
Date: Thu, 8 Feb 2024 11:01:11 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: use capital "OR" for
 multiple licenses in SPDX
Message-ID: <20240208110111.3ed4e5f4@donnerap.manchester.arm.com>
In-Reply-To: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
References: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 11:53:00 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi,

> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts    | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi  | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> index dbce61b355d6..4bfb52609c94 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
>   */
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> index 1fed2b46cfe8..b2988f500231 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
>   */
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> index 832f08b2b260..ff84a3794470 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
>   */


