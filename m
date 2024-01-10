Return-Path: <linux-kernel+bounces-22857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910382A408
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC71C222A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F234EB40;
	Wed, 10 Jan 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UDAebcMD"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F894D13F;
	Wed, 10 Jan 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AMav8t003608;
	Wed, 10 Jan 2024 16:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704926217;
	bh=JVXHGIOSU6hzsUeI0AuBXrAHp/rtmd5pOO9mdvCiweQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UDAebcMDIziq/O9qOajvmsHPxbC4TS6NEsuR4Sv++8CIGu9W0CFw6U1eqfcgwTSHU
	 BSs4p04FO1bkxD2NeCigieNO86aLvBaB7SsdZ1kL4j1w74DQazda79qMqO71IfQsO/
	 jK/XFF4b3u1U6csKl1tOQyrSGiR04Kfp9xaPMsk4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AMav5h107905
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 16:36:57 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 16:36:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 16:36:57 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AMavCr005709;
	Wed, 10 Jan 2024 16:36:57 -0600
Date: Wed, 10 Jan 2024 16:36:57 -0600
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Julien Panis <jpanis@baylibre.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/16] arm64: dts: ti: k3-am62a7: Add MIT license along
 with GPL-2.0
Message-ID: <20240110223657.pkochl4c5skf3w3h@amendment>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-3-nm@ti.com>
 <10e8c81f-0ebe-441e-b80b-9bf4df7ff782@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10e8c81f-0ebe-441e-b80b-9bf4df7ff782@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:41-20240110, Krzysztof Kozlowski wrote:
> On 10/01/2024 15:08, Nishanth Menon wrote:
> > Modify license to include dual licensing as GPL-2.0-only OR MIT
> > license for SoC and TI evm device tree files. This allows for Linux
> > kernel device tree to be used in other Operating System ecosystems
> > such as Zephyr or FreeBSD.
> > 
> > While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync with
> > latest SPDX conventions (GPL-2.0 is deprecated).
> > 
> > While at this, update the TI copyright year to sync with current year to
> > indicate license change (and add it at least for one file which was
> > missing TI copyright).
> > 
> > Cc: Julien Panis <jpanis@baylibre.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Cc: Pierre Gondois <pierre.gondois@arm.com>
> 
> I guess I am listed here due to some contributions, so copyrights. In
> such case, I agree for relicensing to "GPL-2.0-only OR MIT".
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you. And, yep, you are explicitly called out since you had one
or more patch modifying or adding content in the affected file.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

