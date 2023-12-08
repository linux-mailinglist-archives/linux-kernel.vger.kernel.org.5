Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B0780A614
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574162AbjLHOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574049AbjLHOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFCF19B4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E236DC433D9;
        Fri,  8 Dec 2023 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047076;
        bh=WnmqcMPpVIektD3QGorz6YQXFsBIVPz0fTyEU6733OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4DnV1nbIM+icwnNCABoVOMtKtP3Po6RaN2cFNS8rc0mO8e2pjpYGVvxMUfklKPgu
         ChJgPoaCwm/AMZ69YD18bBcbQhJG+qL3HCX1yz2cX0BokD6EayFtRvfd0TyvPIcAhe
         /5ye6bpuH6X19/D3FZYzrOmYwdaV/dN2E6eclZ2kaq7RE/Qkf0GE/KV/C05MohZc5d
         EMAxSu9F9BMvVYQRsisWl/gUSzmm7WMCQzL0P+qdmGiIx5zO1XrQZgCYoyxIxlNILi
         q67YFNtsDdzwtrHcJvGxbM31aCv5RRebtAj3+oRRgZJRNHuYvlKXMsNv+b+BvPi5bY
         w9TjfSfC4b9qw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: pmic-glink: document SM8650 compatible
Date:   Fri,  8 Dec 2023 06:55:25 -0800
Message-ID: <170204733634.342318.4541849857881584524.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-pmic-glink-v1-1-0c2829a62565@linaro.org>
References: <20231025-topic-sm8650-upstream-bindings-pmic-glink-v1-1-0c2829a62565@linaro.org>
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


On Wed, 25 Oct 2023 09:27:57 +0200, Neil Armstrong wrote:
> Document the PMIC GLINK firmware interface on the SM8650 Platform
> by using the SM8550 bindings as fallback.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: qcom: pmic-glink: document SM8650 compatible
      commit: 98e8bc43c225d77966fde6e0138e3ee307d3c208

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
