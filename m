Return-Path: <linux-kernel+bounces-25843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4304782D69B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1ED1F21FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFF101C6;
	Mon, 15 Jan 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ODTmhIPP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD733101D0;
	Mon, 15 Jan 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705312869; x=1736848869;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Xt0IXmjR2Cd0Vrc0T7IphTjyl7KfEuxpuS5teJhlSJI=;
  b=ODTmhIPPtkkZjfabUdVW52or9m1fXKGW98KR+M7mIMEe2u+kbe9doI8x
   IM19gQ0NhpELJutQiYuhPfC0Xxb48gXRV1XKa9C2CoTqBPDqh9r6Lv/mK
   4KMrmWxdfp7fNqkMo9CWYEfs61xxkiGXrZJZiNtpznOglWbi5a29BCOxz
   0N1/6Rbquw4P1UQpAMSja3/qGniLz01+zxVAIFxLCRki1J8ErTIg5O74L
   8nWt22tCgwrw4j6JggptmipXjQ41tLZjrmEKxyMFIBc1SdMRjRlcOamXy
   ZIur/O/UR9k84e1bWdxM0msaAvSqtjzqCw2Cv+oNHKMgMbcr9ayCaQZTp
   A==;
X-IronPort-AV: E=Sophos;i="6.04,196,1695679200"; 
   d="scan'208";a="34892422"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Jan 2024 11:01:02 +0100
Received: from [192.168.2.128] (SCHIFFERM-M2.tq-net.de [10.121.53.15])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E2CB1280075;
	Mon, 15 Jan 2024 11:01:01 +0100 (CET)
Message-ID: <ed8e91847dc0084536c13c13bbba810c42b7fb7f.camel@ew.tq-group.com>
Subject: Re: [PATCH 06/16] arm64: dts: ti: k3-am65: Add MIT license along
 with GPL-2.0
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, "Alexander A. Klimov"
 <grandmaster@al2klimov.de>, Jan Kiszka <jan.kiszka@siemens.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Pierre Gondois
 <pierre.gondois@arm.com>, Rob Herring <robh@kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 linux@ew.tq-group.com
Date: Mon, 15 Jan 2024 11:01:01 +0100
In-Reply-To: <20240110140903.4090946-7-nm@ti.com>
References: <20240110140903.4090946-1-nm@ti.com>
	 <20240110140903.4090946-7-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 08:08 -0600, Nishanth Menon wrote:
>=20
>=20
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
>=20
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>=20
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).
>=20

Acked-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

