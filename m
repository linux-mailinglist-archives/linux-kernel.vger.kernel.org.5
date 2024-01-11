Return-Path: <linux-kernel+bounces-23663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13082AFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F341C23DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752332C89;
	Thu, 11 Jan 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="PXp9WR1I"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369132C6C;
	Thu, 11 Jan 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id E5F6360886;
	Thu, 11 Jan 2024 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1704980177;
	bh=spHBxL0T5QVtiotbfLvZE1HJm4xym++up4FJ1+AM8Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXp9WR1IJaNA7vz2RuDozQvqvLgq7zTnpVcuAaScY0bVFj6h0+NyofXWt7JyrZzJg
	 Gc1yNTymzjDx+vLe+xAeoCLJkSddcYh4xDKcvm4Q1drH13Tb8GWYqAbNy5eTGt1Lwe
	 +AHfGVBC0UV21mhNhaEvrvGbk6TL55R9lMxvtckKY/46p7jjiqqMUpQYne7vpGpC7H
	 WC83Fe8tGhpEcoFq1Qr8FjRsTs9gzUDMBua4/NVjPaNxFItPuusTlj0/WEQFbJxqFn
	 ie0eos/S2tjFdbn44NzWVvZK7C9SHaP6HbeLLRzRqLf2ox0MGBhMAlA2ghpTiDCGE+
	 rYsZ7XcNn1SPw==
Date: Thu, 11 Jan 2024 15:35:50 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Esteban Blanc <eblanc@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 07/16] arm64: dts: ti: k3-j7200: Add MIT license along
 with GPL-2.0
Message-ID: <20240111133550.GF5185@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-8-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110140903.4090946-8-nm@ti.com>

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

