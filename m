Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F87A712E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjITDzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjITDy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:54:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4AAC;
        Tue, 19 Sep 2023 20:54:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E7C433C8;
        Wed, 20 Sep 2023 03:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182092;
        bh=3IRCJf0ccugOUjQJbQwxlzPXVo7KyDJmsjRA5c397w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUyX08fcJRohROe49y/WU+4Mydk9L+xTjT2nnRhQD63tIhIxzA0aAXqhAdzD2RfwP
         EuASCqYeRiviRffjqEC7/K0Tbu55k8FeLG/A27kAZ8w5YkV0Zsxd4l6UmodZd4Fh4c
         E5hhIWywl0871SOJq9t0rocMlzWx/gDE0eCi1/y24f//gL2HzhaJ1nE0HUVYW7bUvY
         bVJd1/GsdL4+CSsN7seUdIdfH674NGS2lf/nG2jGSs9f3zhF6DtqX46Yu8pW8INFPK
         I+fDpS3EvShhTPUDuO9c5pYQ5rLVXul3v4ZRc+zSfLnFs0I9C3HxwoB/F7mgZeFIMk
         Yz6rtuyNZffOw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@bgdev.pl
Subject: Re: [PATCH 0/2] sa8775p-ride: Describe ethernet phy IRQs
Date:   Tue, 19 Sep 2023 20:58:43 -0700
Message-ID: <169518233710.1055386.13087673777610760189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230817213815.638189-1-ahalaney@redhat.com>
References: <20230817213815.638189-1-ahalaney@redhat.com>
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


On Thu, 17 Aug 2023 16:37:15 -0500, Andrew Halaney wrote:
> Now that the hardware can detect the IRQs, let's describe them instead
> of polling the phys
> 
> Andrew Halaney (2):
>   arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy0 irq
>   arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1 irq
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy0 irq
      commit: 1ff6569b0ffe7a2e311104cb3cd841983e484ac9
[2/2] arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1 irq
      commit: 454557d0032d088b4f467f0c541f98edb01fe431

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
