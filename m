Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384658099DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573194AbjLHCyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573080AbjLHCxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE81733
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE7BC433C9;
        Fri,  8 Dec 2023 02:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004018;
        bh=5PzZc1At9JCfV8L5kU1OjcOkl+rwKXg4LIazGQxqucw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muhlXF5qYx6lmCMc+z6x60f2jQ5uUutRwH0eXLZSwHWQKQL+fUFe/ZncRbMiBvx8+
         aP33IA/EQHd1Hoa9ya5lpBO/5NSCOhVhgBrpH6SOWwmeRKHVAgm/7kJ2+uJxRJUAIF
         kGYdTPv4QZIMl9/4s55g2j/3VmRZ7Jz/YpPIG/FCIZXD+ifQUDcokFPOTmLQBnWFw8
         m44gVfPD76J0MzAvoo6Bb16O7EEEsd/p3fRNFtUHwau2ttl6eJn1dZrrJxm5k8F5bH
         SO61I1CAc6XMTgTkYNopjFu3FH0pn5c+C2VBH+iVxel+wNSPciULLctvXcR9ztfK3G
         6nSQIc2jbCAkw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: fix soundwire controllers node name
Date:   Thu,  7 Dec 2023 18:57:42 -0800
Message-ID: <170200426914.2871025.16959172991938976947.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106-topic-sm8450-upstream-soundwire-bindings-fix-v1-1-41d4844a5a7d@linaro.org>
References: <20231106-topic-sm8450-upstream-soundwire-bindings-fix-v1-1-41d4844a5a7d@linaro.org>
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


On Mon, 06 Nov 2023 16:58:33 +0100, Neil Armstrong wrote:
> Fix the following dt bindings check:
> arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: soundwire-controller@31f0000: $nodename:0: 'soundwire-controller@31f0000' does not match '^soundwire(@.*)?$'
>         from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: fix soundwire controllers node name
      commit: 11fcb81373de52eeb1d3ff135a8d24a4b18978d3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
