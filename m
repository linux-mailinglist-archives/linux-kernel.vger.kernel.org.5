Return-Path: <linux-kernel+bounces-25600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE482D334
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED531F21365
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107A1872;
	Mon, 15 Jan 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="MpuVSsQc"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37717CB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705286622; x=1707878622;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wLo4oazoGisLjK7113rgUx/vmRZgsqMoCqX03N1V9Q0=;
	b=MpuVSsQcipF5Dxmkz30RmLUmuK4RN0DCp6otjKKVQntVDSo9ytsKHGSZ6BaIMMgj
	C5aQn6/o9uKi+AeZiAihxHAVo8IApr5s5W2YMkYaUCeIyAahjMqlXegiWNkk1tRw
	7GuQHBSwmUfGE1AQz4VhVbN0WBYbFWZeKWBisFitnmM=;
X-AuditID: ac14000a-fadff7000000290d-23-65a49bdda885
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8B.33.10509.DDB94A56; Mon, 15 Jan 2024 03:43:41 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 15 Jan
 2024 03:43:37 +0100
Message-ID: <b67b8d82-1a4c-470d-a252-26caa79a6813@phytec.de>
Date: Mon, 15 Jan 2024 03:43:29 +0100
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
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Christian Gmeiner
	<christian.gmeiner@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>, Pierre Gondois <pierre.gondois@arm.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-6-nm@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240110140903.4090946-6-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWyRpKBR/fu7CWpBhffm1lM2nOTyWLN3nNM
	FvOPnGO1WP55NrtF34uHzBZ7X29lt9j0+BqrxeVdc9gs3mz9wm7x5sdZJosHqzItWvceYbc4
	d28dq8X+K14W/89+YHfg91gzbw2jx7evk1g8Xkz4x+Sxc9Zddo9NqzrZPO5c28PmsXlJvcfx
	G9uZPD5vkgvgjOKySUnNySxLLdK3S+DK2L5vPmvBb5aK6VNmsjcw/mfuYuTkkBAwkXi/dhpb
	FyMXh5DAYiaJM/MmQjl3GSUWtC1nAqniFbCR+D7rMyuIzSKgKnH4/1RmiLigxMmZT1hAbFEB
	eYn7t2awg9jCAhESjTu7GUFsZgFxiVtP5jOBDBUReM0o0XCvC2wDs8A/Jolpz9+BTRISCJc4
	s30l2DY2AXWJOxu+gW3jFDCUOP56GSvEJAuJxW8OskPY8hLb386B6pWXeHFpOQvEP/IS0869
	hvotVGLrl+1MExiFZyE5dhaSo2YhGTsLydgFjCyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYLi
	VoSBawdj3xyPQ4xMHIyHGCU4mJVEeA8+X5AqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3Cq
	kEB6YklqdmpqQWoRTJaJg1OqgbFHmXvZ0eMv52z9Unb0gmcdc/DXqs7Pvbdlbc5NqAzbyHLq
	XGGVQe70Ig9WxV8RSwXkRXdazq4UaOPjUmi0eCrKU7wzzeY31+VfMS8zBPfMdjjJ8mvmku0i
	rk8OnRYQ8Ch86jLXn6WCQVQk+Mii1CfHJ1fP+zVl5caJzQEnfVVqevle/H3wsFCJpTgj0VCL
	uag4EQDK0mbiyQIAAA==


Am 10.01.24 um 15:08 schrieb Nishanth Menon:
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
Acked-by: Wadim Egorov <w.egorov@phytec.de>

