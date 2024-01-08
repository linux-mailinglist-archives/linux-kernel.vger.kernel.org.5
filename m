Return-Path: <linux-kernel+bounces-19025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F057B8266E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2EFB2116A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB5800;
	Mon,  8 Jan 2024 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J4WBT3G4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0E7F;
	Mon,  8 Jan 2024 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D846E60002;
	Mon,  8 Jan 2024 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704673874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dto/bWhs/sy1ZLVrTCv5QPyfAibsiNS+5JR94Vc5Hj0=;
	b=J4WBT3G4sSdTYQtmmnIauHrc7nEq33rDPcc7+U27amL1+rykWZjkG9j60u9EECgxRg3W0y
	cStZyR7T3Ho7FAhR74eEKzAuOJ5TwLFM2tmfA1l7z5/laQU9ijCnsNict5SIrIVeUuuafQ
	xVcPIQCEGHTJZx2z9/jMzkh0+N3mqiKlRnAD9804PiSNb/eBa5nmh0Np3vzEAYb1OC1Z6B
	hjiSRqXvExEtQAzFNSf5N3kkN2BO7g2mujHz2bqRH3gLoTxZEORZCehmlyepKAbxRa0xkJ
	IgHM20mY0R1ctz643BwPHtymHP1sJ7juzhd7bJ44rx7qsVgMzE1w8Pzr0nXIIQ==
Date: Mon, 8 Jan 2024 01:31:13 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH] rtc: Kconfig: add missing dependency for lpc24xx
Message-ID: <170467384894.599798.14903275349476242338.b4-ty@bootlin.com>
References: <20231114114532.37840-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114114532.37840-1-antoniu.miclaus@analog.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Tue, 14 Nov 2023 13:45:31 +0200, Antoniu Miclaus wrote:
> The driver depends on COMMON_CLK. Add the dependency in Kconfig.
> 
> 

Applied, thanks!

[1/1] rtc: Kconfig: add missing dependency for lpc24xx
      commit: cd0d7d6639de4468d181c87e45cfd07d51b525da

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

