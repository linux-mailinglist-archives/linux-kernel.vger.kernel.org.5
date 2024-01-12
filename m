Return-Path: <linux-kernel+bounces-24663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045DD82BFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B61F24747
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42859B5C;
	Fri, 12 Jan 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="J0LbxU3S"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA358ABB;
	Fri, 12 Jan 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 42FE660884;
	Fri, 12 Jan 2024 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1705063593;
	bh=spHBxL0T5QVtiotbfLvZE1HJm4xym++up4FJ1+AM8Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0LbxU3Sh5ZBcnGywCgULQo3hpZLl0T55FQqRg1hzSCA1cRLDDqc8eTVNV/r+tDAX
	 Cw3D0+Era0rbiLCrRV6u5cX1Qev/WVsoS0+MhsBrMd82dnTUbzL8vs8K+dUfAVjP1g
	 e1YNkZt9K51qIcYCLGpWk9kvABxqUmnChLaXbs7HI8ih16E6P3WYWaCF3PlV/+TBeT
	 YtPyTc5LNJAFaXg7q26+bjaqYOnDvl/6NgYhlL2UUL/UBMQ9tkiXbGN516uFcl8qiu
	 yL7/dKRB1Zl+uZ7IfX8HEyTEv7b4Qqf6TtR3kr7tseaKOXZBVSMWy11ZcficySvt7t
	 PZYekhSCtSIIg==
Date: Fri, 12 Jan 2024 14:45:59 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Roger Quadros <rogerq@kernel.org>,
	Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH 05/16] arm64: dts: ti: k3-am64: Add MIT license along
 with GPL-2.0
Message-ID: <20240112124559.GM5185@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-6-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110140903.4090946-6-nm@ti.com>

* Nishanth Menon <nm@ti.com> [700101 02:00]:
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

Acked-by: Tony Lindgren <tony@atomide.com>

