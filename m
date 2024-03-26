Return-Path: <linux-kernel+bounces-119834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1288CD84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3141F657AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9313D265;
	Tue, 26 Mar 2024 19:50:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97AC481A3;
	Tue, 26 Mar 2024 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482647; cv=none; b=hIktX3u5OnYZFKgXqDFGODdiGjxOyHoKTPI1dH+Qe2yVwaaASXHnPhXbtM5aNU04HDH1JX2iG9PzvB0qXJaRkSVSPWkSfegXdQi2TuUNnBNjpw1QwEUwR/qA7/bgcJUFu+vAXTUXgXLWMtjobbkcHWsPCvdF+93+9da1aRqgLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482647; c=relaxed/simple;
	bh=XRcq/1cksuuvSYm4vHPltyWGHRgID/IZs13ihrRwWVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9gvrHxs7yRk019RrEvSjFch/HhYU8SC75GNFsTAy1Ogfv0mwVaSW4E1wMEBK96TOlOm55//s9mHD7k0TyyTK69V+oCXpOT/BxGrIp4HWCvYxeOq27imi1k0mJk4ouP29b+gxN53jIh4hODp+duYGRMpxDOtSFTM2uR3LLcR0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECBFC433F1;
	Tue, 26 Mar 2024 19:50:47 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 409A110608D9; Tue, 26 Mar 2024 20:50:44 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
Subject: Re: [PATCH v3] power: supply: test-power: implement
 charge_behaviour property
Message-Id: <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
Date: Tue, 26 Mar 2024 20:50:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Wed, 06 Mar 2024 20:37:04 +0100, Thomas Weißschuh wrote:
> To validate the special formatting of the "charge_behaviour" sysfs
> property add it to the example driver.
> 
> 

Applied, thanks!

[1/1] power: supply: test-power: implement charge_behaviour property
      commit: 070c1470ae24317e7b19bd3882b300b6d69922a4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


