Return-Path: <linux-kernel+bounces-23601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B259C82AEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45111C2131A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3115E85;
	Thu, 11 Jan 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqmsdUJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923615AEB;
	Thu, 11 Jan 2024 12:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60887C433C7;
	Thu, 11 Jan 2024 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704977210;
	bh=6AgBJtjS2ggWZ9QntBWFCfsvvC+cFjIqDg3BLT2Y3dY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NqmsdUJDhEuCFJIIU5Jl6Uvyas62k0A3YzDhjJbMfYN37TwVisAg6xG1m5JOR6M2c
	 560x6V9diGOM26ePjyi3+blE+SxDs6dumHeU873k2QFYocieX0yZJm2k5k55oyZoR2
	 ISVMQS0LqOIsXQBSIIM1Hm4pJ+GgB/ytdDBIIMKCq7jpefa91HpevO4uDAkWH14ziJ
	 lj6ZnEK+lavfn+D+nu/s0M2yQFrNtWiGYu55fCLus0GD4Ol3cMhCkjVSW5NC+16RKI
	 tPJITTTwYYOUu6ET103+KsxWSF7dteweDiIhNeeHvI4OPd9tGvzimQFxW94fB1kl+U
	 k6vVW1qr73QZQ==
Message-ID: <b3bedc71-3eb5-4e47-855a-a4d9d6f06069@kernel.org>
Date: Thu, 11 Jan 2024 14:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT license along
 with GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Panis <jpanis@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Sarah Walker
 <sarah.walker@imgtec.com>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-4-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240110140903.4090946-4-nm@ti.com>
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
> 

Acked-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

