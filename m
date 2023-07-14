Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC94753F20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjGNPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjGNPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:39:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCA12D7B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:39:30 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qKKt6-0004Kz-DV; Fri, 14 Jul 2023 17:39:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH RESEND] arm64: defconfig: Enable Rockchip OTP memory driver
Date:   Fri, 14 Jul 2023 17:39:16 +0200
Message-Id: <168934909035.2268788.9745451471454977135.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710190107.32451-1-cristian.ciocaltea@collabora.com>
References: <20230710190107.32451-1-cristian.ciocaltea@collabora.com>
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

On Mon, 10 Jul 2023 22:01:07 +0300, Cristian Ciocaltea wrote:
> The Rockchip one-time programmable memory driver provides access to
> various SoC specific information, e.g. leakage currents of the
> CPU/GPU/NPU components found on a RK3588 SoC.
> 
> Enable the driver as built-in to allow client device drivers (e.g.
> cpufreq) to access the required data for proper settings adjustment.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Enable Rockchip OTP memory driver
      commit: 3526df3faf21b66904c47cc8814c177a890343b6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
