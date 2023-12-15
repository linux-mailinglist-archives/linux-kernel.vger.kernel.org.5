Return-Path: <linux-kernel+bounces-1658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C98151A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E7328670D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1D482C3;
	Fri, 15 Dec 2023 21:10:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35247792;
	Fri, 15 Dec 2023 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rEFS3-0005kk-7s; Fri, 15 Dec 2023 22:10:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: conor+dt@kernel.org,
	quentin.schulz@theobroma-systems.com,
	robh+dt@kernel.org,
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
	krzysztof.kozlowski+dt@linaro.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: fix misleading comment in rk3399-puma-haikou.dts
Date: Fri, 15 Dec 2023 22:10:28 +0100
Message-Id: <170267443961.1167098.4412754848079382518.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214122801.3144180-1-vahe.grigoryan@theobroma-systems.com>
References: <20231214122801.3144180-1-vahe.grigoryan@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Dec 2023 13:27:59 +0100, Vahe Grigoryan wrote:
> Haikou is an evaluation and development platform for System on
> Modules (SOMs).
> 
> The GPIO0_B1 is routed to the Wake button instead of BIOS_DISABLE,
> update the comment to reflect that.
> 
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: fix misleading comment in rk3399-puma-haikou.dts
      commit: 9050aefab15b2da2c7d65d794ca445919ae4c235
[2/3] arm64: dts: rockchip: expose BIOS Disable feedback pin on rk3399-puma
      commit: 39d95566231d483a1c89e74cbcadc4394bfd53ef
[3/3] arm64: dts: rockchip: make Haikou buttons compatible with "gpio-keys"
      commit: 4a8cd5cb583b99b06d2f3e2acb38c5957dd4e92e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

