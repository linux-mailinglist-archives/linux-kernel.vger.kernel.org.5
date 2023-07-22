Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE4E75DA1E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGVFPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGVFO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F73C0C;
        Fri, 21 Jul 2023 22:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 622C060AB4;
        Sat, 22 Jul 2023 05:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260E7C433C9;
        Sat, 22 Jul 2023 05:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002863;
        bh=umMqVqn2CWRqvWHjKDJRvtHO1+TeEQblbVZVVL/9aVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJvseHnCHlrx2cCmsRq0uQv7jN0vBqgcLZaeiuDV4eWOczTFywjryqyVq+r9kziMC
         BIBwMK5JMzNFSYOIvJ09oMUaatCIinxd8R+tXAbOVrzab0Qsr0NaQBjvusGReYSiat
         AtcvHDFUroWP1dSrcs31tk9QTv5CSIm9R7i3iRUkkr3GCbS2r9ojcRclvGmyJbQUST
         WO4t94brQ1uvam+hm65YHaikgKX6HSFyybOn+YTcEIaaGTcYd8qqp7bwzbqc63pvtC
         XBKYH2Vw6OrPLIv/Ltjw1aUKZ7KMMxRdD41g1GIVOEj45xhYJbu44EVriK/EKYSbsp
         9VOEV1ANjH9IQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: qcom: qdu1000: Update reserved memory region
Date:   Fri, 21 Jul 2023 22:17:21 -0700
Message-ID: <169000304192.3611206.11038507247615407598.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
References: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
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


On Thu, 06 Jul 2023 18:21:27 +0530, Komal Bajaj wrote:
> Update reserved memory region for QDU1000 and QRU1000 SoCs.
> 
> Changes in v3:
>  - Changes the node name as names should reflect the purpose of node.
> 
> Changes in v2:
>  - Changed the node name.
>  - Dropped unnecessary properties.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory region
      commit: d52775a696bca996271fee0d49f138c69ceff93d
[2/2] arm64: dts: qcom: qru1000-idp: Update reserved memory region
      commit: 3d5a9f6d5350a3a4b7f932939d9eb94a15988e0e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
