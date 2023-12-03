Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0AA8020FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjLCExB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjLCEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDE19A0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D63BC433CB;
        Sun,  3 Dec 2023 04:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579118;
        bh=tpslFBFUdoUYnmtU0ha+7cWVGnpRVis8xcl35eJNYRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWQUQqqlFuCzGgB4OUGFfZcsAXxVe3bpeoLJjZ9UVjzfUBjgUgDE+Q5AirQDIhCRA
         8vC6N9fYnWV8z5qe33y71O+/AIHIxXGJNLP9zsbDWjKHpeLFxItst3HovbqBD8yzXM
         oIoZTvPuEScw4CvRmN6RzfOnARv0/KSh8q5iVn89DZyqyJWBnODLMSWconIjaLpwWO
         cUq1T25ntgxwKs9NrB3LlunsYbtOESTW0QN/nDvRBd+k6KAQrVPRN0ntfdurx5Wo04
         42kI5pMbq8ERjdV1Pe0oTIW85o2BNshKdTm0q5i2zsFEzHeEO4B0nanONrKBo3IsRQ
         mu34Lga2xkqIA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Walter <lukas.walter@aceart.de>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5 (2016)
Date:   Sat,  2 Dec 2023 20:54:45 -0800
Message-ID: <170157925830.1717511.2933416466366395463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231021143025.77088-1-lukas.walter@aceart.de>
References: <20231021143025.77088-1-lukas.walter@aceart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Oct 2023 16:30:24 +0200, Lukas Walter wrote:
> Add a compatible for Huawei Honor 5X / GR5 (2016).
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5 (2016)
      commit: 01a3c3739183003640f8468ecf75d7eeb15f808a
[2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial device tree
      commit: cff9a76f306bfb6262153c0da2029071036b9a04

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
