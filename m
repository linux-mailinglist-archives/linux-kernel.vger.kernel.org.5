Return-Path: <linux-kernel+bounces-3170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B65816833
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0BEB21586
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EBD1094B;
	Mon, 18 Dec 2023 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="LfSlr3G4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE610944;
	Mon, 18 Dec 2023 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9C0776035A;
	Mon, 18 Dec 2023 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702888648;
	bh=EnCtbfIqMQGfV1w9byjITvfpC3JCrZZNFBn8GxNkw2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfSlr3G40PsbFZ74H0NtLN+drgjS3DlBAhgjHT6d78gYYYe992slO+rLwCX3EsyT3
	 LlqH1gg1BVqH1FUeF/+1LqkaCXQID6FBsZORS5pxi6FZFci+Wvvhej+FVEHzXKUpdE
	 oGv35VekyBWbO/3Xkkez6M8BWHCs8xvmxJZ1eFH7n1tK/6yLL7wRatUNCMWzk+SKeL
	 xPcgpbd1Hbil93Ghod0GHxTFItM4On9BpBB5IInoUrxJTMTr5HP7eWGuMCa6rmHNfJ
	 s5ljKkBqDiTlodz8WG2aAirQ+/R2scaUC2WvjX9MmG66b/XtFnd/i5AISTSBCx4csI
	 W6M1AI9TdwK2A==
Date: Mon, 18 Dec 2023 10:37:13 +0200
From: Tony Lindgren <tony@atomide.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	kernel@pengutronix.de, Roger Quadros <rogerq@kernel.org>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] memory: omap-gpmc: Convert to platform remove
 callback returning void
Message-ID: <20231218083713.GY5169@atomide.com>
References: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
 <019d9dc31af9b30a6b675fec219e64b667475efd.1702822744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <019d9dc31af9b30a6b675fec219e64b667475efd.1702822744.git.u.kleine-koenig@pengutronix.de>

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [231217 14:30]:
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Reviewed-by: Tony Lindgren <tony@atomide.com>

