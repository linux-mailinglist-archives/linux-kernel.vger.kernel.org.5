Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C06802105
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjLCEyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjLCExW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:53:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C54210C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FBCC433B8;
        Sun,  3 Dec 2023 04:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579125;
        bh=M4xkuJe3k5E0eNvrVJw+MYeOpXAqlbo3VFnwIeWclkw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CNhm4ApF6TiLWkFIUYE8FNFk5ML+35VDPBHMQtY1YOUR+5G0/a7U9A+ZG5/lBYTbh
         bOxMbLjWf7wWWVgtC4iAvthUYYMVTjY7ddGEqBmJEbWzhUjDIOAfHdwGN4y8VmV+Qq
         8J0+ob/7C2378CgH7gyWszwm83q48r7HtWsoJ36rCgk/jYNZh+BTFp4cWuAHET8vZF
         8I89njKAHyoWRJuc/Jfn4zC5LSyMnEGor4trpx20Vvu24/vTpkhjaw3uEbRTotYBLp
         PVTbMP/xAe0A6wiuI3eNaoj4JV0qdlF30Vs9/2ua4CVM6dUbv41P3NgYeqHgkOnncs
         /lYiImZDc1g3A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sridharan S N <quic_sridsn@quicinc.com>
Subject: Re: [PATCH] dt-bindings: arm: qcom: drop the IPQ board types
Date:   Sat,  2 Dec 2023 20:54:51 -0800
Message-ID: <170157925794.1717511.4625471524765370512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927093130.4098385-1-quic_sridsn@quicinc.com>
References: <20230927093130.4098385-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 15:01:30 +0530, Sridharan S N wrote:
> IPQ bootloaders do not need these information to select the
> the DTB blob. So dropping the board names from board section.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: qcom: drop the IPQ board types
      commit: 14259fcdaf72d3ce93ad9c2b12cc0e96ed5a0c4e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
