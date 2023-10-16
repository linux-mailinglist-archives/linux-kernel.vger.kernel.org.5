Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF45C7CB45A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjJPUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjJPUMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:12:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634F83;
        Mon, 16 Oct 2023 13:12:43 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qsTww-0000QB-3r; Mon, 16 Oct 2023 22:12:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Conor Dooley <conor+dt@kernel.org>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Anand Moon <linux.amoon@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Shengyu Qu <wiagn233@outlook.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing sdmmc2 SDR rates to rock-3a
Date:   Mon, 16 Oct 2023 22:12:22 +0200
Message-Id: <169748713690.982818.6918031179658746694.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011191448.58936-1-tszucs@protonmail.ch>
References: <20231011191448.58936-1-tszucs@protonmail.ch>
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

On Wed, 11 Oct 2023 19:14:56 +0000, Tamás Szűcs wrote:
> Add missing UHS-I SDR rates to sdmmc2. Add explicit alias as mmc2 while at it.
> It would be good to have matching timings enabled in case slower SDIO devices
> are encountered.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add missing sdmmc2 SDR rates to rock-3a
      commit: 0597d85859e48c4366862a6252479698590ae39c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
