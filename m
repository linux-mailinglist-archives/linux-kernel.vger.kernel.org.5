Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCB753173
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGNFpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGNFp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59363211C;
        Thu, 13 Jul 2023 22:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E278F61C0C;
        Fri, 14 Jul 2023 05:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CFEC433A9;
        Fri, 14 Jul 2023 05:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689313525;
        bh=c2mEckZvwo14N7trNxL1C24iVTUZzDt1jRZMiYQDuQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1qOzPj11TCBJujmG8cHbTprRRV4bo/tncvX1PAMIiX+Ubkr1S2Y2JM14Ju47GL91
         h+pU0WpdQIabgbYs0vFT4x2d80Jr7Ma7DBG6B9KRHACwqCvFUenTZLozZmO3ThcGmC
         0sY5xSp3f6cmjAyXNCahQuOAmQfxILzhxkofk/V0+4pzpvt//mlryVGvu9yhv9zlw2
         0EvTYKfUflxAlA4DVS+tGTp7csGIwZVoSjrMCY8ueTAce02PXeYDOLKusUppyygKYq
         MVc8ZW2U4QCvGLj5WhTyRHOMRN5YvDXBM3txWkIeM64cW6DiQCJeR0WjC+nhMm5Uqs
         FJEk5dXVERHcA==
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
Date:   Thu, 13 Jul 2023 22:48:52 -0700
Message-ID: <168931373093.1571673.3158979708778276469.b4-ty@kernel.org>
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

[3/7] arm64: dts: qcom: pm6150l: Add missing short interrupt
      commit: 7e1f024ef0d1da456f61d00f01dc3287ede915b3
[4/7] arm64: dts: qcom: pm660l: Add missing short interrupt
      commit: 9a4ac09db3c7413e334b4abd6b2f6de8930dd781
[5/7] arm64: dts: qcom: pmi8950: Add missing OVP interrupt
      commit: 4d77b639531fd85b84a7079c3369908dfaddf8b2
[6/7] arm64: dts: qcom: pmi8994: Add missing OVP interrupt
      commit: 8db94432690371b1736e9a2566a9b3d8a73d5a97
[7/7] arm64: dts: qcom: sc8180x: Add missing 'cache-unified' to L3
      commit: e4322bb818bbcd36b441de9880fa4ac911a5eb51

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
