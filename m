Return-Path: <linux-kernel+bounces-13267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E0820241
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B432B21214
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5114AB0;
	Fri, 29 Dec 2023 22:55:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A514A9F;
	Fri, 29 Dec 2023 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rJLl8-0004VA-O8; Fri, 29 Dec 2023 23:55:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	John Clark <inindev@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas McKahan <tmckahan@singleboardsolutions.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: correct gpio_pwrctrl1 typo
Date: Fri, 29 Dec 2023 23:55:14 +0100
Message-Id: <170389050012.2630399.15117069356427722375.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225223226.17690-1-inindev@gmail.com>
References: <20231225223226.17690-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Dec 2023 22:32:16 +0000, John Clark wrote:
> Both rk806_dvs1_null and rk806_dvs2_null duplicate gpio_pwrctrl2 and
> gpio_pwrctrl1 is not set. This patch sets gpio_pwrctrl1.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: correct gpio_pwrctrl1 typo
      commit: 24559788384916041a0bbf54c32e2a16b612d247

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

