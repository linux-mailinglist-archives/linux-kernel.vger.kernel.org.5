Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5857080A635
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574118AbjLHOwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574183AbjLHOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:52:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6E1FE8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7495C433C8;
        Fri,  8 Dec 2023 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047088;
        bh=oZazlu35FGl33bAmgGLk0gjDXlFaLMKUUL6nhzMSGko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMyGGvr8nnocoVdTTf7cH1BT/N0uoRTUIVKR8Vj/O99E/XXj/QWf5IKxFNWxgeXTp
         SOVqEb6FRxbggOnwhVVg5yeFqhWw+GLIDhdv2hHQvSj9OcmfbWUbHsTBqk34YjBsrh
         geYE/fEl6O1ozpsLaUMQvOInB3fKxlrzZx5h1npblP+/l60Q0bV9WUfBBRwmHPwUZR
         5O92m/ScT8bvjh/dytXBTfhMtqALe4vl6FAvjwaB23y5JlWNJdyXqwpr1ot6DYR2B/
         f872WxhQJADs1kB+w1YrFQEoHLD6F3BSfCh/Lik8d0A1dRDqJd/zRoam1892TPqhUl
         TSQzyOzP6XuzA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, vkoul@kernel.org, quic_gurus@quicinc.com,
        quic_rjendra@quicinc.com, abel.vesa@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        iommu@lists.linux.dev, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
Subject: Re: (subset) [PATCH V3 0/5] dt-bindings: Document gpi/pdc/scm/smmu for X1E80100
Date:   Fri,  8 Dec 2023 06:55:35 -0800
Message-ID: <170204733628.342318.12423965421675968471.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
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


On Fri, 24 Nov 2023 15:36:03 +0530, Sibi Sankar wrote:
> This series documents gpi/pdc/scm/smmu/soc for the Qualcomm X1E80100
> platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied, thanks!

[4/5] dt-bindings: firmware: qcom,scm: document SCM on X1E80100 SoCs
      commit: 696945e427e63ebbabad656893fb82da1ee2a980

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
