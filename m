Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781E7B967E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbjJDVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbjJDVc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:32:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75E9E;
        Wed,  4 Oct 2023 14:32:55 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qo9UD-0005RF-Gf; Wed, 04 Oct 2023 23:32:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] RK3588 Rock 5B PCIe support
Date:   Wed,  4 Oct 2023 23:32:47 +0200
Message-Id: <169645508389.141514.2717578509168602867.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918141451.131247-1-sebastian.reichel@collabora.com>
References: <20230918141451.131247-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 16:14:48 +0200, Sebastian Reichel wrote:
> This enables PCIe network card and PCIe for both M.2 ports the Rock 5B has.
> 
> -- Sebastian
> 
> Sebastian Reichel (3):
>   arm64: dts: rockchip: rock-5b: add PCIe network controller
>   arm64: dts: rockchip: rock-5b: add PCIe for M.2 M-key
>   arm64: dts: rockchip: rock-5b: add PCIe for M.2 E-Key
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: rock-5b: add PCIe network controller
      commit: 42145b7a823530f57983fb6e6897f40c0be278d5
[2/3] arm64: dts: rockchip: rock-5b: add PCIe for M.2 M-key
      commit: 199cbd5f195adbc0e70ad218cdba82f45750f11b
[3/3] arm64: dts: rockchip: rock-5b: add PCIe for M.2 E-Key
      commit: da447ec387800bdf2df1fb1d8c1522991d025952

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
