Return-Path: <linux-kernel+bounces-16170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0005823A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D9FB2479B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065C1859;
	Thu,  4 Jan 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BPEFJ8XS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF15BA;
	Thu,  4 Jan 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5c0gTT2C/K0a4EyZuOveApDxmqOBRFOhzAaZQ8tjhNk=; b=BPEFJ8XSdcpuWkPvwBqHdPTmYM
	Y8fuXVczty/9bCb0SFISaSlngK52MUlz2mMZ73mMYNa6mUjKHdHaTAmyCv6JnYGnxJbF0FhNflcfc
	VemaHu50rD4B6aX08g6abjLvxJD21yelm51i3QAiTs5Vs2eZ3YCZBba33KkqgdDc+ru69et42IAxC
	bc9qpueJYkcGedud/3GAWkwd17KCpKaKukBRyrxnDnqxb1y6nwUDM++g2YThWSJi+26u+3/QgC43N
	nXM3civJPnIwFl28wmyM2M623gENhtE/xAsCi7rnnRqJ5ipNrXcoEduBrCmBuW2pDGSQlFVvzk60A
	32O5bxKA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLC7T-00CXfq-1a;
	Thu, 04 Jan 2024 01:01:59 +0000
Message-ID: <add225ca-40c2-479a-8e3d-75c1b3742918@infradead.org>
Date: Wed, 3 Jan 2024 17:01:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-5-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-5-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/arm64/boot/dts".  Only touches
> comments, no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi                 | 2 +-
>  arch/arm64/boot/dts/apm/apm-storm.dtsi                     | 2 +-
>  arch/arm64/boot/dts/exynos/exynos7.dtsi                    | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi             | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts        | 2 +-
>  arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi           | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                 | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi      | 2 +-
>  arch/arm64/boot/dts/renesas/draak.dtsi                     | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts        | 2 +-
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                 | 2 +-
>  16 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

