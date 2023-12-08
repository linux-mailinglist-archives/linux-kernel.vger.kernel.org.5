Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA280A608
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574131AbjLHOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574057AbjLHOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872B319A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6ACC433C9;
        Fri,  8 Dec 2023 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047073;
        bh=IeciPaIg6PS4Nd89NCbeYUimfqv3vbcKAKqdtLZpbEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9dX4hfaf/yHFs4MtcRyXJ3dYQc8xKSq5SAblD8Hnl4JiT3aR5I4ZXWB4guIh+JLB
         VpnX6+9zKAWr5uWehztbWMd+jfzgglCT1NkxCtFXnJj3ZjnXUoEsy2pxSQXbJ+Oz9U
         Nc0s+JgYfNdLY4jSFNctiHxSRd08TQg6zgxW/dB8gKwFkzjb5pY8rxcl8Sd/xZ+80T
         pxEoJPPiR7bBTIKeM0FdQ+cPIgomgE7lfcx7gFIOfy3c97Y0r5getZlsTv0X5sGSCl
         01aeOTLJpyH/5CxUDLAI5I6xcCKCYS/QvtHzuJIiQ3bAbFg3JaEUPXVxrhthwOetcl
         pWjsXBcIau1bQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: deconfig: enable Qualcomm SM8650 SoC drivers
Date:   Fri,  8 Dec 2023 06:55:22 -0800
Message-ID: <170204733625.342318.16325609104952222149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org>
References: <20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org>
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


On Tue, 21 Nov 2023 10:51:11 +0100, Neil Armstrong wrote:
> Enable Clocks, Pinctrl and Interconnect drivers in the ARM64
> defconfig for the Qualcomm SM8650 SoC to boot the SM8650 MTP
> (Mobile Test Platform) and QRD (Qualcomm Reference Device) boards.
> 
> TCSRCC, GCC, Interconnect, and Pinctrl config are marked as builtin and
> not modules due to boot dependencies.
> 
> [...]

Applied, thanks!

[1/1] arm64: deconfig: enable Qualcomm SM8650 SoC drivers
      commit: 17fc6f391932dfc8c11634667ca2d1d24c961cf5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
