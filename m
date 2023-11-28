Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D827FB66F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjK1J6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjK1J6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:58:31 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5EDD;
        Tue, 28 Nov 2023 01:58:36 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7urS-0002r7-9R; Tue, 28 Nov 2023 10:58:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Fix sdmmc_pwren's pinmux setting for RK3128
Date:   Tue, 28 Nov 2023 10:58:32 +0100
Message-Id: <170116550668.2181556.6293208825750972058.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127184643.13314-2-knaerzche@gmail.com>
References: <20231127184643.13314-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 19:46:44 +0100, Alex Bee wrote:
> RK3128's reference design uses sdmmc_pwren pincontrol as GPIO - see [0].
> 
> Let's change it in the SoC DT as well.
> 
> [0] https://github.com/rockchip-linux/kernel/commit/8c62deaf6025
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: Fix sdmmc_pwren's pinmux setting for RK3128
      commit: 0c349b5001f8bdcead844484c15a0c4dfb341157

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
