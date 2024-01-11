Return-Path: <linux-kernel+bounces-23669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F058782AFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D013E1C23EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1F1863C;
	Thu, 11 Jan 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="OBs/sj+i"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC76360AC;
	Thu, 11 Jan 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id CD56860886;
	Thu, 11 Jan 2024 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1704980373;
	bh=egH89NjeTEJBwgPMsgZRVLzqM12O/ohFmP06rB4C9qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBs/sj+i4H21uiA61E3+jyhQuE14JZKIK1+NHxitX3e9lHSBnPBok7cr9yiuRvr3b
	 m57O60ffSE3uYAx5vnFd1+uGtxDwj+Yu3IxB8732nU+DiKZyw6Iso54eVWeCVgbUjG
	 z6a3lKat3QbP9emgz49E+7OsAkWXvXGRAJcGJPPppjfuSmHqGthQ23A592s6EW6bjD
	 CaM9PMwwuBIY8txxpKVf/domze9ig21QHqhWJ3dgkf/Rw8QkOv8LumDaiE2jPsf4oS
	 r5hn7K4zFcwDxsuVXnP8bWs+I7/YGDAmOWu+HdM0/SsAAlh/LV9MkR0+Tjo/sUdC//
	 cP370CXuKasqg==
Date: Thu, 11 Jan 2024 15:38:59 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Chao Zeng <chao.zeng@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Le Jin <le.jin@siemens.com>
Subject: Re: [PATCH 14/16] arm64: dts: ti: iot2050*: Clarify GPL-2.0 as
 GPL-2.0-only
Message-ID: <20240111133859.GJ5185@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-15-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110140903.4090946-15-nm@ti.com>

* Nishanth Menon <nm@ti.com> [700101 02:00]:
> SPDX identifier GPL-2.0 has been deprecated since license list version
> 3.0. Use GPL-2.0-only to be specific.

Acked-by: Tony Lindgren <tony@atomide.com>

