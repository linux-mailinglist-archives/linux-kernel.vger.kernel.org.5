Return-Path: <linux-kernel+bounces-23655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9582AFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90913B24455
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25D7171C6;
	Thu, 11 Jan 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="UfJnl/bx"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38589171B0;
	Thu, 11 Jan 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 6B9866058E;
	Thu, 11 Jan 2024 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1704979841;
	bh=QmOYLoO2FmAnEJI+GkJDiP/C375LS5vC8DeD3lt/UDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfJnl/bxPyHDbzusCQnRpzN4fycn8KrLfucekOivxDwDlSeBfbukiZ+e8JarS9+gW
	 u8FP4cLDi4bDGROpXX9t54FJkoN7DU4OGtb/rnpI6byyP5YezlStGLSpkhQ/wEgOa5
	 Ake+r5kS635cvtbrhP/550lpXsDCduEW5so6gYsxYOCaQ+3sX7u+ArX9VTxxhSBiC6
	 i45Hsr7Oiwb32cfm+FH/1YgzvTd8oyKlWjRKBxxJVLeNLOa35dcH+mZ/aCTi+8I9WT
	 K4/yh5VVzQrNhagg9QuL67JAwkFPjpwMB7CKR+cnQKca8PVsknUAeBJQiHsU2JdP+Q
	 D+YacfLW7gnrA==
Date: Thu, 11 Jan 2024 15:30:05 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Guillaume La Roque <glaroque@baylibre.com>,
	Julien Panis <jpanis@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Roger Quadros <rogerq@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Sarah Walker <sarah.walker@imgtec.com>
Subject: Re: [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT license along
 with GPL-2.0
Message-ID: <20240111133005.GC5185@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-4-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110140903.4090946-4-nm@ti.com>

* Nishanth Menon <nm@ti.com> [240110 14:09]:
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

