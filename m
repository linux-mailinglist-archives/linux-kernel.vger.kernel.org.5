Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAA7A968F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjIURDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjIURDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:03:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD31739;
        Thu, 21 Sep 2023 10:01:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC5C4E765;
        Thu, 21 Sep 2023 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306563;
        bh=5pqxliWwkemKk42Pc3VBjDLFEFWsPXjl1Fd5EvGj9lc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kp86v85AlW0PiTRcSowcXwNk+7N/m+mCEpy3HLzKWDLLQYRSzsde5Zw4a4N+sEshx
         yMueOYJrdz2sVQXSPzcQCiwU3RpObeX3NW78bU3k6gsZLF1Shle89Vis62tra2pMiu
         XgKP3f9aoWBhGxMzSv7z9RR1Rc27VR++yRbVo9d0wr2ZfBxOtmTPTTCYW9Sr0EnNjW
         qWCwEw5y+GiOSizlEepHCKPD+kFD1y2QtfSyprxM81xaQb0Yvvfgwy4xglkyej8pav
         kNJrt8Dl4gETkWSxyle8IgiULxbPTsVEPVoGIRuhrUYjkT5TRrNCwR19p5k2CryBQl
         fsQRJXvVHoHwg==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230918205037.25658-1-quic_nitirawa@quicinc.com>
References: <20230918205037.25658-1-quic_nitirawa@quicinc.com>
Subject: Re: [PATCH V4 0/2] Add Phy Configuration support for SC7280
Message-Id: <169530656019.106263.17026016793514428546.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 02:20:35 +0530, Nitin Rawat wrote:
> This patch adds Phy configuration support for Qualcomm SC7280 SOC.
> 
> Changes from v3:
> - Addressed dmitry comment to update correct binding for clk entry
> 
> Changes from V2:
> - Addressed Vinod comment to replace upper case character with lower case
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
      commit: 79eeac2e262545077be482b1a1700669e0c7d90c
[2/2] phy: qcom-qmp-ufs: Add Phy Configuration support for SC7280
      commit: 8abe9792d1ff7e60f911b56e8a2537be7e903576

Best regards,
-- 
~Vinod


