Return-Path: <linux-kernel+bounces-25597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85482D32A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C52A1F2138A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BFD17F6;
	Mon, 15 Jan 2024 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="LjeDWsdk"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD0620
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705286883; x=1707878883;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6IGzgS0ICYFwJ5dv9FeUfWnrMgmXR+9RqwebzivweOE=;
	b=LjeDWsdkyySHwkI1PUP4wSt4S/v9DwSlN93ECd+5OukCvzljq1wZNSbX+/EZGtY9
	GaPvA7fSTgDkHhgdXu24BwG+/t587z7lkKC3aVZiyZUGflVTP+8N63H45uKRXEoT
	TWkWZqdhs1Sa3IOrJUO4T32+wWAzRadNK71QeoZf9So=;
X-AuditID: ac14000a-fbefe7000000290d-36-65a49ce3d05c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2E.33.10509.3EC94A56; Mon, 15 Jan 2024 03:48:03 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 15 Jan
 2024 03:47:59 +0100
Message-ID: <325ab287-85ea-4749-986d-4af020a06ae1@phytec.de>
Date: Mon, 15 Jan 2024 03:47:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] arm64: dts: ti: beagle*: Add MIT license along with
 GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ayush Singh
	<ayushdevel1325@gmail.com>, Jason Kridner <jkridner@beagleboard.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Robert Nelson
	<robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-14-nm@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240110140903.4090946-14-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWyRpKBR/fxnCWpBi/W8VjsXMZhsWbvOSaL
	+UfOsVoc3X6K3WL559nsFn0vHjJb7H29ld1i0+NrrBaXd81hs3jz4yyTxfslHxktWvceYbfY
	f8XL4v/ZD+wOfB7fvk5i8Xj3exmjx85Zd9k9Nq3qZPO4c20Pm8fmJfUex29sZ/L4vEkugCOK
	yyYlNSezLLVI3y6BK6Ox6RN7wSL2iufLPjA2MLawdTFyckgImEh8v3iCvYuRi0NIYDGTxKqJ
	b9kgnLuMEntmv2QGqeIVsJG43/abFcRmEVCVONDwByouKHFy5hMWEFtUQF7i/q0Z7CC2sECE
	xPYNzWA2s4C4xK0n85lAhooIvGaUaLjXxQaROMwkcWdGXRcjB9C2CIm+eQIgYTYBdYk7G76B
	7eIUMJJonXaVGaLcQmLxm4NQM+Ultr+dAxYXArJfXFrOAvGNvMS0c6+ZIexQia1ftjNNYBSe
	heTUWUhOmoVk7CwkYxcwsqxiFMrNTM5OLcrM1ivIqCxJTdZLSd3ECIpPEQauHYx9czwOMTJx
	MB5ilOBgVhLhPfh8QaoQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUw
	WSYOTqkGxt78S+3qW+r/zZaL3F5or7Hm4KONKeeXVT7L2ZOuE+/9baLmu/Vp6Q8mtR8SWzhZ
	z2Px17g1rX02s1fHqOmvD3/NzZ4tPs+QtebT7DkTbXfVXF/wev68jCVqYeYbqn/Fnvzhp/Qj
	Pur+9uzO1NVzfWZ9zrud/X15IVe4quucxY9e6wQ6zpe9p6/EUpyRaKjFXFScCAD3RuJhvQIA
	AA==


Am 10.01.24 um 15:09 schrieb Nishanth Menon:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for device trees belonging to BeagleBoard.org Foundation
> platforms. This allows for Linux kernel device tree to be used in
> other Operating System ecosystems such as Zephyr or FreeBSD.
>
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>
> While at this, update the copyright year to sync with current year
> to indicate license change.
>
> Cc: Ayush Singh <ayushdevel1325@gmail.com>
> Cc: Jason Kridner <jkridner@beagleboard.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>


