Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1676F75D9FF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGVFOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGVFON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9819A2;
        Fri, 21 Jul 2023 22:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717D5609FA;
        Sat, 22 Jul 2023 05:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB00C433AB;
        Sat, 22 Jul 2023 05:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002850;
        bh=zwuVY35KmXlsvLhRJrYhNjF1Jegax3V9BNSVgAuUxUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHJBA29c8ML8y5t7uNsDoSuKCfIXRAadAeTjN4DZq7ERclxBYGikylPqqRnPDtiWf
         6pcc8cLlSHSdOW5i2EAPRIoTpuwXZMCumOpwlzq+th7g3Shl/Al07a1Pky/PWAda5P
         A0FZ33XAEIRQEu0cae15FNAgSm9dCR4qmGLdPkjVWjxVySGoV3lqf4sLgIjG4WEEZk
         XesFkZ+hDyn7rtB58e81YSe51ulWbdU/o0cG1obCkQUmzYodoWUE1RCb6Wf1CjnYm0
         DYibqQLNplUyT6H382K1ubVhVvD1HwoIaYkq+xd7wiPFMF71qb0qKTQ0K75uoYeRuM
         V7+RlwBG+KWJA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 0/7] random msm bindings fixes
Date:   Fri, 21 Jul 2023 22:17:09 -0700
Message-ID: <169000304215.3611206.10740642676453482395.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
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


On Mon, 26 Jun 2023 22:00:22 +0200, Konrad Dybcio wrote:
> 


Applied, thanks!

[1/7] dt-bindings: qcom: Allow SoC names ending in "pro"
      commit: e40266d90545ef11f95832177faedf41eadcc453

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
