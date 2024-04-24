Return-Path: <linux-kernel+bounces-157736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA968B1530
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0779B23C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9332B156C7C;
	Wed, 24 Apr 2024 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpUWswzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F213C9DE;
	Wed, 24 Apr 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994055; cv=none; b=GgQWeZ4R4XuQaCxVXNDjIO5EX49N2a60UwzlHKzK3P6jTb415F4ZclABGuPINcW2mPEQdHbDux8K+ex9l+vCCzeubEsK3+8+1SiCTuMm+So5WmYI19bxf4YXIqrHqOQzaL+9+/jPtGxRGzBhr9xLBgEA1A4XjaHSkyMdMVJ9Vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994055; c=relaxed/simple;
	bh=5qDeNhUl7hu1UuFrNpFykYzE4eUnCxFNxtypTL36l+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b02iBjuH/aawHR8KEq3ID7i55S5A+qyPpDUf8uU+L5xCrZsirvlm9kN03WnXC/ZzdjXwg1kqALrSnZVTTR8VjEvdtFZk0AcHsrL0b7E/Z/MnSAlgh8kkf+QVgrMHDle8o+Ss5TjS8ABieK8J9mmgNBwn42OuT1e3xbmSVblUBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpUWswzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ED4C113CD;
	Wed, 24 Apr 2024 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713994055;
	bh=5qDeNhUl7hu1UuFrNpFykYzE4eUnCxFNxtypTL36l+8=;
	h=From:To:Cc:Subject:Date:From;
	b=bpUWswzSlP3KQO5+WvuoDNFZDKHgXScGBlkPG6FaQw8uFZlTWOQodLhRvyePJCnMP
	 iY7v1gbSljtDJ1Xpzkqqx95ZeA8cYpqISH1lsFdxXGy0tr2kzX4UqyUB9Rb6BxAdgR
	 vzjSDENNvY44L+J4dK2+1EpMtfkP9qZOWadbXKGHnx0KlSFuCG3C59OZDkWti8OFAd
	 JhLwLyuts43JnEQb90eqHmD87VRt5/bsVqleqJf7fCrisiHDf0ve/OSNP1GS1jKJEG
	 I/bLshgCMDjFlqJhR9SysOuBAzhWvWXkl7CItE0pVHHsKGVBayOBFtpKgnInG/Ya1Z
	 wv696jJs79j+A==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org,
	Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] MAINTAINERS: Update Uwe's email address, drop SIOX maintenance
Date: Wed, 24 Apr 2024 23:26:27 +0200
Message-ID: <20240424212626.603631-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314; i=ukleinek@kernel.org; h=from:subject; bh=5qDeNhUl7hu1UuFrNpFykYzE4eUnCxFNxtypTL36l+8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmKXkDbN8lePWydIQFj9vaM9A38pHvDJtiZ9kU1 J57js+Gf3CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZil5AwAKCRCPgPtYfRL+ TmUqCACAAOsYQ9b7bHmlzys0OLeeFHVbpYFZ2Ff+hhkpFqa60Mq4fh4f6/drC5Rinpt/9W8oT0j U8/0BwEP91Ccy0rnH6S6v0oBzgF0kaJ4Jm98cfNQG6RN/H47SgYP6HozhttKVhvNByLR3O6hFLe hmMTod50Wt9UbdiW7kroBAyyBRrdDOA82MnLasOHRavW1tVheoAaKacuNxQg7N6WymNwTgTEACG PavX6srLz5bMmDAovt2jh+ZclbCIsEpfSU/uVmebblHpvpnse+zY61rxjnjSAJDr25FR9K2MeDj wz/CoJ/mT3lMFVhBYzXi7kwobU07Nn7AMgguKEs1ZdE9iQ29
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

In the context of changing my career path, my Pengutronix email address
will soon stop to be available to me. Update the PWM maintainer entry to
my kernel.org identity.

I drop my co-maintenance of SIOX. Thorsten will continue to care for
it with the support of the Pengutronix kernel team.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..85a32423e9ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17873,7 +17873,7 @@ F:	Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
 F:	drivers/media/rc/pwm-ir-tx.c
 
 PWM SUBSYSTEM
-M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+M:	Uwe Kleine-König <ukleinek@kernel.org>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
@@ -20177,7 +20177,6 @@ F:	include/linux/platform_data/simplefb.h
 
 SIOX
 M:	Thorsten Scherer <t.scherer@eckelmann.de>
-M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 S:	Supported
 F:	drivers/gpio/gpio-siox.c

base-commit: ed30a4a51bb196781c8058073ea720133a65596f
-- 
2.43.0


