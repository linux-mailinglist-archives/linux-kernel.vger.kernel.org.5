Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9DD80A62E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574226AbjLHOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574148AbjLHOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BDE1BFC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C992DC433CC;
        Fri,  8 Dec 2023 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047084;
        bh=WKUdBdk+yM5Rc2LPyObNzhOm/h1zc1q5RahCtrpAh/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ovvus9c0U3n2FNAtH0/zn3rOlU2WOL3H/YZPZGX3wd9VB53v+Jlq2Nhl2wY8vooiy
         ggj2CnDrgRi0mI2PVqR2poCk0NwFKiyri4p6dbRvslxeH6oDnzbMiMLgzEdRjEunOb
         FgNm4RE492HcHx7/63Lna4dTk6lFElF23dzvoUAg24sqtOpY23Bs1xZvS6TLeOZBBc
         szKq+umCfrbcqe1J+kOY6jqgYOSV06y3rb0JWP1RD/ImL8utd4sr6KenDYbH89UYoC
         RgAd/1z8sqq6yotPlGNpI7yws5JRcV6boCDCVaUvZ5Fv53eQznDMi1y4Q3UBua0LFu
         MQyXSd1D1jTJw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH v3] arm64: defconfig: Enable GCC, pinctrl and interconnect for SDX75
Date:   Fri,  8 Dec 2023 06:55:32 -0800
Message-ID: <170204733621.342318.8169147134821175341.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117055849.534671-1-quic_rohiagar@quicinc.com>
References: <20231117055849.534671-1-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 11:28:49 +0530, Rohit Agarwal wrote:
> Enable Global Clock controller, pinctrl and interconnect framework
> support for Qualcomm's SDX75 SoC which is required to boot to
> console on sdx75-idp platform.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable GCC, pinctrl and interconnect for SDX75
      commit: 3515c3172f66ad4b3f485862f858f76a3e49c659

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
