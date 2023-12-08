Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD780A620
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574172AbjLHOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574102AbjLHOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29461BCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F7DC433CA;
        Fri,  8 Dec 2023 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047079;
        bh=DICmne1+Q4nMyRwTfcHeDogcRF43p5yY2id5Vrnb/XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5wMjlh+PGVBUiTkQ0RMfG8ox0WL+KmWtv+R8ufM19UUH15cBFAyeD1wN8x6fbdNX
         yWA04Gs8QrcIkiYU9BhuhaJWcfL18XyoYPiJaJbOfAJDRcpUzTfPqz0CQNoL36N3Xe
         d9hPy4yI0/TIvN2TBgrdOeefMG5b5iFPDpAT/9kEcKifbmuEYK2hnNzdgT8TIqJ0lq
         4Qq2vV66uScCsc2aq4yFCknHSRy0Iv3AaYCTdC8eCcYq9sBuuzGAeuDpMqsYXYLZhi
         eNeMAU6E7rJ8fAEyGZbmJGB6N00Z6jIcikO7NKvA0l7A2FnSPp8HBJBvSHEmPYY8ag
         2Oyfy63BYquBw==
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
Subject: Re: [PATCH v2] dt-bindings: firmware: qcom,scm: document SM8650 SCM Firmware Interface
Date:   Fri,  8 Dec 2023 06:55:28 -0800
Message-ID: <170204733608.342318.8817176141039380578.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org>
References: <20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org>
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


On Wed, 25 Oct 2023 10:21:56 +0200, Neil Armstrong wrote:
> Document the SCM Firmware Interface on the SM8650 Platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: qcom,scm: document SM8650 SCM Firmware Interface
      commit: 6da02af3f910bbcdd2914050cfcab1a9d7980494

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
