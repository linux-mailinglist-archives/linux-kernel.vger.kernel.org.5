Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B968099EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573031AbjLHCzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573135AbjLHCyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:54:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844001FE0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1021C433AB;
        Fri,  8 Dec 2023 02:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004028;
        bh=8ejV7rvgx5iy4VrzUUT9YBaxO5og4KrJug7co7fnkoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AovYcxr1jgM/1TXdlnmHUv3g95XJ2qCJQ5wTON4XmJIZwFNrr580xPARQ50SFDdyr
         IITl3QxPdE8d2hZM5D2uL9pknL1FvrmSjtmGcL+C+nMJyAKlf/GR+p7Sg2pf/uFQOO
         fIWxm1p7t2djsoY/6md6ohg01FcWwPFCqjf5VJpnmnmahK48Cl55WXb8+Y47ZTMt7x
         a9gEXHZzb8TwOi00ntfmytPyofngj5MnVJXMVLCOfOr4zVsen5py3xClGaEHnbjzIT
         8dTZ6z0X+Lol8kyo4IH3L9DmmcO9ca/twwenHZQreISZGoxxCeVRjwt7vHZxz4bQk+
         pVfY+MC+lccNA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin
Date:   Thu,  7 Dec 2023 18:57:52 -0800
Message-ID: <170200426916.2871025.17053214284778900352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120503.28917-1-quic_shazhuss@quicinc.com>
References: <20231107120503.28917-1-quic_shazhuss@quicinc.com>
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


On Tue, 07 Nov 2023 17:35:02 +0530, Shazad Hussain wrote:
> The volume down key is controlled by PMIC via the PON hardware on
> sa8775p platform, so enable the same for sa8775p-ride.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin
      commit: 81c8ec77b86fde629d5beea1ebe42caeea57c5a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
