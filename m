Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBC7A7136
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjITDzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjITDzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F0C9;
        Tue, 19 Sep 2023 20:54:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6D8C4339A;
        Wed, 20 Sep 2023 03:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182094;
        bh=mICcC6rktU45GhsCDFEsjPe9V0J3ZeBNnG++L2yyG+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0xJzW8pTEsX205JgTNi3Y5RhCcjcS4gUO/A8CtS0ExkGmQ1AyIALtIxrYgphoUE5
         MGj/gKbmP08SFJWg8xotUQG1trs6wFiWS6Cq9qmkOryrhhhztPcsu+FKcORpZ6t/dn
         TMAcmrw/oEATz2XklPYBBeeDJwkRB/YmJgKihgrtUVbNyQTB2CtT7SKJ3XLLM2tKcV
         8cb5Yx1OjgbcFZOQi1SzWwr4eTvJAVf3JjFopnii5jHNV31vVFIjuc3xNXLu2vDvbj
         aiCG1lbSq6uKSvdM3NHhAOWBiXC6PZEc1KNtmAL2wMLxMnnC+RZwEaMnRy4yxuKM5z
         kYRrceeMrUBWQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Wronek <davidwronek@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH v5 0/4] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Tue, 19 Sep 2023 20:58:45 -0700
Message-ID: <169518233715.1055386.5478137137290382412.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824091737.75813-1-davidwronek@gmail.com>
References: <20230824091737.75813-1-davidwronek@gmail.com>
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


On Thu, 24 Aug 2023 11:15:03 +0200, David Wronek wrote:
> This series introduces support for the Qualcomm SM7125 SoC and the
> Xiaomi SM7125 platform.
> 
> 

Applied, thanks!

[1/4] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
      commit: 9b4adf37fdc0ca8cd1d14b4160e2f04b63df98e6
[2/4] arm64: dts: qcom: pm6150: Add resin and rtc nodes
      commit: ec053ec90c245a4efc8dda87d9207de0adf0040e
[3/4] arm64: dts: qcom: Add SM7125 device tree
      commit: 72fbf05149bd451e7222c2ed1e3823972f19df9c
[4/4] arm64: dts: qcom: Add support for the Xiaomi SM7125 platform
      commit: 7d65d4b7d70fb9560ce9baaf4219fb24646bd578

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
