Return-Path: <linux-kernel+bounces-23602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C882AEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB491C21183
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BDA15E86;
	Thu, 11 Jan 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv6yV/Fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDC15AEB;
	Thu, 11 Jan 2024 12:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885A4C43390;
	Thu, 11 Jan 2024 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704977242;
	bh=1VjuSDi447ndXyR5iHt0YkDIkWP6vai+3+d8VhFBnbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jv6yV/FpvH7T7xcObJdtg+YfKwl2NBB9jS7KJMrsBl+ABHzEyz4B60PYCHixUOF7y
	 IG/zOuhCiePNvOLdv8rti6Po5xbekKW/p3wygx9pGQj7dCdFYAExZM0ChjGMQpLhEo
	 UNjS3IYDFxu53kKQqTy/EaXSZj/KEaPofTgoEZF/bNak8011VaR1Y/ZcKYEnRehg4H
	 H8ckgWI4ZW2M1veT9IWIsrbTsZrorLwQi2HsZL2iWLZNiY3t67LXEc/YONTVLybZos
	 FYibiAwMaCWnhfLFAi1eDqXF/Aj9U3nkzbeHYIQFApy62rhHSTXHrWWr71VN/gDnLp
	 CCQcDRMCB5v1w==
Message-ID: <4f693c5e-f350-4f60-bdfc-f0176761ed90@kernel.org>
Date: Thu, 11 Jan 2024 14:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] arm64: dts: ti: k3-am64: Add MIT license along with
 GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Tony Lindgren <tony@atomide.com>,
 Wadim Egorov <w.egorov@phytec.de>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-6-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240110140903.4090946-6-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 16:08, Nishanth Menon wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
> 
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).

Acked-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

