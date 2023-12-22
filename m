Return-Path: <linux-kernel+bounces-9582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63081C7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E68BB2425F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2614F97;
	Fri, 22 Dec 2023 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXVo4EVE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD414F92;
	Fri, 22 Dec 2023 10:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA3C433C7;
	Fri, 22 Dec 2023 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703239870;
	bh=38EFpr8oyysrP+F7Eh7r7rlQthLAXJIPPK1bZ/BXvP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KXVo4EVEAQ5O0N9PoEXy1EySRHNNNSc2UdCX2KLWmUNDsg28T/3Tq8ISbBsppSlNx
	 MFU5fud6j2oGVQaO5BtLqmbX5rN1kii/m2KEq0JrZvnKybzwmI6GpbztwR0lQgHTb5
	 G6ZSsRyQkXgaJ0e7ePpgb1gyjpjuB0/tTtkaBkGW//am3H1TAWVxoVRp82Xe7afSxR
	 DdF8GxQsD+sNZHO+/umoSyTEFDh1haHz5I4JWCm2X8VaUobJ0SO9t4Pf+iBmDOGnyD
	 YDdWpmomeZV41Goy+8ktyzkFMgpG4k0RiQe0XkPQWEctgx8Kpzs9Gm9OdC4E+lq8jq
	 gAXxQjnpE8nBw==
Message-ID: <b8a10bb4-8ff6-499e-874c-edff1bcaa3d3@kernel.org>
Date: Fri, 22 Dec 2023 12:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] phy: cadence-torrent: Add USXGMII(156.25MHz) +
 SGMII/QSGMII(100MHz) multilink configuration
Content-Language: en-US
To: Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
 kishon@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: mparab@cadence.com, s-vadapalli@ti.com
References: <20231221162051.2131202-1-sjakhade@cadence.com>
 <20231221162051.2131202-4-sjakhade@cadence.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221162051.2131202-4-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 18:20, Swapnil Jakhade wrote:
> Add register sequences for USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
> multilink configuration. USXGMII uses PLL0 and SGMII/QSGMII uses PLL1.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

