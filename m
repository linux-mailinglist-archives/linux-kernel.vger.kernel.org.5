Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD797B967F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbjJDVdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244120AbjJDVdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:33:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E51D8;
        Wed,  4 Oct 2023 14:33:04 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qo9UE-0005RF-7v; Wed, 04 Oct 2023 23:32:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdio node to rock-5b
Date:   Wed,  4 Oct 2023 23:32:48 +0200
Message-Id: <169645508390.141514.13803865232611146322.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230924203740.65744-1-tszucs@protonmail.ch>
References: <20230924203740.65744-1-tszucs@protonmail.ch>
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

On Sun, 24 Sep 2023 20:37:45 +0000, Tamás Szűcs wrote:
> Enable SDIO on Radxa ROCK 5 Model B M.2 Key E. Add sdio node and alias as mmc2.
> Add regulator for the 3.3 V rail bringing it up during boot. Make sure EKEY_EN
> is muxed as GPIO.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add sdio node to rock-5b
      commit: 1c9a53ff7ece056eb995332f0d9523ca43fdcb5a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
