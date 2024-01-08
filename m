Return-Path: <linux-kernel+bounces-19028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870038266F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2078A1F216AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AD80C;
	Mon,  8 Jan 2024 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L+eT2zPn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F957E2;
	Mon,  8 Jan 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A585220003;
	Mon,  8 Jan 2024 00:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704674184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWUHIpnnXOCy7MEIpmVn7tCDq/taKDLq1rtjQGzgIRc=;
	b=L+eT2zPn52ThHxZzKpR2N6lsUZ1NUXaFcrRYEqMK/epWihc8U5wDHMmle7KTlgeW9QGo5R
	itn61P5vocwjxl47MofG2918BV2jrOx9Px2ELn9lBy/u9rPLHXCCG+It/VClWovWXzl/+I
	LRN3RoNJ3Gop0SSE5TmY51yvQEWXHoj8FnbcYeK8sIuGIk/xChAq4J3kmP3AhjDFpEVTN4
	3uQu0EqunNvcODjsk+TcdkFQZnqZJDwvUfoVU2XN0z4fCBGtygmhny8CFs7RAtE6Lml+uC
	r58PqfJM9QKqKQGxcbGUVu3UA7nUcnOowEJ2jzIK5svDM+a6SudvOdkbscM8zg==
Date: Mon, 8 Jan 2024 01:36:23 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: MAINTAINERS: drop Alessandro Zummo
Message-ID: <170467417414.600983.14691977636270985286.b4-ty@bootlin.com>
References: <20231211132600.101090-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132600.101090-1-krzysztof.kozlowski@linaro.org>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Mon, 11 Dec 2023 14:26:00 +0100, Krzysztof Kozlowski wrote:
> Last email from Alessandro was in 2016, so remove him from maintainers
> of the RTC subsystem.  Stale maintainer entries hide information whether
> subsystem needs help, has a bus-factor or is even orphaned.
> 
> 

Applied, thanks!

[1/1] rtc: MAINTAINERS: drop Alessandro Zummo
      commit: 54e1898e113dc65974103620bbe7a9f856f80f6e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

