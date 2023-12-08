Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D780A610
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574149AbjLHOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574068AbjLHOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E41999
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01121C43397;
        Fri,  8 Dec 2023 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047075;
        bh=ixnZw9Pfic/HpM05X3/v6NL62exJ9aOzdidCODnBIgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKAIE8mDbVDpDov2S+joCY/+0dp2s21NT3w5OfyaVKMCBrLHbaDeI3NJorGdmVI2O
         1Fk7/JH1X0SrMwnZgR9zUcXW3Fbk+GeFIvF7ep2GVXlfyXGA3wj8on06r2mypyEEYY
         6rjHDif/ZP093nYw8Q4WDWTfvYa7GPh0nuSVdjfOi+dQppbcm+dZY02aPQjkl68ITl
         JkxfMp3ynNk6tkU7csXftvLJc4FYXZiFSRy5rkCp7S9Ue/B3Lsj/X1D9wSVk4ZezfK
         z4I3EnGxbzV5mFTDKKLKJIyvlN/uIleKBr4QXKqKPSuv1Mn8wTlQ+yIhSpntN708H/
         DNYrVpxsCedtA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom,aoss-qmp: document the SM8560 Always-On Subsystem side channel
Date:   Fri,  8 Dec 2023 06:55:24 -0800
Message-ID: <170204733607.342318.965190606909408410.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-aoss-qmp-v1-1-8940621d704c@linaro.org>
References: <20231025-topic-sm8650-upstream-bindings-aoss-qmp-v1-1-8940621d704c@linaro.org>
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


On Wed, 25 Oct 2023 09:18:27 +0200, Neil Armstrong wrote:
> Document the Always-On Subsystem side channel on the SM8650 Platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: qcom,aoss-qmp: document the SM8560 Always-On Subsystem side channel
      commit: 8c1f28ff1356dd1f0ede9b378c9dadbfa7539187

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
