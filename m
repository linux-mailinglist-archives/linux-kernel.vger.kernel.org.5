Return-Path: <linux-kernel+bounces-9581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463381C7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7140B1C25068
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82115111BB;
	Fri, 22 Dec 2023 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdDR7GqQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E11171B;
	Fri, 22 Dec 2023 10:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB3DC433C8;
	Fri, 22 Dec 2023 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703239857;
	bh=PtfRni5YqYtTuUAHF7+Ii/Rg3HK/H67M5rIFDHSJDOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JdDR7GqQHpTsZfYKBmXqJUNy0sIgvcldcipE2UH90vHdK9Iqn6NqbM9HGIz98WuLt
	 a2doMCQ39qAAcnMfGktgxkQtCL5OLxlrBndl4YGBDECddhpRNXbNcmy7XltpONNswH
	 sEyuDgegUOIlMtH946wPiwHj1SEOP4w31PZek2tyQ1a/Co+l4rOvLNF2/GsKhjOqIB
	 ZZ5xBIqIvWzvURMyFRLQQb+ban6Ap/5GTFoEoveLzUVhXbXN+whoexnuIBg/OtZImp
	 WCgvpfd6TI3c4qyVoLewETjWE9R9WhLpELU6uUTbv8gyXtiAJQ/AHRf/kOAif6DPUR
	 bHklAbFb6YK9g==
Message-ID: <52ac755c-46f0-4dc5-b179-b31b660eca1f@kernel.org>
Date: Fri, 22 Dec 2023 12:10:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: cadence-torrent: Add optional
 input reference clock for PLL1
Content-Language: en-US
To: Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
 kishon@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: mparab@cadence.com, s-vadapalli@ti.com
References: <20231221162051.2131202-1-sjakhade@cadence.com>
 <20231221162051.2131202-2-sjakhade@cadence.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221162051.2131202-2-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 18:20, Swapnil Jakhade wrote:
> Add a new optional input reference clock (pll1_refclk) for PLL1.
> Update bindings to support dual reference clock multilink configurations.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

