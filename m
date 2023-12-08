Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA480A62F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574077AbjLHOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574092AbjLHOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27F1FCC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F9C433CA;
        Fri,  8 Dec 2023 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047085;
        bh=hNZjQ8qcDkauJDqxcLLqCSBo8RI3dmQ4UqI8UDA79Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7X1ftpbVkWuVF10k7mILfvrWf7WwPk+6shvkYw69Ozz8LUSL3MPIyZawb+RmhzgX
         B519yv5wr6P1d/Du/QCsgxKMgDrjcHeZ1kpVfS2EZ8zsbFvhmHeCeXBc7vDL39iXCA
         68sDhqxR9dovec17eZF7z2fJ5lqnghzK/JGJa75CywBdmikIU9nbdc93oiVtJ8lz3t
         LdNP/M/GKeORcq6vaKeZ1+Fyi/LpJG47f6YOQa8tJCBajp1pV7Bpo3worNwPVKfqcZ
         Tkq8XD2C9UHAAlgO50Ry73JqEUsczUvuywIao62MENbS8uxiE6lvUE6xU1+oeO1w9s
         CmZ/foz27+Qlw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V2 0/2] cache: qcom,llcc: Add llcc support for X1E80100
Date:   Fri,  8 Dec 2023 06:55:33 -0800
Message-ID: <170204733623.342318.1278236860389654377.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117095315.2087-1-quic_sibis@quicinc.com>
References: <20231117095315.2087-1-quic_sibis@quicinc.com>
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


On Fri, 17 Nov 2023 15:23:13 +0530, Sibi Sankar wrote:
> This series adds llcc support for the Qualcomm X1E80100 platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> v2:
> * Update the part number from sc8380xp to x1e80100.
> * Pickup Rbs.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: cache: qcom,llcc: Add X1E80100 compatible
      commit: e9ceb595c2d30edb2879f173f8d0dbbedd5e301c
[2/2] soc: qcom: llcc: Add configuration data for X1E80100
      commit: b3cf69a43502a8836b6d615c8aba05b88f00d8d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
