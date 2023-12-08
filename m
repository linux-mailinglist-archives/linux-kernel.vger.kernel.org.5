Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA68099E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573203AbjLHCyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573083AbjLHCxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F71BE6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345B2C433D9;
        Fri,  8 Dec 2023 02:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004018;
        bh=dMsY+JlCA/vYwZc2IufgR8iPGmeZv7mWBL4rpyxPYP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7QvNf94qXenxbnv4BqdXQt6f9g4I41U2sDGjymzYTaNVieLikpOxuW05jk/tXWLx
         q8bih0LwU5tGN26jWA3TiNIwe/iH8AHYRxDn8ahKcp8fAwSU2jJsYF5kKkvIV7hCnY
         30lWwcZhp7MNLXS2gO2KrRT5olHMEd5CkEQfxjC9SpP21uaCCsjUSqfvjIICzMVlnI
         YYwhYoXosc7Qeol6drQxpjgpWx0vPK578iVUqrX3Ziwzgp4FaJA0J8bRYNVAS92tED
         hEOwN46g9jS1FeQOdG3mML/WbQFCPvfSjeC8aHzw0+q075tn6Uii0V6UP/k53UTMkm
         ABl5MCZw3UCSw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: fix soundwire controllers node name
Date:   Thu,  7 Dec 2023 18:57:43 -0800
Message-ID: <170200426914.2871025.828146129351543040.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106-topic-sm8550-upstream-soundwire-bindings-fix-v1-1-4ded91c805a1@linaro.org>
References: <20231106-topic-sm8550-upstream-soundwire-bindings-fix-v1-1-4ded91c805a1@linaro.org>
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


On Mon, 06 Nov 2023 15:23:57 +0100, Neil Armstrong wrote:
> Fix the following dt bindings check:
> arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: soundwire-controller@6ab0000: $nodename:0: 'soundwire-controller@6ab0000' does not match '^soundwire(@.*)?$'
> from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: fix soundwire controllers node name
      commit: 07c88da81caf0e72c3690b689d30f0d325cfeff4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
