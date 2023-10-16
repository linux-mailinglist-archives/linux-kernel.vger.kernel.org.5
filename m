Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969817CB459
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjJPUNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjJPUMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:12:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF55F7;
        Mon, 16 Oct 2023 13:12:43 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qsTwv-0000QB-N5; Mon, 16 Oct 2023 22:12:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        linux-rockchip@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESEND] arm64: dts: rockchip: Enable UART6 on rock-5b
Date:   Mon, 16 Oct 2023 22:12:21 +0200
Message-Id: <169748713685.982818.10370710928002239372.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013215208.81345-1-szucst@iit.uni-miskolc.hu>
References: <20231013215208.81345-1-szucst@iit.uni-miskolc.hu>
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

On Fri, 13 Oct 2023 23:51:53 +0200, Tamás Szűcs wrote:
> Enable UART lines on Radxa ROCK 5 Model B M.2 Key E.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable UART6 on rock-5b
      commit: a6169ab369236f15c79b45037074a2567d30b037

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
