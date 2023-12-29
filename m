Return-Path: <linux-kernel+bounces-13268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBD1820243
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98092283C64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69414F7C;
	Fri, 29 Dec 2023 22:55:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D914AA1;
	Fri, 29 Dec 2023 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rJLl7-0004VA-E2; Fri, 29 Dec 2023 23:55:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	lasstp5011@gmail.com,
	linux-kernel@vger.kernel.org,
	zhangn1985@outlook.com,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix led pinctrl of lubancat 1
Date: Fri, 29 Dec 2023 23:55:11 +0100
Message-Id: <170389050013.2630399.12594636943647142051.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225005055.3102743-1-andyshrk@163.com>
References: <20231225005055.3102743-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Dec 2023 08:50:55 +0800, Andy Yan wrote:
> According to the sch, the gpio control sys_led
> is GPIO0_C5.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix led pinctrl of lubancat 1
      commit: 8586a5d217ef7bfeee24943c600a8a7890d6f477

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

