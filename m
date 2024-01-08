Return-Path: <linux-kernel+bounces-19021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C98266D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71931F2153F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29587F0;
	Mon,  8 Jan 2024 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p79sIf65"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BE63A;
	Mon,  8 Jan 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D9A0FF803;
	Mon,  8 Jan 2024 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704672765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Px9dFz13q/M4X9qCBhJwOu5GOmESbBRvc13Vvi2V64E=;
	b=p79sIf65vCi7lmYqQB0wmg8r//MGh2ZP7EctS3bksQQVncUdD6wMzOOyI55cY6ce+M8EAS
	izC97F4iLQCS5nvTknQau3AhKHs8/jjeB5WK9CJd8I9FJW1zJngNjC3GrxTKHdS+iODyOv
	QidfwjzZNtlc3Qe70X3HYRLfcf3o0XJYe3AyGgJVPa+bwvhNg2qiXhJd49n49vqoQ1FB+i
	r8X9aFXZtZDYMJtgsF99SsmY02GjSNCi1BGmMrMHooa3O3L2mBLDrvvLHtthZTlzI+WBpZ
	zJoEvGrJCdcFaLkGc0swITb0VHy+vv9T31E2Iph3IzWRCEy07QIJceuXk11LWQ==
Date: Mon, 8 Jan 2024 01:12:44 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: a.zummo@towertech.it, Esteban Blanc <eblanc@baylibre.com>
Cc: andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, jpanis@baylibre.com,
	jneanne@baylibre.com, u-kumar1@ti.com
Subject: Re: [PATCH v9] rtc: tps6594: Add driver for TPS6594 RTC
Message-ID: <170467275118.561039.9311952663168331981.b4-ty@bootlin.com>
References: <20231107094701.2223486-1-eblanc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107094701.2223486-1-eblanc@baylibre.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Tue, 07 Nov 2023 10:47:01 +0100, Esteban Blanc wrote:
> TPS6594 PMIC is a MFD. This patch adds support for
> the RTC found inside TPS6594 family of PMIC.
> 
> Alarm is also supported.
> 
> 

Applied, thanks!

[1/1] rtc: tps6594: Add driver for TPS6594 RTC
      commit: 9f67c1e63976d3403f0b250b03ffe959c890f9db

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

