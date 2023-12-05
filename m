Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D852804313
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbjLEAGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjLEAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:06:06 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C8FF;
        Mon,  4 Dec 2023 16:06:10 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rAIws-0001qb-Vk; Tue, 05 Dec 2023 01:06:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Bee <knaerzche@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Move core bus and gpio aliases to SoC dtsi for RK3128
Date:   Tue,  5 Dec 2023 01:05:58 +0100
Message-Id: <170173468934.501889.12474504620278418598.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231202130506.66738-2-knaerzche@gmail.com>
References: <20231202130506.66738-2-knaerzche@gmail.com>
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

On Sat, 2 Dec 2023 14:05:04 +0100, Alex Bee wrote:
> Following up the recent discussion [0] about where aliases can be/should be
> placed this series moves gpio, i2c and uart aliases to SoC dtsi for RK3128.
> 
> Note: This patches are based on maintainter's repo.
> 
> [0] https://lore.kernel.org/all/b0c637f5-5abf-420b-8b02-839eba68799e@linaro.org/T/#m94aebb23a29b015d94b250a70b675febdaa902ea
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: rockchip: Move gpio aliases to SoC dtsi for RK3128
      commit: 3b0422a4ce59d8afb84bd7516bf71a3c1caa7925
[2/3] ARM: dts: rockchip: Move i2c aliases to SoC dtsi for RK3128
      commit: 39732a49803cf271454416341549df09c4a2fd2f

I also applied patch 3 ... though had to pick it manually from the list
as the subject was a bit garbled (missing 3/3), so b4 did not pick it up.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
