Return-Path: <linux-kernel+bounces-10815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1AA81DC39
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905AF1F20E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31B10A23;
	Sun, 24 Dec 2023 19:54:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110CEAE8;
	Sun, 24 Dec 2023 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193c.versanet.de ([94.134.25.60] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rHUYj-0006HY-Hb; Sun, 24 Dec 2023 20:54:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	zhengxing@rock-chips.com
Subject: Re: (subset) [PATCH v2 0/3] Fix mainline support for rk3036 kylin board
Date: Sun, 24 Dec 2023 20:54:44 +0100
Message-Id: <170344745821.2405994.10562040784600617888.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218105523.2478315-1-andyshrk@163.com>
References: <20231218105523.2478315-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 18:55:20 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> 
> When I want to test some patch of inno hdmi driver on
> mainline, I found the support of rk3036 kylin board
> was broken by somehow:
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: rockchip: Add stdout-path for rk3036 kylin
      commit: 1df4bc6908b2739f7ff28a1775729730d1addf16
[3/3] ARM: dts: rockchip: Remove rockchip,default-sample-phase from rk3036.dtsi
      commit: bb0b255fb6f14b1620566d7d32c43adaca09c5e5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

