Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F367A6EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjISXEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjISXD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD420C9;
        Tue, 19 Sep 2023 16:03:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDEDC433D9;
        Tue, 19 Sep 2023 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164628;
        bh=BKSCEpcWTMGHY3XimOTfIsJcw1YDM09kC6XQg+YxKRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIje+1moVku665frSsXPDsvLHtTnmT7/r7Q5eGD8IKM8Qw538I6lRqvD1leH+mpLf
         3rg7JUUTBz0ybmbDOjE8QN43rovgQWQUW5yGAKDENFFwGvwSvJDMEarRgXyxrovhh1
         XC0czCu6Wkp2oLC0sxEEMekX7eRn1FBwFuw8fEXUimQNx6ax42VdHZaqT/XYoJjnKk
         ztie/zPGruKuxRX3lQALSv2zMrG6QpQGWObXGskdcLxB0wKhh8VINMwQco1Cqck4Yi
         J8fJxblgpUKy2Lph1XhwuElYfGBgWyZacUrs1YHhmSXRMcScWkZTCEJJNe5wLedRVL
         Xd/rYP1X3x8IA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add SM8350 LPASS TLMM
Date:   Tue, 19 Sep 2023 16:07:37 -0700
Message-ID: <169516485987.787935.2244475537859107114.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
References: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 21:20:56 +0200, Krzysztof Kozlowski wrote:
> Add bindings for pin controller in SM8350 Low Power Audio SubSystem
> (LPASS).
> 
> 

Applied, thanks!

[3/3] arm64: defconfig: enable Qualcomm SM8350 LPASS pinctrl
      commit: 7a9d9ee88cdb25d6241021317bcb3874d0fa7153

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
