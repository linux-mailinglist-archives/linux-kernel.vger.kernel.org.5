Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A47F5C60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjKWKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjKWKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:33:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D801B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:33:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F56C433C8;
        Thu, 23 Nov 2023 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700735601;
        bh=TNV0MOl+Kv5Rz74vl7zwedVQV2taOHqLyWjOkSFHbWM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BjVlla1UM55SAtrua1lvBQhE9mHUmsjNDz8b//iAYFTi/EbHIQDsjwgjWUi24xkBB
         7eJT0JlWxwfG2KDo/0srVFcWADZm1Spc++jCEuh6xrSbVsQf8+/a7if9SBOks4zvrP
         PawUHN2As03Vg+cAC3tkOo5jazp/5gO5MIMEOJSPh7sigL9n100xSjozgAeEwGBPse
         OOWv8/H7KVjropdbsDEQznxNj9MBlnQHwI+3KEB+k0TwrrIupDSarcnYP4uUce5Ckv
         upyhJB3Aj4m6O/rYxHCimZgOhb+a/0Z4ve+KDWH9lN+pgK91iVMXXgrxBl5ec91J1u
         FltIwtlgA0bMA==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com>
References: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com>
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: mfd: qcom,tcsr: Add
 compatible for sm8250/sm8350
Message-Id: <170073559969.1231386.13642170765193211646.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 10:33:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 22:36:38 +0530, Mukesh Ojha wrote:
> Document the compatible for both sm8250 and sm8350 SoCs.
> 
> 

Applied, thanks!

[1/4] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8250/sm8350
      commit: a88f80580a1a076e69c4fecdf6d6441fac24e8c1

--
Lee Jones [李琼斯]

