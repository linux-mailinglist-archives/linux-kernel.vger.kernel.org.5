Return-Path: <linux-kernel+bounces-23799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DEF82B1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED82F281A92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569C4CDE8;
	Thu, 11 Jan 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="T517siSF"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8294F5E6;
	Thu, 11 Jan 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id C64766085B;
	Thu, 11 Jan 2024 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1704987256;
	bh=r31fIdXtXqo8S8lLG9SP0uth5Z5/xJGcvm3iwdbqz1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T517siSFkIADbTTVLnD/GRoroygbbA0qlJGhaM5J+NtW9ZpLZ526Kpo0JZINietMv
	 x6PojCIp29w/40kQowY0Wp5clFxFWTCEuc/ih8Koo6pM3PJ68POGpE6aXXfQczF4QY
	 W0uzWx3L8jLov3ZL4tA//Nhpj/C9qENRm6a+CQt+zQClwoVvPkl0wmvVggYwmcflmi
	 T5DF5o5NnbuIJJ1o1MjFXN/TFDwmFiq5ASfgKwPwjjhKdwbJKpY2s6GPtfLOvzv+v1
	 6sYcbMiPWUXTkXk2qfNqNVPAmAOq+1D+RNvmOTKcD5eL23dZtnnU59NFbeBTdfJQ8k
	 IQZsu427yvAlA==
Date: Thu, 11 Jan 2024 17:33:49 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Julien Panis <jpanis@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 02/16] arm64: dts: ti: k3-am62a7: Add MIT license along
 with GPL-2.0
Message-ID: <20240111153349.GL5185@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-3-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110140903.4090946-3-nm@ti.com>

* Nishanth Menon <nm@ti.com> [700101 02:00]:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync with
> latest SPDX conventions (GPL-2.0 is deprecated).
> 
> While at this, update the TI copyright year to sync with current year to
> indicate license change (and add it at least for one file which was
> missing TI copyright).

Acked-by: Tony Lindgren <tony@atomide.com>

