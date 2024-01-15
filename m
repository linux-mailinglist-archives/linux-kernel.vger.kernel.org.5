Return-Path: <linux-kernel+bounces-25598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988182D32D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70AB1F211F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A96186A;
	Mon, 15 Jan 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="bkLPxBjA"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D215BB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705286938; x=1707878938;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3/ACdTZKN4glzPwOsiLffRTMiq/cD9OoJCSWuTR7GA8=;
	b=bkLPxBjAsp6uHux0pvGfAgo2O5UWo4kfCGYB5jx8lDSHmKwKMqfkgIu72+13xRp/
	tqOiMyi+4Ih/HLCOFv+May221ETqctI8u6zV0bhQTrr5PXKINFoMuLrun6I3Qa61
	QWMZKSfdMUR5mfBp3evpNMNSAW8/PWbs2yHQUho6AK8=;
X-AuditID: ac14000a-fadff7000000290d-3f-65a49d1a1715
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BF.33.10509.A1D94A56; Mon, 15 Jan 2024 03:48:58 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 15 Jan
 2024 03:48:56 +0100
Message-ID: <343339e6-a3b9-4795-bbe3-e82e0c527529@phytec.de>
Date: Mon, 15 Jan 2024 03:48:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] arm64: dts: ti: phycore*: Clarify GPL-2.0 as
 GPL-2.0-only
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Garrett Giordano
	<ggiordano@phytec.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-16-nm@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240110140903.4090946-16-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWyRpKBR1dq7pJUgzU39S3W7D3HZDH/yDlW
	i/VbfrNZLP88m92i78VDZotNj6+xWlzeNYfN4s2Ps0wWrXuPsFv8P/uB3YHLY9OqTjaPO9f2
	sHlsXlLv8efiO1aP4ze2M3l83iQXwBbFZZOSmpNZllqkb5fAlXHy4032gvtMFb8f/GVrYFzE
	1MXIySEhYCLxdM0nti5GLg4hgcVMEhcedzBDOHcZJT52X2UGqeIVsJHouH6ODcRmEVCVmPa0
	lx0iLihxcuYTFhBbVEBe4v6tGWBxYYEwiV/z1oDFmQXEJW49mc8EMlRE4DWjRMO9LrB1zAJT
	GSWO378KViUkECHRefgI2AY2AXWJOxu+sYLYnAJGEjcaNzJBTLKQWPzmIDuELS+x/e0cZohe
	eYkXl5azQPwjLzHt3GtmCDtUYuuX7UwTGIVnITl2FpKjZiEZOwvJ2AWMLKsYhXIzk7NTizKz
	9QoyKktSk/VSUjcxgmJNhIFrB2PfHI9DjEwcjIcYJTiYlUR4Dz5fkCrEm5JYWZValB9fVJqT
	WnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomDU6qBcU2RErcyU2PkrIP1Xo9+mnaFzMhg
	W3NS6IGOd8ZZvo+uPU9SPx947cp6KL3y/k+jtOiH1a3rNGb9+Kk8Pa/w1PH0o89X/2J3iZ00
	4fdBrQkPT+vwtL57Ff/iZXJtdcJjFnuHq16zT6T4T8/0ULi3+n/rtwM71VN/cxkb3J9x+sLc
	E39P6ZXaViuxFGckGmoxFxUnAgCZZ1v9owIAAA==


Am 10.01.24 um 15:09 schrieb Nishanth Menon:
> SPDX identifier GPL-2.0 has been deprecated since license list version
> 3.0. Use GPL-2.0-only to be specific.
>
> Cc: Garrett Giordano <ggiordano@phytec.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>



