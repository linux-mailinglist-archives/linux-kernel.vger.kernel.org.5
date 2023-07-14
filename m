Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8A753F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjGNPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjGNPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:39:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998530C5;
        Fri, 14 Jul 2023 08:39:28 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qKKt7-0004Kz-A3; Fri, 14 Jul 2023 17:39:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/4] RK3588 USB2 support
Date:   Fri, 14 Jul 2023 17:39:18 +0200
Message-Id: <168934909031.2268788.17295705108647249284.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712165106.65603-1-sebastian.reichel@collabora.com>
References: <20230712165106.65603-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 18:51:02 +0200, Sebastian Reichel wrote:
> This adds USB2 support to Rock 5A, 5B and the EVB1. The necessary USB2 PHY
> changes have been queued to the PHY tree and are available in linux-next.
> 
> -- Sebastian
> 
> Sebastian Reichel (4):
>   arm64: dts: rockchip: rk3588: add USB2 support
>   arm64: dts: rockchip: rk3588-evb1: add USB2
>   arm64: dts: rockchip: rk3588-rock5b: add USB2
>   arm64: dts: rockchip: rk3588s-rock5a: add USB2
> 
> [...]

Applied, thanks!

Adapted the patch subjects to "arm64: dts: rockchip: description in prose"

[1/4] arm64: dts: rockchip: rk3588: add USB2 support
      commit: a684cb416414fdd2b2a33e691119608c0e2eba9f
[2/4] arm64: dts: rockchip: rk3588-evb1: add USB2
      commit: e39da1074c20d4fb1114ccafe07a142df5345a53
[3/4] arm64: dts: rockchip: rk3588-rock5b: add USB2
      commit: 488fc7ad2bc8d980cc0599bc1be951938df8a779
[4/4] arm64: dts: rockchip: rk3588s-rock5a: add USB2
      commit: 1642bf66e270d8de7ba27068d1a5ecdbdba14d3b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
