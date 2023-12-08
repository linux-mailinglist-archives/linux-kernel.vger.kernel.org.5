Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08B580A60B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574080AbjLHOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574064AbjLHOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1C19A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB36C433C7;
        Fri,  8 Dec 2023 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047074;
        bh=2OFxvrVXGN3ju31vhdzIuWPoAM2PcgOtVQ/mUI2wJ2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAQqTPLhUn0FzfxNVixNLUZSYYPRiK5nU/3bIrkwuCOrCNMI7IdP7Wocx2iEn8Uds
         K9pXQNXLRF3B7bNowd7V8o1O9fv9lvza068RH3fz2jVFQEJAQY/lJ8bJ8vVwoG5DSG
         0Frl1ntKd502RJ2GibdoBKMrhPYjaYtvEo07/aIudWQfQJ0QrxDf63oArldYqBFZx3
         kv66UvRwQes1guDauKxLsQdjDjBhTsiThJuh1EzYS/p94qMjMuRbwLn+b46MXcWc0i
         vjjbIRHy4+KweBfBKv/ZGvMdgQsmkzqDUVvLbWjgZEP/+zNo5lYRB8h0AxXKdz8Ylt
         Wy7wuLumn7vug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: qcom,scm: document SM8560 SCM Firmware Interface
Date:   Fri,  8 Dec 2023 06:55:23 -0800
Message-ID: <170204733608.342318.3156607162293538559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-scm-v1-1-f687b5aa3c9e@linaro.org>
References: <20231025-topic-sm8650-upstream-bindings-scm-v1-1-f687b5aa3c9e@linaro.org>
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


On Wed, 25 Oct 2023 09:29:17 +0200, Neil Armstrong wrote:
> Document the SCM Firmware Interface on the SM8650 Platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: qcom,scm: document SM8560 SCM Firmware Interface
      commit: 6da02af3f910bbcdd2914050cfcab1a9d7980494

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
