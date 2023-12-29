Return-Path: <linux-kernel+bounces-13270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DE820247
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FBEB222DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E715493;
	Fri, 29 Dec 2023 22:55:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480D1548D;
	Fri, 29 Dec 2023 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rJLl8-0004VA-7k; Fri, 29 Dec 2023 23:55:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	John Clark <inindev@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	Thomas McKahan <tmckahan@singleboardsolutions.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: support poweroff on the rock-5b
Date: Fri, 29 Dec 2023 23:55:13 +0100
Message-Id: <170389050012.2630399.8754217298577818519.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225222859.17153-1-inindev@gmail.com>
References: <20231225222859.17153-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Dec 2023 22:28:19 +0000, John Clark wrote:
> Allow the rock-5b to poweroff its pmic. When issuing a "shutdown -h now"
> on the rock-5b it reboots instead. Defining 'system-power-controller'
> allows the rk806 to power down.
> 
> Commit c699fbfdfd54 ("arm64: dts: rockchip: Support poweroff on
> NanoPC-T6") similarly resolves this issue for the nanopc-t6.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: support poweroff on the rock-5b
      commit: 7738f551173540b3daa63a91b384b167eacd24fd
[2/2] arm64: dts: rockchip: correct gpio_pwrctrl1 typo
      commit: aed6514c4e3aee843385ded4c5ee0921b51c30fa

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

