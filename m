Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E27D281D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjJWBmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjJWBmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:42:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3530F7;
        Sun, 22 Oct 2023 18:42:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BE7C433C8;
        Mon, 23 Oct 2023 01:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698025361;
        bh=jNTnqKIA9zSEXZ2g2t8trq95ee1lqOdZ++9oTgWdJkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4ifp8izwADeCTvVUcbR92whapYaa7T10OSUuU4jZgOeRSn7Vj9NfEmQtSw5LC0MC
         3pKql3qzG6fN218JAjqc3wQKx/DsO33A0nk6c0xpINN2alcnYaFe+VpZUbLHpL/maK
         xccEFBCo+t1HivNIlGCAiOaDgb6JVfICGBY7F4jC9wFw20FS/N1qfKV4z7z8+WkxRW
         Sxpi27MZ59secb3vJ22w9vD09b9qXoZQS13vGUHmQ1Zl4gqDLi0uHZ9RZOy8DyJV4U
         1Khs1YOXcn4kUALdtxIlYo1PebV717aTPbTImepz1ZyQuTFe9bCkuxPAYeYt2BDykK
         4yJRBwLBMFwVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, Rayyan Ansari <rayyan@ansari.sh>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v3 0/6] Initial support for MSM8x26 Lumias
Date:   Sun, 22 Oct 2023 18:47:02 -0700
Message-ID: <169802554634.845827.17802503631403350590.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930221323.101289-1-rayyan@ansari.sh>
References: <20230930221323.101289-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Sep 2023 23:07:55 +0100, Rayyan Ansari wrote:
> The following patches:
> - Add device tree files for Nokia/Microsoft Lumia phones based around
>   the MSM8x26 family of Qualcomm chipsets, utilising a common tree
> - Document this support
> 
> v1: https://lore.kernel.org/linux-arm-msm/20230811213728.23726-1-rayyan@ansari.sh/
> v2: https://lore.kernel.org/linux-arm-msm/20230813152623.64989-1-rayyan@ansari.sh/
> 
> [...]

Applied, thanks!

[2/6] ARM: dts: qcom: add common dt for MSM8x26 Lumias along with Nokia Lumia 630
      commit: 244281556a11549501eb5093e9ab0ad8a87b7d4f
[3/6] ARM: dts: qcom: add device tree for Microsoft Lumia 640
      commit: 45dbc34693e8ad30c33edfdc94acaf4672de0e24
[4/6] ARM: dts: qcom: add device tree for Microsoft Lumia 640 XL
      commit: a16f3bcf867efdab422b711b18c023089fbeb96e
[5/6] ARM: dts: qcom: add device tree for Nokia Lumia 735
      commit: 00400a98b2c3fd5d497635747fec4b882299bc05
[6/6] ARM: dts: qcom: add device tree for Nokia Lumia 830
      commit: 8677233e59137f78d4d578f3d5a21557c1bab342

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
