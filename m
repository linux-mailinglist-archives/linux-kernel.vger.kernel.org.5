Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD8E7523D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjGMNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjGMNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BAE2710;
        Thu, 13 Jul 2023 06:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 386CC61539;
        Thu, 13 Jul 2023 13:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A80AC433C8;
        Thu, 13 Jul 2023 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255112;
        bh=kDqyhAfS9XUXKTxzPbEBXYhWeZzsQ55VR5dfmVW+TtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUdMt9G2FTbnLnUp51e5nireN0q+FYd/sBK14y8p61b1KOJPTKqWZt33VERKsb07B
         kn5hxcEuoEcm1jbfpC38pJfFIbUKfv2OkK5QvOdGo33qmjgnygl7m+1BYcL6HQtqIR
         XuzywG3NMc4GA9jepn4Ok484p7qiNd6WS2NzH6quV9o5CYj8ZR2DuIUDx0Wyu5Hbd+
         Bssk/q+/6bnx6zwxKewut64wJVST1EyOQBV8+y+2DQcKMV5uP5QrX3dy5KmhQ9ryTO
         CoP/PRMRKM+p807RQQaygQJxb/JXxaXl3/D0UtsImLcyvqUfigbFMw4tPyukT0aJru
         TlcY/khoaCWMg==
Date:   Thu, 13 Jul 2023 14:31:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: mfd: Add compatible for pmx75
Message-ID: <20230713133145.GR10768@google.com>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-6-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688395346-3126-6-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Rohit Agarwal wrote:

> Add compatible for pmic pmx75 used in Snapdragon series.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
